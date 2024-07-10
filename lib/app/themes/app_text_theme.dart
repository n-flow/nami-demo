import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/resolution.dart';
import 'app_theme_colors.dart';

final storage = GetStorage();

class AppTextStyles {
  AppTextStyles._();

  static TextStyle base = TextStyle(
    fontFamily: GoogleFonts.inriaSans().fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.black,
  );
}

extension AppFontWeight on TextStyle {
  /// FontWeight.w100
  TextStyle get w100 => copyWith(
        fontWeight: FontWeight.w100,
      );

  /// FontWeight.w200
  TextStyle get w200 => copyWith(
        fontWeight: FontWeight.w200,
      );

  /// FontWeight.w300
  TextStyle get w300 => copyWith(
        fontWeight: FontWeight.w300,
      );

  /// FontWeight.w400
  TextStyle get w400 => copyWith(
        fontWeight: FontWeight.w400,
      );

  /// FontWeight.w500
  TextStyle get w500 => copyWith(
        fontWeight: FontWeight.w500,
      );

  /// FontWeight.w600
  TextStyle get w600 => copyWith(
        fontWeight: FontWeight.w600,
      );

  /// FontWeight.w700
  TextStyle get w700 => copyWith(
        fontWeight: FontWeight.w700,
      );

  /// FontWeight.w800
  TextStyle get w800 => copyWith(
        fontWeight: FontWeight.w800,
      );

  /// FontWeight.w900
  TextStyle get w900 => copyWith(
        fontWeight: FontWeight.w900,
      );

  TextStyle get bold => copyWith(
        fontWeight: FontWeight.bold,
      );
}

extension AppFontSize on TextStyle {
  /// fontSize: 10
  TextStyle get s10 => copyWith(
        fontSize: SDP.wdp(10),
      );

  /// fontSize: 12
  TextStyle get s12 => copyWith(
        fontSize: SDP.wdp(12),
      );

  /// fontSize: 14
  TextStyle get s14 => copyWith(
        fontSize: SDP.wdp(14),
      );

  /// fontSize: 16
  TextStyle get s16 => copyWith(
        fontSize: SDP.wdp(16),
      );

  /// fontSize: 18
  TextStyle get s18 => copyWith(
        fontSize: SDP.wdp(18),
      );

  /// fontSize: 20
  TextStyle get s20 => copyWith(
        fontSize: SDP.wdp(20),
      );

  /// fontSize: 22
  TextStyle get s22 => copyWith(
        fontSize: SDP.wdp(22),
      );

  /// fontSize: 24
  TextStyle get s24 => copyWith(
        fontSize: SDP.wdp(24),
      );

  /// fontSize: 26
  TextStyle get s26 => copyWith(
        fontSize: SDP.wdp(26),
      );

  /// fontSize: 28
  TextStyle get s28 => copyWith(
        fontSize: SDP.wdp(28),
      );

  /// fontSize: 30
  TextStyle get s30 => copyWith(
        fontSize: SDP.wdp(30),
      );

  /// fontSize: 32
  TextStyle get s32 => copyWith(
        fontSize: SDP.wdp(32),
      );

  /// fontSize: 34
  TextStyle get s34 => copyWith(
        fontSize: SDP.wdp(34),
      );

  /// fontSize: 36
  TextStyle get s36 => copyWith(
        fontSize: SDP.wdp(36),
      );

  /// fontSize: 38
  TextStyle get s38 => copyWith(
        fontSize: SDP.wdp(38),
      );

  /// fontSize: 40
  TextStyle get s40 => copyWith(
        fontSize: SDP.wdp(40),
      );

  /// fontSize: 42
  TextStyle get s42 => copyWith(
        fontSize: SDP.wdp(42),
      );

  /// fontSize: 44
  TextStyle get s44 => copyWith(
        fontSize: SDP.wdp(44),
      );

  /// fontSize: 46
  TextStyle get s46 => copyWith(
        fontSize: SDP.wdp(46),
      );

  /// fontSize: 48
  TextStyle get s48 => copyWith(
        fontSize: SDP.wdp(48),
      );

  /// fontSize: 50
  TextStyle get s50 => copyWith(
        fontSize: SDP.wdp(50),
      );

  /// fontSize: custom
  TextStyle size(double size) => copyWith(
        fontSize: SDP.wdp(size),
      );
}

extension AppFontColor on TextStyle {
  TextStyle get whiteColor => copyWith(color: AppColors.white);

  TextStyle get blackColor => copyWith(color: AppColors.black);

  TextStyle get txtHint => copyWith(color: AppColors.textFiledHintColor);

  TextStyle get bondiBlue => copyWith(color: AppColors.blue);

  TextStyle get neutral3Color => copyWith(color: AppColors.neutral3);

  TextStyle get redColor => copyWith(color: AppColors.red);

  TextStyle setColor(Color color) => copyWith(color: color);
}

extension AppFontStyle on TextStyle {
  /// color: AppColors.white,
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
}

extension AppFontDecoration on TextStyle {
  /// decoration: TextDecoration.overline,
  TextStyle get overline => copyWith(decoration: TextDecoration.overline);

  /// decoration: TextDecoration.underline,
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);

  /// decoration: TextDecoration.overline,
  TextStyle get noneDecoration => copyWith(decoration: TextDecoration.none);

  /// decoration: TextDecoration.lineThrough,
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);
}

extension AppFontHeight on TextStyle {
  TextStyle heights(double height) => copyWith(height: height);

  TextStyle heightHDP(double height) => copyWith(height: SDP.hdp(height));

  TextStyle heightWDP(double height) => copyWith(height: SDP.wdp(height));
}

extension AppShadows on TextStyle {
  TextStyle get shadowBlack => copyWith(shadows: [
        Shadow(
          blurRadius: SDP.wdp(40),
          color: Colors.black,
          offset: Offset(SDP.wdp(5), SDP.wdp(5)),
        )
      ]);
}

extension AppBackgroundColor on TextStyle {
  TextStyle setBackgroundColor(Color bgColor) =>
      copyWith(backgroundColor: bgColor);
}

extension AppLetterSpacing on TextStyle {
  TextStyle setLetterSpacing(double space) => copyWith(letterSpacing: space);
}
