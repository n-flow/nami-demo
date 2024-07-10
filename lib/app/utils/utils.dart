import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';
import 'package:smart_attend/app/utils/date_formats.dart';
import 'package:smart_attend/app/utils/extensions/data_type_extension.dart';
import 'package:smart_attend/app/utils/logger.dart';
import 'package:smart_attend/app/utils/resolution.dart';
import 'package:smart_attend/app/utils/widgets/snack_bar/snack_bar_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showSnackBar({
  String title = "",
  String message = "",
  Color bgColor = AppColors.red,
  Color titleColor = AppColors.white,
  Color msgColor = AppColors.white,
}) {
  SnackBarView(
    titleText: title.sIsNullOrEmpty ? null : Text(title, style: TextStyle(color: msgColor)),
    messageText: Text(message, style: TextStyle(color: msgColor)),
    snackPosition: SnackBarViewPosition.bottom,
    margin: const EdgeInsets.all(0),
    backgroundColor: bgColor,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(SDP.wdp(15)),
        topRight: Radius.circular(SDP.wdp(15)),
        bottomLeft: Radius.circular(SDP.wdp(0)),
        bottomRight: Radius.circular(SDP.wdp(0))),
    dismissDirection: DismissDirection.horizontal,
    duration: const Duration(seconds: 3),
  ).show();
}

String getUniqueId({String? dateFormat}) {
  return "${getDateFormatFromDate(pattern: dateFormat)}_${getUniqueKey()}";
}

String getUniqueKey() {
  return UniqueKey().hashCode.toString();
}

void showLoading({bool isDismissible = false}) {
  if (Get.isDialogOpen == true) {
    return;
  }

  Get.dialog(
    Center(
      child: Container(
        height: 80,
        width: 80,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.black,
        ),
        child: const SpinKitFadingCircle(
          size: 40,
          color: AppColors.kPrimaryColor,
        ),
      ),
    ),
    barrierColor: AppColors.white.withOpacity(0.2),
    barrierDismissible: isDismissible,
    transitionCurve: Curves.easeInOutBack,
  );
}

void hideLoading() {
  Log.i("hideLoading:  ${Get.isDialogOpen}");
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}
