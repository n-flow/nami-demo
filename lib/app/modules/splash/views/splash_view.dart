import 'package:flutter/material.dart';
import 'package:smart_attend/app/modules/base_get_widget.dart';
import 'package:smart_attend/app/routes/app_pages.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/themes/app_text_theme.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';
import 'package:smart_attend/app/utils/resolution.dart';
import 'package:smart_attend/assets.dart';

import '../controllers/splash_controller.dart';

class SplashView extends BaseGetWidget<SplashController> {
  const SplashView({super.key});

  @override
  Color backgroundColor() => AppColors.red;

  @override
  Color scaffoldBackgroundColor() => AppColors.red;

  @override
  Widget body(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        SlideTransition(
          position: controller.finalTranslationAnimation,
          child: GestureDetector(
            onTap: () {
              toNamed(Routes.HOME);
            },
            child: Hero(
              tag: "heroLogo",
              child: Stack(
                children: [
                  Center(
                    child: AnimatedBuilder(
                      animation: controller.containerAnimationController,
                      builder: (context, child) {
                        double width = MediaQuery.of(context).size.width;
                        double height =
                            (1 - controller.containerAnimation.value) *
                                MediaQuery.of(context).size.height;
                        height > width
                            ? width = double.infinity
                            : width = height;
                        if (height < SDP.wdp(160)) {
                          height = SDP.wdp(160);
                          width = SDP.wdp(160);
                        }
                        return Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: AnimatedBuilder(
                      animation: controller.iconAnimationController,
                      builder: (context, child) {
                        double size = 30 + (controller.iconAnimation.value - 1) * 50;
                        if (size > SDP.wdp(120)) {
                          size = SDP.wdp(120);
                        }
                        return Image.asset(Assets.assets_img_png,
                            width: size, height: size);
                      },
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: SDP.hdp(240)),
                      child: AnimatedBuilder(
                        animation: controller.textAnimationController,
                        builder: (context, child) {
                          return FadeTransition(
                            opacity: controller.textFadeAnimation,
                            child: SlideTransition(
                              position: controller.textSlideAnimation,
                              child: Text(
                                'SmartAttend',
                                style: AppTextStyles.base.whiteColor.s46.w400.noneDecoration,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: AnimatedBuilder(
            animation: controller.poweredByAnimationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: controller.poweredByFadeAnimation,
                child: SlideTransition(
                  position: controller.poweredBySlideAnimation,
                  child: Hero(
                    tag: "appPoweredBy",
                    child: Center(
                      child: Text(
                        'Powered by Lucify',
                        style: AppTextStyles
                            .base.whiteColor.s24.w400.noneDecoration,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
