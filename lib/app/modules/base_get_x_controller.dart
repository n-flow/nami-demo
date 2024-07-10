import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_attend/app/data/network/models/response/user_model.dart';
import 'package:smart_attend/app/data/network/socket.dart';
import 'package:smart_attend/app/di/injection_container.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';
import 'package:smart_attend/app/utils/extensions/build_context.dart';
import 'package:smart_attend/app/utils/extensions/data_type_extension.dart';
import 'package:smart_attend/app/utils/extensions/storage_extension.dart';
import 'package:smart_attend/app/utils/logger.dart';
import 'package:smart_attend/app/utils/resolution.dart';
import 'package:smart_attend/app/utils/utils.dart';

abstract class BaseGetXController extends SuperController {
  User? getCurrentUser() => currentUserModel ?? storage.getUserData();
  User? currentUserModel;
  var currentUser = User().obs;

  Color statusBarColor() => AppColors.white;

  bool isStatusBarShow() => true;

  final storage = GetStorage();

  var socket = sl.get<Socket>();

  @override
  void onInit() {
    super.onInit();

    if (Get.context != null) {
      SDP.init(Get.context!);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      updateStatusBar();
    });

    Log.i('currentUserModel  ${getCurrentUser()?.toJson()}');
    listenValues();
  }

  void listenValues() {
    storage.listenKey(StorageKey.user, (savedUser) {
      if (savedUser != null && !savedUser.toString().sIsNullOrEmpty) {
        User user = User.fromJson(savedUser);
        currentUserModel = user;
        currentUser(currentUserModel);
        Log.i('currentUserModel  ${currentUserModel?.toJson()}');
      }
    });
  }

  void updateStatusBar({SystemUiOverlayStyle? value}) {
    if (isStatusBarShow()) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);

      SystemUiOverlayStyle style = value ??
          SystemUiOverlayStyle(
              statusBarColor: statusBarColor(),
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark);

      SystemChrome.setSystemUIOverlayStyle(style);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.bottom]);
    }
  }

  double wdp(double dp) => SDP.wdp(dp);

  double hdp(double dp) => SDP.hdp(dp);

  unFocusKeyboard(BuildContext context) {
    context.unFocusKeyboard();
  }

  void showInternetSnackBar() {
    showSnackBar(
        message: "Please Check Your Internet Connection",
        bgColor: AppColors.red);
  }

  @override
  void onResumed() {}

  @override
  void onPaused() {}

  @override
  void onInactive() {}

  @override
  void onDetached() {}

  @override
  void onHidden() {}
}
