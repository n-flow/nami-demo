import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:smart_attend/app/data/local/models/courses.dart';
import 'package:smart_attend/app/data/network/models/request/courses_request_list.dart';
import 'package:smart_attend/app/modules/base_get_x_controller.dart';
import 'package:smart_attend/app/utils/extensions/data_type_extension.dart';
import 'package:smart_attend/app/utils/logger.dart';
import 'package:smart_attend/app/utils/utils.dart';

class HomeController extends BaseGetXController with GetTickerProviderStateMixin {
  final String tag = "HomeController";

  late AnimationController markAttendanceAnimationController;
  late Animation<Offset> markAttendanceSlideAnimation;
  late Animation<double> markAttendanceFadeAnimation;

  late AnimationController courseListAnimationController;
  late Animation<Offset> courseListSlideAnimation;
  late Animation<double> courseListFadeAnimation;

  var courseList = getCoursesList().obs;
  var selectedCourse = getCoursesList().first.obs;

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

    courseListAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    courseListSlideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: courseListAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    courseListFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: courseListAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    markAttendanceAnimationController.forward();
    courseListAnimationController.forward();

    listenEvents();
    getTodayAttendance();
  }

  void listenEvents() {
    socket.setCallBack(tag, (data) async {
      if (data.eventName.equalsIgnoreCase("attendance_processed") == true) {
        if (data.eventError.sIsNullOrEmpty == true) {
          var cList = <Courses>[];
          data.eventData.forEach((data) {
            cList.add(Courses.fromJson(data));
          });

          cList.asMap().forEach((key, value) {
            var index = courseList
                .indexWhere((element) => element.courseId == value.courseId);
            if (index != -1) {
              courseList[index] = value;
            }
          });

          selectedCourse.value = courseList.firstWhere(
              (element) => element.courseId == selectedCourse.value.courseId);

          courseList.refresh();
        } else {
          showSnackBar(
              message: data.eventError?.toString() ?? "Something went wrong");
        }
      }
    });
  }

  void getTodayAttendance() {
    socket.emmitEvent('get_today_attendance',
        CoursesRequest(getCurrentUser()?.userId ?? "", courseList).toJson());
  }

  @override
  void onClose() {
    courseListAnimationController.dispose();
    markAttendanceAnimationController.dispose();
    socket.removeCallBack(tag);
    super.onClose();
  }

  @override
  void onResumed() {
    super.onResumed();
    Log.i("onResumed:");
    getTodayAttendance();
  }
}
