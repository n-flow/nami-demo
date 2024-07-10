import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_attend/app/themes/app_theme_colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData themData = ThemeData(
      primarySwatch: AppColors.kSecondaryColor,
      primaryColor: AppColors.kPrimaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      platform: TargetPlatform.iOS,
      useMaterial3: false,
      textTheme: GoogleFonts.inriaSansTextTheme());
}
