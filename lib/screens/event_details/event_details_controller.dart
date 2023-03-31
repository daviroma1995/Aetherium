import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailsControlelr extends GetxController {
  void handleBack(BuildContext context) {
    Navigator.pop(context);
  }

  void setFavorite() {
    Get.arguments.isFavorite.value = !Get.arguments.isFavorite.value;
  }
}
