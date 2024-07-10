import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_attend/app/modules/base_get_x_controller.dart';
import 'package:smart_attend/app/routes/app_pages.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/utils/extensions/storage_extension.dart';
import 'package:smart_attend/app/utils/widgets/bounce_curve.dart';

class SplashController extends BaseGetXController
    with GetTickerProviderStateMixin {
  late AnimationController containerAnimationController;
  late Animation<double> containerAnimation;

  late AnimationController iconAnimationController;
  late Animation<double> iconAnimation;

  late AnimationController textAnimationController;
  late Animation<Offset> textSlideAnimation;
  late Animation<double> textFadeAnimation;

  late AnimationController poweredByAnimationController;
  late Animation<Offset> poweredBySlideAnimation;
  late Animation<double> poweredByFadeAnimation;

  late AnimationController finalTranslationController;
  late Animation<Offset> finalTranslationAnimation;

  @override
  void onInit() {
    super.onInit();

    containerAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    containerAnimation = CurvedAnimation(
      parent: containerAnimationController,
      curve: Curves.easeInOut,
    );

    iconAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    iconAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.8), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 0.8, end: 1.8), weight: 50),
    ]).animate(
      CurvedAnimation(
        parent: iconAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    textSlideAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: textAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: textAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    poweredByAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    poweredBySlideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: poweredByAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    poweredByFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: poweredByAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    finalTranslationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    finalTranslationAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -0.1),
    ).animate(
      CurvedAnimation(
        parent: finalTranslationController,
        curve: CustomBounceCurve(),
      ),
    );

    containerAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 900), () {
      iconAnimationController.forward().then((_) {
        textAnimationController.forward().then((_) {
          poweredByAnimationController.forward().then((_) {
            finalTranslationController.forward().then((_) {
              routToNextPage();
            });
          });
        });
      });
    });
  }

  void routToNextPage() {
    if (getCurrentUser() == null) {
      storage.logoutUser();
    } else {
      toNamed(Routes.HOME);
    }
  }

  @override
  void onClose() {
    containerAnimationController.dispose();
    iconAnimationController.dispose();
    textAnimationController.dispose();
    poweredByAnimationController.dispose();
    finalTranslationController.dispose();
    super.onClose();
  }
}
