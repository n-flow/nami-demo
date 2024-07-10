import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_attend/app/modules/base_get_widget.dart';
import 'package:smart_attend/app/routes/app_pages.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/themes/app_text_theme.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';
import 'package:smart_attend/app/utils/resolution.dart';
import 'package:smart_attend/app/utils/widgets/app_button/app_button.dart';
import 'package:smart_attend/app/utils/widgets/app_text_field/app_text_field.dart';
import 'package:smart_attend/assets.dart';

import '../controllers/login_controller.dart';

class LoginView extends BaseGetWidget<LoginController> {
  const LoginView({super.key});

  @override
  Widget body(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(bottom: SDP.hdp(900)),
            child: Hero(
              tag: "heroLogo",
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Center(
                    child: Container(
                      width: SDP.wdp(160),
                      height: SDP.wdp(160),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 18,
                            offset: const Offset(-8, 8),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      Assets.assets_img_png,
                      width: SDP.wdp(120),
                      height: SDP.wdp(120),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: SDP.hdp(240)),
                      child: Text(
                        'SmartAttend',
                        style:
                            AppTextStyles.base.redColor.s46.w400.noneDecoration,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SDP.hdp(40)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => AppTextField(
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    boxColor: AppColors.textFiledBg,
                    titleBackgroundHeight: SDP.hdp(20),
                    alignment: AlignmentDirectional.topStart,
                    titleColor: AppColors.textFiledHintColor,
                    radius: 10,
                    titleBottomMargin: 0,
                    hintText: 'Your ID',
                    errorText: controller.errorMap["userId"],
                    hintTextSize: SDP.wdp(38),
                    hintTextColor: AppColors.textFiledHintColor,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: SDP.wdp(50)),
                    onChange: (value) {
                      controller.user.value.userId = value;
                    },
                  ),
                ),
                SizedBox(
                  height: SDP.hdp(32),
                ),
                Obx(
                  () => AppTextField(
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.done,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    boxColor: AppColors.textFiledBg,
                    titleBackgroundHeight: SDP.hdp(20),
                    titleBottomMargin: 0,
                    alignment: AlignmentDirectional.topStart,
                    titleColor: AppColors.textFiledHintColor,
                    radius: 10,
                    hintText: 'Password',
                    errorText: controller.errorMap["password"],
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: SDP.wdp(50)),
                    hintTextSize: SDP.wdp(38),
                    hintTextColor: AppColors.textFiledHintColor,
                    onChange: (value) {
                      controller.user.value.password = value;
                    },
                  ),
                ),
                SizedBox(
                  height: SDP.hdp(32),
                ),
                AppButton(
                  text: "Log in",
                  onPressed: () async {
                    controller.isValidFields();
                  },
                  margin: EdgeInsets.zero,
                  color: AppColors.red,
                  style: AppTextStyles.base.w700.s28.whiteColor,
                  borderRadius: BorderRadius.circular(wdp(16)),
                ),
                SizedBox(
                  height: SDP.hdp(46),
                ),
                Text("Forgot Password",
                    style: AppTextStyles.base.w600.s28.blackColor),
                SizedBox(
                  height: SDP.hdp(46),
                ),
                Hero(
                  tag: "signUp",
                  child: AppButton(
                    text: "Create new account",
                    onPressed: () async {
                      toNamed(Routes.REGISTRATION);
                    },
                    margin: EdgeInsets.zero,
                    color: AppColors.white,
                    boarderColor: AppColors.black,
                    boarderWidth: 2,
                    style: AppTextStyles.base.w700.s28.blackColor,
                    borderRadius: BorderRadius.circular(wdp(26)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Hero(
            tag: "appPoweredBy",
            child: Center(
              child: Text(
                'Powered by Lucify',
                style: AppTextStyles.base.blackColor.s24.w400.noneDecoration,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
