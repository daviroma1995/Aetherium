import 'dart:developer';

import 'package:atherium_saloon_app/screens/login_screen/login_screen.dart';
import 'package:atherium_saloon_app/utils/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingController extends GetxController {
  @override
  RxInt index = 0.obs;

  PageController pageController = PageController();

  void moveForward() async {
    if (pageController.page!.toInt() == 2) {
      LocalData.setSwhowOnBoarding(false);
      Get.offAll(LoginScreen());
    } else {
      pageController.animateToPage(pageController.page!.toInt() + 1,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }
}
