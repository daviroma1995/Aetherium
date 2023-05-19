import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:get/get.dart';

class LoyalityCardController extends GetxController {
  String uid = LoginController.instance.auth.currentUser?.uid ?? '';
}
