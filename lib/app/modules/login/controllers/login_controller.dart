import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:smart_attend/app/data/network/models/response/user_model.dart';
import 'package:smart_attend/app/modules/base_get_x_controller.dart';
import 'package:smart_attend/app/routes/app_pages.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/utils/extensions/data_type_extension.dart';
import 'package:smart_attend/app/utils/extensions/storage_extension.dart';
import 'package:smart_attend/app/utils/utils.dart';

class LoginController extends BaseGetXController with GetTickerProviderStateMixin {
  final String tag = "LoginController";

  late AnimationController controller;
  late Animation<double> iconAnimation;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  final errorMap = <String, String>{}.obs;
  var user = User().obs;

  @override
  void onInit() {
    super.onInit();

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    iconAnimation = Tween<double>(begin: 0, end: -0.1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    slideAnimation = Tween<Offset>(begin: Offset(0, 0.2), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    controller.forward();
    listenEvents();
  }

  void listenEvents() {
    socket.setCallBack(tag, (data) async {
      if (data.eventName.equalsIgnoreCase("user_logged_in") == true) {
        if (data.eventError.sIsNullOrEmpty == true) {
          var user = User.fromJson(data.eventData);
          storage.setUserData(user);
          offAllNamed(Routes.HOME);
        } else {
          showSnackBar(message: data.eventError?.toString() ?? "Something went wrong");
        }
      }
    });
  }

  bool isValidFields() {
    showLoading();
    errorMap.clear();

    if (user.value.userId.sIsNullOrEmpty) {
      errorMap["userId"] = "Please Enter Your Id";
    } else if (user.value.password.sIsNullOrEmpty) {
      errorMap["password"] = "Please Enter Your Password";
    }

    if (errorMap.isEmpty) {
      loginUser(user.value);
    } else {
      hideLoading();
    }
    return errorMap.isEmpty;
  }

  void loginUser(User user) {
    socket.emmitEvent('login_user', user.toJson().removeNull());
  }

  @override
  void onClose() {
    controller.dispose();
    socket.removeCallBack(tag);
    super.onClose();
  }
}
