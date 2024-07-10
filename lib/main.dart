import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smart_attend/app/di/injection_container.dart';
import 'package:smart_attend/app/modules/route_not_found_page/bindings/route_not_found_page_binding.dart';
import 'package:smart_attend/app/modules/route_not_found_page/views/route_not_found_page_view.dart';
import 'package:smart_attend/app/themes/app_theme.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await init();

  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => ResponsiveBreakpoints(breakpoints: const [
        Breakpoint(start: 0, end: 450, name: MOBILE),
        Breakpoint(start: 0, end: 800, name: MOBILE),
        Breakpoint(start: 451, end: 800, name: TABLET),
        Breakpoint(start: 451, end: 1000, name: TABLET),
        Breakpoint(start: 801, end: 1920, name: DESKTOP),
        Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ], child: child!),
      title: 'GetX Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themData,
      initialRoute: AppPages.INITIAL,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      getPages: AppPages.routes,
      unknownRoute: GetPage(
        name: "/not-found",
        page: () => const RouteNotFoundPageView(),
        binding: RouteNotFoundPageBinding(),
      ),
    );
  }
}
