import 'package:permission_handler/permission_handler.dart'
    as permission_handler;

abstract class PermissionHelper {
  Future<PermissionStatus> request(Permission requestPermission);

  Future openAppSettings();
}

enum Permission { camera, gallery }

enum PermissionStatus {
  undetermined,
  denied,
  granted,
  restricted,
  permanentlyDenied,
}

class GrantedPermissionHelper implements PermissionHelper {
  @override
  Future openAppSettings() {
    return Future.delayed(const Duration(milliseconds: 250));
  }

  @override
  Future<PermissionStatus> request(Permission requestPermission) {
    return Future.value(PermissionStatus.granted);
  }
}

class MobilePermissionHelper implements PermissionHelper {
  @override
  Future<PermissionStatus> request(Permission requestPermission) async {
    var permission = _getPermissionFromPermissions(requestPermission);
    if (permission == null) {
      return PermissionStatus.undetermined;
    }

    var status = await permission.request();
    return _statusFromResponse(status);
  }

  @override
  Future openAppSettings() {
    return permission_handler.openAppSettings();
  }

  permission_handler.Permission? _getPermissionFromPermissions(
      Permission requestPermission) {
    switch (requestPermission) {
      case Permission.camera:
        return permission_handler.Permission.camera;
      case Permission.gallery:
        return permission_handler.Permission.photos;
      default:
        return null;
    }
  }

  PermissionStatus _statusFromResponse(
      permission_handler.PermissionStatus status) {
    if (status.isDenied) {
      return PermissionStatus.denied;
    } else if (status.isGranted) {
      return PermissionStatus.granted;
    } else if (status.isPermanentlyDenied) {
      return PermissionStatus.permanentlyDenied;
    } else if (status.isRestricted) {
      return PermissionStatus.restricted;
    }

    return PermissionStatus.undetermined;
  }
}
