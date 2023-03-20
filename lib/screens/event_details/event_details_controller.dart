import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class EventDetailsControlelr extends GetxController {
  void setFavorite() {
    Get.arguments.isFavorite.value = !Get.arguments.isFavorite.value;
  }
}
