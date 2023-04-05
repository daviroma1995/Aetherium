import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailsControlelr extends GetxController {
  RxBool isfavorite = false.obs;
  var args;
  @override
  void onInit() {
    args = Get.arguments;
    isfavorite.value = args.isFavorite;
    super.onInit();
  }

  void handleBack(BuildContext context) {
    Get.off(const BottomNavigationScreen(),
        duration: const Duration(milliseconds: 600),
        transition: Transition.upToDown,
        curve: Curves.easeIn);
    // Navigator.pop(context);
  }

  void setFavorite() {
    args.isFavorite = !args.isFavorite;
    isfavorite.value = !isfavorite.value;
  }
}
