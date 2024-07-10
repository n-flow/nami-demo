import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_attend/app/modules/base_get_widget.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/themes/app_text_theme.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';
import 'package:smart_attend/app/utils/resolution.dart';
import 'package:smart_attend/app/utils/widgets/app_avatar/app_circle_avatar.dart';
import 'package:smart_attend/app/utils/widgets/app_button/app_button.dart';
import 'package:smart_attend/app/utils/widgets/app_text_field/app_text_field.dart';
import 'package:smart_attend/assets.dart';

import '../controllers/submit_professor_code_controller.dart';

class SubmitProfessorCodeView
    extends BaseGetWidget<SubmitProfessorCodeController> {
  const SubmitProfessorCodeView({super.key});

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
            child: AnimatedBuilder(
              animation: controller.markAttendanceAnimationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: controller.markAttendanceFadeAnimation,
                  child: SlideTransition(
                    position: controller.markAttendanceSlideAnimation,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Please enter code given by Professor",
                            style: AppTextStyles
                                .base.s22.w500.blackColor.noneDecoration,
                          ),
                          SizedBox(
                            height: SDP.hdp(22),
                          ),
                          Obx(
                            () => AppTextField(
                              textAlign: TextAlign.start,
                              textInputAction: TextInputAction.done,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              boxColor: AppColors.textFiledBg,
                              titleBackgroundHeight: SDP.hdp(20),
                              alignment: AlignmentDirectional.topStart,
                              titleColor: AppColors.textFiledHintColor,
                              radius: 10,
                              titleBottomMargin: 0,
                              errorText: controller.errorMap["professorCode"],
                              hintText: 'Enter Professor Code',
                              hintTextSize: SDP.wdp(38),
                              hintTextColor: AppColors.textFiledHintColor,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: SDP.wdp(50)),
                              onChange: (value) {
                                controller.professorCode = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: SDP.hdp(32),
                          ),
                          AppButton(
                            text: "Submit",
                            onPressed: () async {
                              controller.isValidFields();
                            },
                            margin: EdgeInsets.zero,
                            color: AppColors.red,
                            style: AppTextStyles.base.w700.s28.whiteColor,
                            borderRadius: BorderRadius.circular(wdp(16)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
