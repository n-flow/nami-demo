import 'package:get/get.dart';

import '../controllers/route_not_found_page_controller.dart';

class RouteNotFoundPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RouteNotFoundPageController>(
      () => RouteNotFoundPageController(),
    );
  }
}
