import 'package:permission_handler/permission_handler.dart';

class PermissionService {

  Future<bool> checkPermission(Permission permission) async {
    final checkStatus = await checkPermissionStatus(permission);
    if(!checkStatus) {
      final isRequestGranted = await requestPermission(permission);
      if(!isRequestGranted) {
        return false;
      } else {
        return isRequestGranted;
      }
    } else {
      return checkStatus;
    }
  }

  Future<bool> requestPermission(Permission permission) async {
    var result = await permission.request();
    return result.isGranted;
  }

  Future<bool> checkPermissionStatus(Permission permission) async {
    var status = await permission.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied || status.isRestricted) {
      return false;
    } else if (status.isPermanentlyDenied) {
      return false;
    } else {
      return false;
    }
  }

  Future<String> checkPermissionString(Permission permission) async {
    permission.onDeniedCallback(() => {

    });
    var status = await permission.status;
    if (status.isGranted) {
      return "Granted";
    } else if (status.isDenied) {
      return "Denied";
    } else if (status.isRestricted) {
      return "Restricted";
    } else if (status.isPermanentlyDenied) {
      return "Permanently Denied";
    } else if (status.isLimited) {
      return "Limited";
    }  else if (status.isProvisional) {
      return "Provisional";
    } else {
      return "";
    }
  }

  Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> statuses = {};
    for (Permission permission in permissions) {
      PermissionStatus status = await permission.request();
      statuses[permission] = status;
    }
    //example: _print_out(statuses[Permission.location])
    return statuses;
  }
}
