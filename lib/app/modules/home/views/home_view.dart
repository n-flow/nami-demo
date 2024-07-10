import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_attend/app/data/local/models/courses.dart';
import 'package:smart_attend/app/modules/base_get_widget.dart';
import 'package:smart_attend/app/routes/app_pages.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/themes/app_text_theme.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';
import 'package:smart_attend/app/utils/utils.dart';
import 'package:smart_attend/app/utils/widgets/app_avatar/app_circle_avatar.dart';
import 'package:smart_attend/app/utils/widgets/app_button/app_button.dart';
import 'package:smart_attend/assets.dart';

import '../controllers/home_controller.dart';

class HomeView extends BaseGetWidget<HomeController> {
  const HomeView({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: wdp(28), right: wdp(28), top: wdp(20), bottom: wdp(0)),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: hdp(40)),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "SmartAttend",
                        style:
                            AppTextStyles.base.redColor.s32.w600.noneDecoration,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Professor Code: ${(controller.getCurrentUser()!.professorCode ?? "")}",
                            style: AppTextStyles
                                .base.blackColor.s24.w600.noneDecoration,
                          ),
                          SizedBox(
                            width: wdp(8),
                          ),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                  text: controller
                                          .getCurrentUser()!
                                          .professorCode ??
                                      ""));
                              showSnackBar(message: "Code Copy");
                            },
                            child: Icon(
                              Icons.copy,
                              color: AppColors.black,
                              size: wdp(28),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.getTodayAttendance();
                  },
                  child: AppCircleAvatar(
                    imgUrl: Assets.assets_user_placeholder_png,
                    width: wdp(80),
                    height: wdp(80),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: hdp(40)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: hdp(80)),
                    child: Text(
                      "Course List",
                      style:
                          AppTextStyles.base.blackColor.s32.w600.noneDecoration,
                    ),
                  ),
                  Expanded(
                      child: AnimatedBuilder(
                    animation: controller.courseListAnimationController,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: controller.courseListFadeAnimation,
                        child: SlideTransition(
                          position: controller.courseListSlideAnimation,
                          child: Obx(
                            () => ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return getCourseListItems(
                                    controller.courseList[index]);
                              },
                              itemCount: controller.courseList.length,
                              physics: const ClampingScrollPhysics(),
                            ),
                          ),
                        ),
                      );
                    },
                  ))
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedBuilder(
                animation: controller.markAttendanceAnimationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: controller.markAttendanceFadeAnimation,
                    child: SlideTransition(
                      position: controller.markAttendanceSlideAnimation,
                      child: Hero(
                        tag: "markAttendance",
                        child: Center(
                          child: AppButton(
                            text: "Mark Attendance",
                            onPressed: () async {
                              controller.selectedCourse.value =
                                  controller.courseList.firstWhere((element) =>
                                      element.courseId ==
                                      controller.selectedCourse.value.courseId);
                              toNamed(Routes.ATTENDANCE_LIST, arguments: {
                                "selectedCourse":
                                    controller.selectedCourse.value.toJson()
                              }).then((value) => controller.onResumed());
                            },
                            margin: EdgeInsets.zero,
                            color: AppColors.red,
                            style: AppTextStyles.base.w700.s28.whiteColor,
                            borderRadius: BorderRadius.circular(wdp(16)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: hdp(80),
              ),
              Padding(
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
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget getCourseListItems(Courses courses) {
    return GestureDetector(
      onTap: () async {
        controller.selectedCourse.value = courses;
        await toNamed(Routes.ATTENDANCE_LIST, arguments: {
          "selectedCourse": controller.selectedCourse.value.toJson()
        }).then((value) => controller.onResumed());
        controller.getTodayAttendance();
      },
      child: Container(
        margin: EdgeInsets.only(top: hdp(20)),
        height: hdp(56),
        decoration: BoxDecoration(
          color: courses.isAttendance
              ? AppColors.green.withAlpha(70)
              : AppColors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 1, color: AppColors.black.withAlpha(60)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: wdp(28)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                courses.courseName,
                style: AppTextStyles.base.s26.bold,
              ),
              SizedBox(
                width: wdp(20),
              ),
              Visibility(
                  visible: courses.isAttendance,
                  child: Image.asset(
                    Assets.assets_ic_green_tick_png,
                    width: wdp(32),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
