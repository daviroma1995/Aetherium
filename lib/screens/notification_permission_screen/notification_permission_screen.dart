import 'package:atherium_saloon_app/screens/notification_permission_screen/notification_permission_controller.dart';
import 'package:atherium_saloon_app/widgets/app_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPermissionScreen extends StatelessWidget {
  NotificationPermissionScreen({Key? key}) : super(key: key);

  final controller = Get.put(NotificationPermissionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
          onTap: () {
            Get.back();
          },
          title: 'Notification Setting'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Allow Notifications'),
            Obx(
              () => CupertinoSwitch(
                value: controller.isPermissionGranted.value,
                onChanged: (value) {
                  controller.setNotification();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
