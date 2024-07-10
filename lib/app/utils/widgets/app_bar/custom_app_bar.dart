import 'package:flutter/material.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';
import 'package:smart_attend/app/utils/resolution.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final double? elevation;
  final Color backIconColoe;
  final Widget? flexibleSpace;

  void onClickBackButton() {
    getBack();
  }

  const CustomAppBar({
    Key? key,
    this.leading,
    this.actions,
    this.title,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.backgroundColor = AppColors.white,
    this.backIconColoe = AppColors.black,
    this.elevation = 1,
    this.flexibleSpace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// This part is copied from AppBar class
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    Widget? leadingIcon = leading;
    if (leadingIcon == null && automaticallyImplyLeading) {
      if (hasDrawer) {
        leadingIcon = IconButton(
          icon: const Icon(Icons.menu, color: AppColors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      } else {
        if (canPop) {
          leadingIcon = IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: backIconColoe,
              size: SDP.wdp(44),
            ),
            onPressed: () {
              onClickBackButton();
            },
          );
        }
      }
    }
    return Material(
      elevation: 1,
      child: AppBar(
        leading: leadingIcon,
        actions: actions,
        actionsIconTheme: const IconThemeData(color: Colors.black),
        surfaceTintColor: backgroundColor,
        title: title,
        centerTitle: centerTitle,
        backgroundColor: backgroundColor,
        flexibleSpace: flexibleSpace,
        elevation: elevation,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
