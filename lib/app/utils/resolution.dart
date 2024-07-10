import 'package:flutter/material.dart';

class SDP {
  static double? width;
  static double? height;

  static void init(BuildContext c) {
    width = getWidth(c);
    height = getHeight(c);

    if (width! > height!) {
      width = getHeight(c);
      height = getWidth(c);
    }
  }

  static double wdp(double dp) {
    return (dp / 720) * (width == null ? 720 : width!);
  }

  static double hdp(double dp) {
    return (dp / 1280) * (height == null ? 1280 : height!);
  }

  static double getWidth(c) => MediaQuery.of(c).size.width;

  static double getHeight(c) => MediaQuery.of(c).size.height;
}
