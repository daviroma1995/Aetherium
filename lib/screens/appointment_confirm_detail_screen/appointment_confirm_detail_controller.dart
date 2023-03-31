import 'package:atherium_saloon_app/screens/services_screen/services_controller.dart';

import 'package:get/get.dart';

class AppointmentConfirmDetailController extends GetxController {
  List<SubService>? args = Get.arguments;
  double totalprice = 0.0;
  double get totalPrice {
    if (args!.isNotEmpty && totalprice == 0.0) {
      for (int i = 0; i < args!.length; i++) {
        totalprice += args![i].price;
      }
    }
    return totalprice;
  }
}
