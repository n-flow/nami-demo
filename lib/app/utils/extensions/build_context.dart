import 'package:flutter/cupertino.dart';

extension BuildContextExtension on BuildContext? {
  unFocusKeyboard() {
    if (this != null) {
      final FocusScopeNode currentScope = FocusScope.of(this!);
      if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }
  }
}
