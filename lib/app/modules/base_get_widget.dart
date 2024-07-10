import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_attend/app/modules/base_get_x_controller.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/themes/app_text_theme.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';
import 'package:smart_attend/app/utils/resolution.dart';
import 'package:smart_attend/app/utils/widgets/app_bar/custom_app_bar.dart';

abstract class BaseGetWidget<T extends BaseGetXController>
    extends GetWidget<T> {
  const BaseGetWidget({super.key});

  String appBarTitle() => "";

  String? backgroundImage() => null;

  Color backgroundColor() => AppColors.white;

  BoxFit bgFit() => BoxFit.cover;

  double backgroundHeight() => double.infinity;

  Color apBarTextColor() => AppColors.black;

  bool appbarTitleCenter() => true;

  bool isBackButton() => true;

  bool isAppBar() => false;

  Color isAppBarColor() => AppColors.white;

  bool isMainPage() => false;

  Color statusBarColor() => AppColors.kSecondaryColor;

  Color scaffoldBackgroundColor() => AppColors.white;

  void onClickBackButton() {
    getBack();
  }

  Widget? flexibleSpace() => null;

  Widget? stickBottomWidget() => null;

  Widget? floatingActionWidget() => null;

  List<Widget>? actionsList(BuildContext context) => null;

  double wdp(double dp) => SDP.wdp(dp);

  double hdp(double dp) => SDP.hdp(dp);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: backgroundColor(),
        ),
        Scaffold(
          backgroundColor: scaffoldBackgroundColor(),
          appBar: isAppBar()
              ? CustomAppBar(
                  title: Text(
                    appBarTitle(),
                    style: AppTextStyles.base.w900.s36
                        .setColor(apBarTextColor())
                        .setLetterSpacing(1),
                  ),
                  backgroundColor: isAppBarColor(),
                  flexibleSpace: flexibleSpace(),
                  centerTitle: appbarTitleCenter(),
                  actions: actionsList(context),
                )
              : null,
          body: SafeArea(child: body(context)),
          bottomNavigationBar: stickBottomWidget(),
          floatingActionButton: floatingActionWidget(),
        ),
      ],
    );
  }

  Widget body(BuildContext context);
}
