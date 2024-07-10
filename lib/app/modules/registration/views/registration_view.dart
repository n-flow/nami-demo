import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_attend/app/modules/base_get_widget.dart';
import 'package:smart_attend/app/themes/app_text_theme.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';
import 'package:smart_attend/app/utils/widgets/app_button/app_button.dart';
import 'package:smart_attend/app/utils/widgets/app_text_field/app_text_field.dart';
import 'package:smart_attend/assets.dart';

import '../controllers/registration_controller.dart';

class RegistrationView extends BaseGetWidget<RegistrationController> {
  const RegistrationView({super.key});

  @override
  Widget body(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(bottom: hdp(900)),
            child: Hero(
              tag: "heroLogo",
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Center(
                    child: Container(
                      width: wdp(160),
                      height: wdp(160),
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
                      width: wdp(120),
                      height: wdp(120),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: hdp(240)),
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
            padding: EdgeInsets.symmetric(horizontal: hdp(40)),
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
                    titleBackgroundHeight: hdp(20),
                    alignment: AlignmentDirectional.topStart,
                    titleColor: AppColors.textFiledHintColor,
                    radius: 10,
                    errorText: controller.errorMap["name"],
                    titleBottomMargin: 0,
                    hintText: 'Your Full Name',
                    hintTextSize: wdp(38),
                    hintTextColor: AppColors.textFiledHintColor,
                    contentPadding: EdgeInsets.symmetric(horizontal: wdp(50)),
                    onChange: (value) {
                      controller.user.value.name = value;
                    },
                  ),
                ),
                SizedBox(
                  height: hdp(32),
                ),
                Obx(
                  () => AppTextField(
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    boxColor: AppColors.textFiledBg,
                    titleBackgroundHeight: hdp(20),
                    alignment: AlignmentDirectional.topStart,
                    errorText: controller.errorMap["userId"],
                    titleColor: AppColors.textFiledHintColor,
                    radius: 10,
                    titleBottomMargin: 0,
                    hintText: 'Your ID',
                    hintTextSize: wdp(38),
                    hintTextColor: AppColors.textFiledHintColor,
                    contentPadding: EdgeInsets.symmetric(horizontal: wdp(50)),
                    onChange: (value) {
                      controller.user.value.userId = value;
                    },
                  ),
                ),
                SizedBox(
                  height: hdp(32),
                ),
                Obx(
                  () => AppTextField(
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.done,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    boxColor: AppColors.textFiledBg,
                    titleBackgroundHeight: hdp(20),
                    errorText: controller.errorMap["password"],
                    titleBottomMargin: 0,
                    alignment: AlignmentDirectional.topStart,
                    titleColor: AppColors.textFiledHintColor,
                    radius: 10,
                    obscureText: true,
                    hintText: 'Password',
                    contentPadding: EdgeInsets.symmetric(horizontal: wdp(50)),
                    hintTextSize: wdp(38),
                    hintTextColor: AppColors.textFiledHintColor,
                    onChange: (value) {
                      controller.user.value.password = value;
                    },
                  ),
                ),
                SizedBox(
                  height: hdp(32),
                ),
                SizedBox(
                  height: hdp(46),
                ),
                Hero(
                  tag: "signUp",
                  child: AppButton(
                    text: "Create new account",
                    onPressed: () async {
                      controller.isValidFields();
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
