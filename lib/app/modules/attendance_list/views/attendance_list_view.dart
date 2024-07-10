import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_attend/app/data/local/models/courses.dart';
import 'package:smart_attend/app/modules/base_get_widget.dart';
import 'package:smart_attend/app/routes/app_pages.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/themes/app_text_theme.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';
import 'package:smart_attend/app/utils/date_formats.dart';
import 'package:smart_attend/app/utils/logger.dart';
import 'package:smart_attend/app/utils/utils.dart';
import 'package:smart_attend/app/utils/widgets/app_avatar/app_circle_avatar.dart';
import 'package:smart_attend/app/utils/widgets/app_button/app_button.dart';
import 'package:smart_attend/assets.dart';

import '../controllers/attendance_list_controller.dart';

class AttendanceListView extends BaseGetWidget<AttendanceListController> {
  const AttendanceListView({super.key});

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: wdp(28), right: wdp(28), top: wdp(20), bottom: wdp(0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: hdp(40)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        getBack();
                      },
                      child: Image.asset(
                        Assets.assets_back_arrow_png,
                        width: wdp(48),
                        height: wdp(48),
                      ),
                    ),
                  ),
                ),
                AppCircleAvatar(
                  imgUrl: Assets.assets_user_placeholder_png,
                  width: wdp(80),
                  height: wdp(80),
                )
              ],
            ),
          ),
          SizedBox(
            height: hdp(28),
          ),
          Obx(
            () => Text(
              controller.selectedCourse.value.courseName,
              style: AppTextStyles.base.s38.blackColor.w600.noneDecoration,
            ),
          ),
          SizedBox(
            height: hdp(28),
          ),
          Row(children: [
            Image.asset(
              Assets.assets_ic_location_png,
              width: wdp(32),
            ),
            SizedBox(
              width: hdp(12),
            ),
            Text(
              'LH 121',
              style: AppTextStyles.base.s30.blackColor.w600.noneDecoration,
            ),
            SizedBox(
              width: hdp(28),
            ),
            Image.asset(
              Assets.assets_ic_clock_png,
              width: wdp(32),
            ),
            SizedBox(
              width: hdp(12),
            ),
            Text(
              getDateFormatFromDate(
                  pattern: DateFormats.FORMAT_20.format,
                  dateTime: DateTime.now()),
              style: AppTextStyles.base.s30.blackColor.w600.noneDecoration,
            ),
          ]),
          SizedBox(
            height: hdp(44),
          ),
          Hero(
            tag: "markAttendance",
            child: Center(
              child: AppButton(
                text: "Mark Attendance",
                onPressed: () async {
                  if (controller.selectedCourse.value.isAttendance) {
                    showSnackBar(
                        message: "Attendance already marked",
                        bgColor: AppColors.red);
                  } else {
                    await toNamed(Routes.CAPTURE_PHOTO, arguments: {
                      "selectedCourse": controller.selectedCourse.value.toJson()
                    }).then((value) {
                      toNamed(Routes.SUBMIT_PROFESSO_CODE, arguments: {
                        "selectedCourse": Courses.fromJson(value).toJson()
                      }).then((value) => controller.onResumed());
                    });
                  }
                },
                margin: EdgeInsets.zero,
                color: AppColors.red,
                style: AppTextStyles.base.w700.s28.whiteColor,
                borderRadius: BorderRadius.circular(wdp(16)),
              ),
            ),
          ),
          SizedBox(
            height: hdp(60),
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        'Attendance history and statistics',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles
                            .base.s30.blackColor.w500.noneDecoration,
                      ),
                    ],
                  )),
              SizedBox(
                width: hdp(100),
              ),
              Container(
                height: wdp(60),
                padding: EdgeInsets.symmetric(horizontal: wdp(20), vertical: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Obx(
                  () => DropdownButton<String>(
                    padding: EdgeInsets.zero,
                    value: controller.selectedItem.value,
                    hint: const Text('Select an option'),
                    icon: Image.asset(
                      Assets.assets_drop_down_icon_png,
                      color: AppColors.black,
                      width: wdp(26),
                    ),
                    style:
                        AppTextStyles.base.s26.blackColor.w400.noneDecoration,
                    items: controller.dropdownItems.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      controller.updateSelectedItem(newValue);
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: hdp(40),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: wdp(20), vertical: hdp(12)),
            decoration: BoxDecoration(
              color: AppColors.progressBgColor,
              border: Border.all(color: AppColors.progressBgColor),
              borderRadius: BorderRadius.circular(wdp(10)),
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      "Date",
                      style: AppTextStyles.base.blackColor.s26,
                    )),
                Expanded(
                    flex: 1,
                    child: Center(
                        child: Text("Day",
                            style: AppTextStyles.base.blackColor.s26))),
                Expanded(
                    flex: 1,
                    child: Center(
                        child: Text("Attendance",
                            style: AppTextStyles.base.blackColor.s26))),
              ],
            ),
          ),
          SizedBox(
            height: hdp(4),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.courseList.length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return getAttendanceView(controller.courseList[index]);
                },
              ),
            ),
          ),
          SizedBox(
            height: hdp(24),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Hero(
                tag: "appPoweredBy",
                child: Center(
                  child: Text(
                    'Powered by Lucify',
                    style:
                        AppTextStyles.base.blackColor.s24.w400.noneDecoration,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getAttendanceView(Courses model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: wdp(20), vertical: hdp(12)),
      margin: EdgeInsets.symmetric(vertical: hdp(4)),
      decoration: BoxDecoration(
        color: (model.isAttendance ? AppColors.green : AppColors.red)
            .withAlpha(50),
        border: Border.all(
            color: (model.isAttendance ? AppColors.green : AppColors.red)
                .withAlpha(50)),
        borderRadius: BorderRadius.circular(wdp(10)),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(
                getDateFormatFromDate(
                    pattern: DateFormats.FORMAT_39.format,
                    dateTime: getDateTimeFromMillisecondsSinceEpoch(
                        model.attendanceDate)),
                style: AppTextStyles.base.blackColor.s26,
              )),
          Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                      getDateFormatFromDate(
                          pattern: DateFormats.FORMAT_40.format,
                          dateTime: getDateTimeFromMillisecondsSinceEpoch(
                              model.attendanceDate)),
                      style: AppTextStyles.base.blackColor.s26))),
          Expanded(
              flex: 1,
              child: Center(
                  child: Text(model.isAttendance ? "Present" : "Absent",
                      style: AppTextStyles.base.blackColor.s26))),
        ],
      ),
    );
  }
}
