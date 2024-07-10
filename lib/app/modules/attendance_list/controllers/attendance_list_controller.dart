import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:smart_attend/app/data/local/models/courses.dart';
import 'package:smart_attend/app/data/network/models/request/courses_request_list.dart';
import 'package:smart_attend/app/data/network/models/request/specific_courses_request_list.dart';
import 'package:smart_attend/app/modules/base_get_x_controller.dart';
import 'package:smart_attend/app/utils/extensions/dart_scope_functions.dart';
import 'package:smart_attend/app/utils/extensions/data_type_extension.dart';
import 'package:smart_attend/app/utils/logger.dart';
import 'package:smart_attend/app/utils/utils.dart';

class AttendanceListController extends BaseGetXController {
  final String tag = "AttendanceListController";

  var dropdownValue = 'Last 30 Days'.obs;

  var selectedItem = Rxn<String>();

  var courseList = <Courses>[].obs;
  var selectedCourse = getCoursesList().first.obs;

  final List<String> dropdownItems = [
    'Last 30 Days',
    'Last 7 Days',
    'Last Year',
    'All Time',
  ];

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      Map arg = Get.arguments;
      if (arg.containsKey("selectedCourse")) {
        selectedCourse.value = Courses.fromJson(arg["selectedCourse"]);
        selectedCourse.refresh();
      }
    }

    listenEvents();
    getAttendanceListForCourse();
    selectedItem.value = dropdownItems.first;
    selectedItem.refresh();
  }

  void updateSelectedItem(String? newValue) {
    var days = 30;
    if (!newValue.sIsNullOrEmpty && newValue != selectedItem.value) {
      if (newValue == 'Last 30 Days') {
        days = 30;
      } else if (newValue == 'Last 7 Days') {
        days = 7;
      } else if (newValue == 'Last Year') {
        days = 365;
      } else if (newValue == 'All Time') {
        days = 365 * 12;
      }

      getAttendanceListForCourse(days: days);
      selectedItem.value = newValue;
    }
  }

  void listenEvents() {
    socket.setCallBack(tag, (data) async {
      Log.i("$tag:   ${data.eventName.equalsIgnoreCase("attendance_course_processed")}");
      if (data.eventName.equalsIgnoreCase("attendance_course_processed") ==
          true) {
        if (data.eventError.sIsNullOrEmpty == true) {
          var cList = <Courses>[];
          data.eventData.forEach((data) {
            cList.add(Courses.fromJson(data));
          });
          courseList.value = cList;
          courseList.refresh();
          Log.i("getAttendanceListForCourse:  ${jsonEncode(courseList)}");
        } else {
          showSnackBar(
              message: data.eventError?.toString() ?? "Something went wrong");
        }
      } else if (data.eventName.equalsIgnoreCase("attendance_processed") ==
          true) {
        if (data.eventError.sIsNullOrEmpty == true) {
          var cList = <Courses>[];
          data.eventData.forEach((data) {
            cList.add(Courses.fromJson(data));
          });
          Log.i("getTodayAttendance:  ${jsonEncode(cList)}");
          cList
              .firstWhereOrNull((element) =>
                  element.courseId == selectedCourse.value.courseId)
              ?.let((it) => selectedCourse.value = it);
          selectedCourse.refresh();
        } else {
          showSnackBar(
              message: data.eventError?.toString() ?? "Something went wrong");
        }
      }
    });
  }

  void getTodayAttendance() {
    var cList = <Courses>[];
    cList.add(selectedCourse.value);
    socket.emmitEvent('get_today_attendance',
        CoursesRequest(getCurrentUser()?.userId ?? "", cList).toJson());
  }

  void getAttendanceListForCourse({int days = 30}) {
    socket.emmitEvent(
        'get_attendance_for_course',
        SpecificCoursesRequestList(
                getCurrentUser()?.userId ?? "", days, selectedCourse.value)
            .toJson());
  }

  void refreshList() {
    Timer(const Duration(seconds: 1), () {
      getTodayAttendance();
      getAttendanceListForCourse();
    });
  }

  @override
  void onResumed() {
    super.onResumed();
    refreshList();
  }

  @override
  void onClose() {
    socket.removeCallBack(tag);
    super.onClose();
  }
}
