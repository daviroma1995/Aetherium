import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionController extends GetxController {
  RxBool isPermissionGranted = false.obs;

  @override
  void onInit() async {
    if (await Permission.notification.isGranted) {
      isPermissionGranted.value = true;
    } else {
      isPermissionGranted.value = false;
    }
    super.onInit();
  }

  void setNotification() async {
    openAppSettings();
    if (await Permission.notification.isGranted) {
      isPermissionGranted.value = true;
    } else {
      isPermissionGranted.value = false;
    }
  }
}
