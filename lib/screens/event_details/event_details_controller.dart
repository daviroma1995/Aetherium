import 'dart:ffi';

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
    // Get.to( BottomNavigationScreen(),
    //     duration: const Duration(milliseconds: 600),
    //     transition: Transition.upToDown,
    //     curve: Curves.easeIn);
    // Navigator.pop(context);
    Get.back(result: args.isFavorite);
  }

  void setFavorite() {
    args.isFavorite = !args.isFavorite;
    isfavorite.value = !isfavorite.value;
  }

  String getTime(String time) {
    String formatedTime = '';
    for (int index = 0; index < 2; index++) {
      formatedTime += time[index];
    }
    if (int.parse(formatedTime) <= 12) {
      time = '$time AM';
    } else {
      time = '$time';
    }
    return time;
  }
}
