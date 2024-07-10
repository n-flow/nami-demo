import 'package:get/get.dart';

import '../controllers/capture_photo_controller.dart';

class CapturePhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CapturePhotoController>(
      () => CapturePhotoController(),
    );
  }
}
