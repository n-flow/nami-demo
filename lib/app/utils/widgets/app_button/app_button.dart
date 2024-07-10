import 'package:flutter/material.dart';
import 'package:smart_attend/app/themes/app_text_theme.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';
import 'package:smart_attend/app/utils/widgets/app_button/base_button.dart';

class AppButton extends StatelessWidget {
  AppButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.color = AppColors.black,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.space = 12,
    this.height = 48,
    this.width = double.infinity,
    this.borderRadius,
    this.boarderColor = AppColors.transparent,
    this.boarderRadius = 6,
    this.boarderWidth = 1,
  }) : super(key: key) {
    isOutline = false;
  }

  AppButton.outline({
    Key? key,
    required this.onPressed,
    this.text,
    this.color = AppColors.black,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.space = 12,
    this.height = 48,
    this.width = double.infinity,
    this.borderRadius,
    this.boarderColor = AppColors.transparent,
    this.boarderRadius = 6,
    this.boarderWidth = 1,
  }) : super(key: key) {
    isOutline = true;
  }

  late final bool isOutline;
  final String? text;
  final VoidCallback? onPressed;
  final Color color;
  final Color boarderColor;
  final double boarderRadius;
  final double boarderWidth;
  final TextStyle? style;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double space;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    TextStyle updatedStyle = style ?? AppTextStyles.base.w700.s16.blackColor;
    return Container(
      margin: margin,
      child: Card(
        elevation: 0,
        color: isOutline ? AppColors.transparent : color,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(48),
        ),
        child: Container(
          height: height,
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(48),
            border: Border.all(
              width: boarderWidth,
              color: onPressed != null ? boarderColor : boarderColor,
            ),
          ),
          child: BaseButton(
            onPressed: onPressed,
            color: isOutline ? AppColors.transparent : color,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixIcon != null)
                  Padding(
                    padding: EdgeInsets.only(right: text == null ? 0 : space),
                    child: prefixIcon!,
                  ),
                if (text != null)
                  Text(
                    text ?? "",
                    style: isOutline
                        ? updatedStyle.copyWith(color: color)
                        : updatedStyle,
                  ),
                if (suffixIcon != null)
                  Padding(
                    padding: EdgeInsets.only(right: text == null ? 0 : space),
                    child: suffixIcon!,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
