import 'dart:async';

import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_screen.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_screen.dart';
import 'package:atherium_saloon_app/screens/on_boarding_screen/onboarding_screen.dart';
import 'package:atherium_saloon_app/screens/splash_screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../utils/shared_preferences.dart';

class SplashScreenController extends GetxController {
  var showOnBoarding = false;
  var isLogedIn = false;
  bool isUserNotEmpty = FirebaseAuth.instance.currentUser != null;
 
  void getValues() async {
    showOnBoarding = LocalData.showOnBoarding;
    isLogedIn = LocalData.isLogedIn;
  }
  @override
  void onInit() async {
    super.onInit();
    getValues();
  }
  @override
  void onReady() {
    super.onReady();
    navigate();
  }
  void navigate() async {
    if (!showOnBoarding && !isLogedIn) {
      Timer(const Duration(milliseconds: 2000), () {
        Get.offAll(() => LoginScreen());
      });
      return;
    } 
    if (!showOnBoarding && isLogedIn && isUserNotEmpty) {
      Get.offAll(() => const BottomNavigationScreen());
      return;
    } 
      await Future.delayed(const Duration(seconds: 3));
      Get.offAll(() => OnBoardingScreen());
    
  }
}
