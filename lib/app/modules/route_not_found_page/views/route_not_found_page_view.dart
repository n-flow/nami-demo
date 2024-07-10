import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_attend/app/themes/app_text_theme.dart';
import 'package:smart_attend/assets.dart';

import '../controllers/route_not_found_page_controller.dart';

class RouteNotFoundPageView extends GetView<RouteNotFoundPageController> {
  const RouteNotFoundPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('RouteNotFound'.tr)),
        body: Stack(
          children: [
            PositionedTransition(
              rect: controller.relativeRectTween
                  .animate(controller.animController),
              child: Image.asset(Assets.assets_brain_png),
            ),
            Positioned(
              top: 150,
              bottom: 0,
              left: 24,
              right: 24,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '404',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.base.s48.w700.bold.blackColor.blackColor
                  ),
                  Text(
                    'Sorry, we could not find the page!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.base.s30.w500.blackColor.blackColor
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
