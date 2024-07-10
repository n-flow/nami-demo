import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RouteNotFoundPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RelativeRectTween relativeRectTween = RelativeRectTween(
    begin: const RelativeRect.fromLTRB(24, 24, 24, 200),
    end: const RelativeRect.fromLTRB(24, 24, 24, 250),
  );

  late AnimationController animController;

  @override
  void onInit() {
    super.onInit();
    animController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
  }
}
