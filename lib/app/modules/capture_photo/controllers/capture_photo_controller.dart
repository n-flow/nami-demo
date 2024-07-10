import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:smart_attend/app/data/local/models/courses.dart';
import 'package:smart_attend/app/modules/base_get_x_controller.dart';
import 'package:smart_attend/app/modules/capture_photo/data/face_detector_painter.dart';
import 'package:smart_attend/app/routes/app_pages.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/utils/extensions/data_type_extension.dart';
import 'package:smart_attend/app/utils/logger.dart';
import 'package:smart_attend/app/utils/widgets/dialogs/app_warning_dialog.dart';

class CapturePhotoController extends BaseGetXController {
  CameraController? controller;
  List<CameraDescription> cameras = [];
  Rx<CustomPaint?> customPaint = const CustomPaint().obs;
  Future<void>? initializeControllerFuture;
  late FaceDetector faceDetector;
  var isDetecting = false.obs;
  var initializedController = false.obs;
  var faceCapturePercentage = 0.0.obs;
  List<String> paths = [];

  var selectedCourse = getCoursesList().first.obs;

  var viewStates = <AppLifecycleState>[];

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
    faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: true,
        enableLandmarks: true,
      ),
    );

    if (Get.arguments != null) {
      Map arg = Get.arguments;
      if (arg.containsKey("selectedCourse")) {
        selectedCourse.value = Courses.fromJson(arg["selectedCourse"]);
        selectedCourse.refresh();
      }
    }
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[1], ResolutionPreset.high);
    initializeControllerFuture = controller!.initialize();
    initializeControllerFuture?.then((value) {
      controller!.startImageStream((image) async {
        if (!isDetecting.value) {
          isDetecting.value = true;
          await processImage(image);
          isDetecting.value = false;
        }
      });
    });
    initializedController(true);
    if (!Get.isSnackbarOpen) {
      update();
    }
  }

  @override
  void onClose() {
    controller?.dispose();
    faceDetector.close();
    super.onClose();
  }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  Future<void> processImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes
        .done()
        .buffer
        .asUint8List();

    final sensorOrientation = cameras[0].sensorOrientation;
    InputImageRotation? imageRotation;
    if (Platform.isIOS) {
      imageRotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
      _orientations[controller!.value.deviceOrientation];
      if (rotationCompensation == null) return;
      if (cameras[0].lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      imageRotation =
          InputImageRotationValue.fromRawValue(rotationCompensation);
      // print('rotationCompensation: $rotationCompensation');
    }

    final InputImageFormat inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
            InputImageFormat.nv21;

    final planeData = image.planes.first;

    final Size imageSize =
    Size(image.width.toDouble(), image.height.toDouble());
    final inputImageData = InputImageMetadata(
      size: imageSize,
      rotation: imageRotation!,
      format: inputImageFormat,
      bytesPerRow: planeData.bytesPerRow,
    );

    final inputImage =
    InputImage.fromBytes(bytes: bytes, metadata: inputImageData);
    final faces = await faceDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        CameraLensDirection.front,
      );
      customPaint.value = CustomPaint(painter: painter);
    } else {
      customPaint.value = null;
    }

    if (faces.isNotEmpty && faceCapturePercentage.value <= 100) {
      double totalFaceArea = 0;
      for (Face face in faces) {
        totalFaceArea += face.boundingBox.width * face.boundingBox.height;
      }
      double imageArea = (image.width * image.height).toDouble();
      var path = await captureImage(paths.length);
      if (!path.sIsNullOrEmpty) {
        paths.add(path!);
        faceCapturePercentage.value += (totalFaceArea / imageArea) * 100;
      }
      Log.i(
          "faceCapturePercentage:  ${faceCapturePercentage
              .value}   Paths:  $paths");
    }
  }

  Future<String?> captureImage(int index) async {
    try {
      await initializeControllerFuture;
      final path = join(
        (await getTemporaryDirectory()).path,
        'captured_$index.png',
      );

      await controller!.takePicture();
      return path;
    } catch (e) {
      e.printError();
      return null;
    }
  }

  void markAttendance() async {
    selectedCourse.value.attendanceDate = DateTime.now().millisecondsSinceEpoch;
    selectedCourse.value.isAttendance = true;
    getBack(result: selectedCourse.toJson());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    Log.i("didChangeAppLifecycleState:  ${state.name}");
    viewStates.add(state);
    if (state == AppLifecycleState.resumed) {
      if (viewStates.any((element) => element == AppLifecycleState.paused)) {
        openFlaggedPopup();
      }
      viewStates.clear();
    }
  }

  @override
  void onPaused() {
    super.onPaused();
    isDetecting.value = true;
    faceCapturePercentage.value = 0;
  }

  void openFlaggedPopup() async {
    isDetecting.value = true;
    faceCapturePercentage.value = 0;

    var closed = await showAppWaningDialog(Get.context!, "Your attendance has been Flagged!", "“Your app moved in background during the process”", "Retry", 100);
    if (closed) {
      faceCapturePercentage.value = 0;
      paths.clear();
      faceCapturePercentage.refresh();
      isDetecting.value = false;
    }
  }
}