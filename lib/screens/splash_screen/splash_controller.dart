import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_screen.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_screen.dart';
import 'package:atherium_saloon_app/screens/on_boarding_screen/onboarding_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  var shouldSkip = false;
  var isLogedIn = false;

  @override
  void onInit() async {
    super.onInit();
    var prefs = await SharedPreferences.getInstance();
    prefs.getString('imageUrlString') ?? prefs.setString('imageUrlString', '');
    getValues();
    await Future.delayed(const Duration(seconds: 5));
    navigate();
  }

  void getValues() async {
    var prefs = await SharedPreferences.getInstance();
    var shouldSkip = prefs.getBool('isVisited');
    var isLogedIn = prefs.getBool('isLogedIn');
    this.shouldSkip = shouldSkip ?? false;
    this.isLogedIn = isLogedIn ?? false;
  }

  void navigate() {
    if (shouldSkip == true && isLogedIn != true) {
      Get.offAll(() => LoginScreen());
    } else if (shouldSkip == true && isLogedIn == true) {
      Get.offAll(() => BottomNavigationScreen());
    } else {
      Get.offAll(() => OnBoardingScreen());
    }
  }
}
