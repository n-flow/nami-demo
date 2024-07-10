import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:smart_attend/app/themes/app_text_theme.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';
import 'package:smart_attend/app/utils/extensions/data_type_extension.dart';
import 'package:smart_attend/app/utils/resolution.dart';
import 'package:smart_attend/app/utils/utils.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.alignment = AlignmentDirectional.topCenter,
    this.title,
    this.titleColor,
    this.titleSize,
    this.titleBgColor,
    this.initialText,
    this.titleBottomMargin,
    this.titleBackgroundHeight,
    this.titleBackgroundTransformation,
    this.hintText,
    this.latterSpace,
    this.hintTextColor,
    this.hintTextSize,
    this.errorText,
    this.obscureText,
    this.suffixIcon,
    this.extraSuffixIcon,
    this.radius,
    this.readOnly = false,
    this.enabled = true,
    this.onTap,
    this.onChange,
    this.txtController,
    this.boxColor = AppColors.white,
    this.boxBoarderColor = AppColors.transparent,
    this.contentPadding,
    this.isSuffixIconConstraints = true,
    this.textStyle,
    this.textAlign = TextAlign.center,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.titlePadding,
    this.maxLength,
  });

  final CrossAxisAlignment crossAxisAlignment;
  final AlignmentGeometry alignment;

  final String? title;
  final Color? titleColor;
  final double? titleSize;
  final Color? titleBgColor;
  final double? titleBottomMargin;
  final double? titleBackgroundHeight;
  final Matrix4? titleBackgroundTransformation;
  final EdgeInsetsGeometry? titlePadding;
  final int? maxLength;

  final String? hintText;
  final double? latterSpace;
  final Color? hintTextColor;
  final double? hintTextSize;

  final TextAlign textAlign;
  final String? initialText;
  final String? errorText;
  final bool? obscureText;
  final double? radius;
  final bool readOnly;
  final bool enabled;
  final Widget? suffixIcon;
  final Widget? extraSuffixIcon;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChange;
  final TextEditingController? txtController;
  final Color boxColor;
  final Color boxBoarderColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool isSuffixIconConstraints;
  final TextStyle? textStyle;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField>
    with TickerProviderStateMixin {
  final RxBool _obscureText = false.obs;
  TextEditingController? _controller;

  final GlobalKey containerKey = GlobalKey();

  double width = 120;

  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation =
        CurveTween(curve: Curves.fastOutSlowIn).animate(animationController!);

    _obscureText.value = widget.obscureText ?? false;

    if (widget.txtController != null) {
      _controller = widget.txtController;
    } else if (widget.txtController == null ||
        !widget.initialText.sIsNullOrEmpty) {
      _controller = TextEditingController();
    }
    _controller?.text = widget.initialText ?? "";
  }

  @override
  void dispose() {
    if (widget.txtController == null) {
      _controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var view = Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      children: [
        Stack(
          alignment: widget.alignment,
          children: [
            Container(
              key: containerKey,
              margin:
                  EdgeInsets.only(top: widget.titleBottomMargin ?? SDP.hdp(44)),
              decoration: BoxDecoration(
                color: widget.boxColor,
                border: Border.all(
                    color: widget.boxBoarderColor, width: SDP.wdp(3)),
                borderRadius:
                    BorderRadius.circular(widget.radius ?? SDP.wdp(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Stack(
                            children: [
                              const Text(
                                "data",
                                style: TextStyle(color: AppColors.transparent),
                              ),
                              Center(
                                child: getTextField(),
                              )
                            ],
                          ),
                        )),
                    !widget.errorText.sIsNullOrEmpty
                        ? GestureDetector(
                            onTap: () {
                              showSnackBar(message: widget.errorText!);
                            },
                            child: const Icon(Icons.info, color: AppColors.red
                                //change icon color according to form validation
                                ))
                        : const SizedBox.shrink(),
                    widget.extraSuffixIcon != null
                        ? GestureDetector(
                            onTap: widget.onTap,
                            child: widget.extraSuffixIcon,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            widget.title.sIsNullOrEmpty
                ? const SizedBox.shrink()
                : Stack(
                    children: [
                      Container(
                        height: widget.titleBackgroundHeight,
                        transform: widget.titleBackgroundTransformation,
                        color: widget.titleBgColor ?? AppColors.transparent,
                        child: Padding(
                          padding: widget.titlePadding ??
                              EdgeInsets.only(
                                  left: SDP.wdp(12),
                                  right: SDP.wdp(12),
                                  top: SDP.hdp(6),
                                  bottom: SDP.hdp(6)),
                          child: Text(widget.title ?? "Title",
                              style: AppTextStyles.base.w800
                                  .setColor(AppColors.transparent)
                                  .size(widget.titleSize ?? SDP.wdp(50))),
                        ),
                      ),
                      Padding(
                        padding: widget.titlePadding ??
                            EdgeInsets.only(
                                left: SDP.wdp(12),
                                right: SDP.wdp(12),
                                top: SDP.hdp(6),
                                bottom: SDP.hdp(6)),
                        child: Text(widget.title ?? "Title",
                            style: AppTextStyles.base.w800
                                .size(widget.titleSize ?? SDP.wdp(50))
                                .setColor(
                                    widget.titleColor ?? AppColors.white)),
                      ),
                    ],
                  ),
          ],
        ),
      ],
    );
    return view;
  }

  dynamic getTextField() {
    return Obx(
      () => TextField(
        obscureText: _obscureText.value,
        controller: _controller,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        inputFormatters: widget.inputFormatters,
        onTap: widget.onTap,
        keyboardType: widget.keyboardType,
        maxLength: widget.maxLength,
        textCapitalization: widget.textCapitalization,
        onChanged: (value) {
          if (widget.onChange != null) {
            widget.onChange!(value);
          }
        },
        style: widget.textStyle ??
            AppTextStyles.base.w800
                .size(widget.hintTextSize ?? SDP.wdp(52))
                .setColor(widget.hintTextColor ?? AppColors.black)
                .setLetterSpacing(widget.latterSpace ?? SDP.wdp(0.8)),
        textAlign: widget.textAlign,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          counterText: "",
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 10),
          hintStyle: AppTextStyles.base.w800
              .size(widget.hintTextSize ?? SDP.wdp(52))
              .setColor(widget.hintTextColor ?? AppColors.textFiledHintColor),
          suffixIcon: widget.suffixIcon ??
              (widget.obscureText != null
                  ? GestureDetector(
                      onTap: () => _obscureText.value = !_obscureText.value,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: _obscureText.value
                            ? const Icon(CupertinoIcons.eye_slash)
                            : const Icon(CupertinoIcons.eye),
                      ),
                    )
                  : const SizedBox()),
          suffixIconConstraints: widget.isSuffixIconConstraints
              ? const BoxConstraints(
                  maxWidth: 100,
                  maxHeight: 100,
                )
              : null,
        ),
      ),
    );
  }
}
