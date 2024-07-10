import 'package:get/get.dart';

import '../modules/attendance_list/bindings/attendance_list_binding.dart';
import '../modules/attendance_list/views/attendance_list_view.dart';
import '../modules/capture_photo/bindings/capture_photo_binding.dart';
import '../modules/capture_photo/views/capture_photo_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/registration/bindings/registration_binding.dart';
import '../modules/registration/views/registration_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/submit_professo_code/bindings/submit_professor_code_binding.dart';
import '../modules/submit_professo_code/views/submit_professor_code_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: _Paths.SPLASH,
        page: () => SplashView(),
        binding: SplashBinding(),
        preventDuplicates: false),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDANCE_LIST,
      page: () => const AttendanceListView(),
      binding: AttendanceListBinding(),
    ),
    GetPage(
      name: _Paths.CAPTURE_PHOTO,
      page: () => const CapturePhotoView(),
      binding: CapturePhotoBinding(),
    ),
    GetPage(
      name: _Paths.SUBMIT_PROFESSO_CODE,
      page: () => const SubmitProfessorCodeView(),
      binding: SubmitProfessorCodeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => const RegistrationView(),
      binding: RegistrationBinding(),
    ),
  ];
}
