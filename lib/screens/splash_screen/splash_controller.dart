import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_screen.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_screen.dart';
import 'package:atherium_saloon_app/screens/on_boarding_screen/onboarding_screen.dart';
import 'package:get/get.dart';

import '../../utils/shared_preferences.dart';

class SplashScreenController extends GetxController {
  var showOnBoarding = false;
  var isLogedIn = false;

  @override
  void onInit() async {
    super.onInit();

    getValues();
    await Future.delayed(const Duration(seconds: 5));
    navigate();
  }

  void getValues() async {
    var showOnBoarding = LocalData.showOnBoarding;
    var isLogedIn = LocalData.isLogedIn;
    this.showOnBoarding = showOnBoarding;
    this.isLogedIn = isLogedIn;
  }

  void navigate() {
    if (showOnBoarding == false && isLogedIn != true) {
      Get.offAll(() => LoginScreen());
    } else if (showOnBoarding == false && isLogedIn == true) {
      Get.offAll(() => BottomNavigationScreen());
    } else {
      Get.offAll(() => OnBoardingScreen());
    }
  }
}
