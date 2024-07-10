import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension ListExtension on Iterable? {
  bool get lIsNullOrEmpty => GetUtils.isNullOrBlank(this) == null
      ? false
      : GetUtils.isNullOrBlank(this)!;
}

extension StringExtension on String? {
  bool get sIsNullOrEmpty => GetUtils.isNullOrBlank(this) == null
      ? true
      : equalsIgnoreCase("null")
          ? true
          : GetUtils.isNullOrBlank(this)!;

  bool equals(String val, {bool ignoreCase = false}) {
    if (sIsNullOrEmpty) {
      return false;
    }
    if (ignoreCase) {
      return this?.toLowerCase() == val.toLowerCase();
    } else {
      return this == val;
    }
  }

  bool equalsIgnoreCase(String? value) {
    if (this == null || value == null) {
      return false;
    }
    return this?.toLowerCase() == value.toLowerCase();
  }

  bool equal(String? value) {
    if (value == null) {
      return false;
    }
    return this == value;
  }

  bool isEmailValid() {
    final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(this ?? "");
  }

  bool isNumeric({bool isDot = false}) {
    List<String> match = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    if (isDot) {
      match.add(".");
    }
    List<String> dots = [];
    if (sIsNullOrEmpty) {
      return false;
    }
    var isValid = true;
    for (var element in this!.characters) {
      if (!match.contains(element)) {
        isValid = false;
      }
      if (element == ".") {
        dots.add(".");
      }
      if (!isValid || dots.length >= 2) {
        return false;
      }
    }
    return true;
  }
}

extension DynamicExtension on dynamic {
  bool get dIsNull => this == null || this == "null";

  bool get dIsEmpty =>
      GetUtils.isBlank(this) == null ? true : GetUtils.isBlank(this)!;

  bool get dIsNullOrEmpty => dIsNull || dIsEmpty;
}

extension ObjectExtension on Object? {
  bool get oIsNull => this == null || this == "null";

  bool get oIsEmpty =>
      GetUtils.isBlank(this) == null ? true : GetUtils.isBlank(this)!;

  bool get oIsNullOrEmpty => oIsNull || oIsEmpty;
}

extension IterableExtension<T> on Iterable<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension MapExtension on Map {
  Map removeNull() {
    removeWhere((key, value) => key == null || value == null);
    return this;
  }
}