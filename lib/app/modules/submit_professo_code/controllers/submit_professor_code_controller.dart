import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:smart_attend/app/data/local/models/courses.dart';
import 'package:smart_attend/app/data/network/models/request/mark_attendance_request.dart';
import 'package:smart_attend/app/modules/base_get_x_controller.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/utils/extensions/data_type_extension.dart';
import 'package:smart_attend/app/utils/logger.dart';
import 'package:smart_attend/app/utils/utils.dart';
import 'package:smart_attend/app/utils/widgets/dialogs/app_warning_dialog.dart';

class SubmitProfessorCodeController extends BaseGetXController with GetTickerProviderStateMixin {
  final String tag = "SubmitProfessorCodeController";

  var professorCode = "";
  final errorMap = <String, String>{}.obs;

  var selectedCourse = getCoursesList().first.obs;

  late AnimationController markAttendanceAnimationController;
  late Animation<Offset> markAttendanceSlideAnimation;
  late Animation<double> markAttendanceFadeAnimation;

  @override
  void onInit() {
    super.onInit();
    markAttendanceAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    markAttendanceSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: markAttendanceAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    markAttendanceFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: markAttendanceAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    markAttendanceAnimationController.forward();

    if (Get.arguments != null) {
      Map arg = Get.arguments;
      if (arg.containsKey("selectedCourse")) {
        selectedCourse.value = Courses.fromJson(arg["selectedCourse"]);
        selectedCourse.refresh();
      }
    }

    listenEvents();
  }

  void listenEvents() {
    socket.setCallBack(tag, (data) async {
      var isDialogClosed = false;
      if (data.eventName.equalsIgnoreCase("attendance_marked") == true) {
        if (data.errorCode == 1) {
          isDialogClosed = await showAppWaningDialog(Get.context!, "Your attendancewas successfully marked", "", "Done", data.errorCode ?? 0);
          Log.i("closed  $isDialogClosed");
          if (isDialogClosed) {
            getBack();
          }
        } else if (data.errorCode == 100) {
          isDialogClosed = await showAppWaningDialog(Get.context!, "The attendance window for this class is not open yet", "“IF you think this is an mistake,please approach your professor”", "Done", data.errorCode ?? 0);
          Log.i("closed  $isDialogClosed");
          if (isDialogClosed) {
            getBack();
          }
        } else {
          showSnackBar(message: data.eventError?.toString() ?? "Something went wrong");
        }
      }
    });
  }

  bool isValidFields() {
    showLoading();
    errorMap.clear();

    if (!professorCode.equalsIgnoreCase(getCurrentUser()?.professorCode ?? "")) {
      errorMap["professorCode"] = "Professor code not matched.";
    }

    if (errorMap.isEmpty) {
      markAttendance();
    } else {
      hideLoading();
    }

    Log.i("isValidFields:  $professorCode");

    return errorMap.isEmpty;
  }

  void markAttendance() {
    socket.emmitEvent('mark_attendance', MarkAttendanceRequest(getCurrentUser()?.userId ?? "", selectedCourse.value).toJson());
  }

  @override
  void onClose() {
    socket.removeCallBack(tag);
    super.onClose();
  }
}