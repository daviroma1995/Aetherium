// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../models/notification.dart';
import '../../utils/constants.dart';

class NotificationsController extends GetxController {
  var notifications = <Notification>[].obs;
  @override
  void onInit() async {
    notifications.value = await FirebaseServices.getUnreadNotifications();
    super.onInit();
  }

  // TODO
  void handleBack() {
    Get.back();
  }

  void markasRead() {
    if (notifications.isNotEmpty) {
      notifications.forEach((notification) {
        FirebaseServices.markNotificationAsRead(notification.id);
        Fluttertoast.showToast(
            msg: 'All Notifications are marked as read',
            backgroundColor: AppColors.GREEN_COLOR);
      });
      notifications.value = <Notification>[];
    }
  }
}
