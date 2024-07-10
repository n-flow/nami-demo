import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smart_attend/app/modules/base_get_widget.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/themes/app_text_theme.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';
import 'package:smart_attend/app/utils/widgets/app_avatar/app_circle_avatar.dart';
import 'package:smart_attend/app/utils/widgets/app_button/app_button.dart';
import 'package:smart_attend/assets.dart';

import '../controllers/capture_photo_controller.dart';

class CapturePhotoView extends BaseGetWidget<CapturePhotoController> {
  const CapturePhotoView({super.key});

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
          Expanded(
            child: Obx(
              () => Visibility(
                visible: controller.initializedController.isTrue &&
                    controller.initializeControllerFuture != null,
                child: FutureBuilder<void>(
                  future: controller.initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: hdp(40)),
                            padding: EdgeInsets.symmetric(horizontal: wdp(80)),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.5),
                                    spreadRadius: -10,
                                    blurRadius: 10,
                                    offset: const Offset(-10, 10),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Obx(
                                      () => CameraPreview(
                                        controller.controller!,
                                        child: controller.customPaint.value,
                                      ),
                                    ),
                                    Container(
                                      height: hdp(80),
                                      color: AppColors.progressBgColor,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: wdp(40)),
                                        child: Obx(
                                          () => LinearPercentIndicator(
                                            lineHeight: 8.0,
                                            barRadius:
                                                const Radius.circular(10),
                                            percent: (controller
                                                            .faceCapturePercentage
                                                            .value >
                                                        100
                                                    ? 100
                                                    : controller
                                                        .faceCapturePercentage
                                                        .value) /
                                                100,
                                            progressColor: AppColors.red,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: hdp(26),
                          ),
                          Text(
                            "Timer 15..14..Seconds Left",
                            style: AppTextStyles
                                .base.blackColor.s28.w600.noneDecoration,
                          ),
                          SizedBox(
                            height: hdp(8),
                          ),
                          Text(
                            "Keep Youe App In Foreground",
                            style: AppTextStyles
                                .base.redColor.s28.w600.noneDecoration,
                          ),
                          SizedBox(
                            height: hdp(26),
                          ),
                          Center(
                            child: AppButton(
                              text: "Capture",
                              onPressed: () async {
                                if (controller.faceCapturePercentage.value >= 100) {
                                  controller.markAttendance();
                                }
                              },
                              margin: EdgeInsets.zero,
                              color: AppColors.red,
                              style: AppTextStyles.base.w700.s28.whiteColor,
                              borderRadius: BorderRadius.circular(wdp(16)),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
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
}
