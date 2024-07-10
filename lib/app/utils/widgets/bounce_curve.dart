import 'package:flutter/animation.dart';
import 'dart:math';

class CustomBounceCurve extends Curve {
  @override
  double transform(double t) {
    return t < 0.5
        ? 4 * t * t * t
        : 1 - pow(-2 * t + 2, 3) / 2;
  }
}