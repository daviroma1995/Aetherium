// ignore_for_file: avoid_print

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  final Permission permission;
  final String permissionName;
  final BuildContext context;

  static Future<bool> get isPrecise async {
    final accuracyStatus = await Geolocator.getLocationAccuracy();

    bool isPrecise = false;
    switch (accuracyStatus) {
      case LocationAccuracyStatus.reduced:
        print("approximate");
        break;
      case LocationAccuracyStatus.precise:
        // Precise location switch is ON.
        print("precise");
        isPrecise = true;

        break;
      case LocationAccuracyStatus.unknown:
        print("unknonwn");
        // The platform doesn't support this feature, for example an Android device.
        break;
    }
    return isPrecise;
  }

  PermissionUtils(
      {required this.permission,
      required this.permissionName,
      required this.context});

  Future<bool> get isAllowed async {
    var startTime = DateTime.now();
    var status = await permission.request();
    var endTime = DateTime.now();
    var waitTime = startTime.difference(endTime).inSeconds.abs();
    print(waitTime);

    print(status);
    /*  if (Platform.isIOS && status == permission.isLimited) {
      return true;
    }*/
    String messages = "";
    if (permission.value == Permission.location.value) {
      messages = "Please turn on precise location.";
    }
    // if (!status.isGranted && (status.isDenied || status.isPermanentlyDenied)) {
    if (/*!status.isGranted || status.isDenied || */ status
            .isPermanentlyDenied &&
        waitTime <= 1) {
      // ignore: use_build_context_synchronously
      var result = await showOkCancelAlertDialog(
          context: context,
          title: "Permission Error",
          message:
              "You denied permission. Please allow $permissionName permission from setting.${messages}Open setting now?",
          okLabel: "Yes",
          cancelLabel: "No");
      if (result == OkCancelResult.ok) {
        openAppSettings();
      }
      return false;
    }

    return status.isGranted;
  }
}
