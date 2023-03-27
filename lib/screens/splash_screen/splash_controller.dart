import 'package:atherium_saloon_app/screens/on_boarding_screen/onboarding_screen.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 7));
    Get.offAll(() => OnBoardingScreen());
  }
}
