// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../models/notification.dart';
import '../../utils/constants.dart';

class NotificationsController extends GetxController {
  var notifications = <Notification>[].obs;
  @override
  void onInit() async {
    notifications.value = await FirebaseServices.getUnreadNotifications();
    notifications.bindStream(FirebaseServices.getUnreadNotficationsStream());
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    notifications.close();
  }

  void handleBack() {
    Get.back();
  }

  void markasRead() {
    if (notifications.isNotEmpty) {
      for (var notification in notifications) {
        FirebaseServices.markNotificationAsRead(notification.id);
      }
      Fluttertoast.showToast(
          msg: tr('notifications_read'),
          backgroundColor: AppColors.GREEN_COLOR);
      notifications.value = <Notification>[];
    }
  }
}
