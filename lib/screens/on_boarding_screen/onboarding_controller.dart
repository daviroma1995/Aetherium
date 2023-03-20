import 'dart:developer';
import 'dart:io';

import 'package:atherium_saloon_app/screens/login_screen/login_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  RxInt index = 0.obs;
  PageController pageController = PageController();

  void moveForward() {
    if (pageController.page!.toInt() == 2) {
      // Get.offAllNamed(AppRoutes.login);

      Get.offAll(LoginScreen());
    }
    pageController.animateToPage(pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
