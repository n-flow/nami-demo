import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_attend/app/data/network/models/response/user_model.dart';
import 'package:smart_attend/app/routes/app_pages.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/utils/extensions/data_type_extension.dart';
import 'package:smart_attend/app/utils/logger.dart';

abstract class StorageKey {
  StorageKey._();

  static const user = "user";

  static Map<String, Function> disposeFunctions = {};
}

extension ObjectExtension on GetStorage {
  Future<void> setUserData(User value) =>
      write(StorageKey.user, value.toJson());

  User? getUserData() {
    final savedUser = read(StorageKey.user);
    if (savedUser != null && !savedUser.toString().sIsNullOrEmpty) {
      User user = User.fromJson(savedUser);
      return user;
    } else {
      return null;
    }
  }

  void logoutUser() {
    clearStorage();
    offAllNamed(Routes.LOGIN);
  }

  void clearStorage() {
    erase();
  }

  void addListenKey(String key, ValueSetter callback) {
    var listen = listenKey(key, (value) {
      callback(value);
    });
    StorageKey.disposeFunctions[key] = listen;
    Log.i("Storage ListenKey:  $key  ListenKeys:  ${StorageKey.disposeFunctions.keys}");
  }

  void removeListenKey(String key) {
    StorageKey.disposeFunctions[key]?.call();
    StorageKey.disposeFunctions.remove(key);
    Log.i("Storage RemoveKey:  $key  ListenKeys:  ${StorageKey.disposeFunctions.keys}");
  }
}
