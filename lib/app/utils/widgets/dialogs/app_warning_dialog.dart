import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/themes/app_text_theme.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';
import 'package:smart_attend/app/utils/extensions/data_type_extension.dart';
import 'package:smart_attend/app/utils/resolution.dart';
import 'package:smart_attend/app/utils/widgets/app_button/app_button.dart';
import 'package:smart_attend/assets.dart';

Future<bool> showAppWaningDialog(BuildContext context, String title, String message,
    String button, int statusCode) async {
  bool result = false;
  await showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                    onTap: () {
                      result = true;
                      getBack();
                    },
                    child: Icon(Icons.close,
                        size: SDP.wdp(48), color: Colors.black))),
            Visibility(
                visible: statusCode == 100,
                child: SizedBox(
                    width: SDP.wdp(120),
                    height: SDP.wdp(120),
                    child: Icon(
                      Icons.info,
                      size: SDP.wdp(120),
                      color: Colors.red,
                    ))),
            Visibility(
                visible: statusCode == 1,
                child: Image.asset(
                  Assets.assets_ic_green_tick_png,
                  width: SDP.wdp(100),
                  height: SDP.wdp(100),
                  fit: BoxFit.cover,
                )),
            SizedBox(height: SDP.hdp(40)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: !message.sIsNullOrEmpty ? SDP.hdp(20) : SDP.hdp(40)),
            Visibility(
                visible: !message.sIsNullOrEmpty,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                )),
            Visibility(
                visible: !message.sIsNullOrEmpty,
                child: SizedBox(height: SDP.hdp(40))),
            AppButton(
              text: button,
              onPressed: () async {
                result = true;
                getBack();
              },
              margin: EdgeInsets.zero,
              color: AppColors.red,
              style: AppTextStyles.base.w700.s28.whiteColor,
              borderRadius: BorderRadius.circular(SDP.wdp(16)),
            ),
          ],
        ),
      );
    },
    animationType: DialogTransitionType.slideFromBottom,
    curve: Curves.easeInOut,
    duration: const Duration(milliseconds: 500),
  );
  return result;
}
