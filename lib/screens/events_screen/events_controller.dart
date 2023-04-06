import 'package:get/get.dart';

import '../../models/event.dart';
import '../../network_utils/network_service.dart';
import '../event_details/event_details_screen.dart';

class EventsController extends GetxController {
  RxList<Event> events = <Event>[].obs;
  RxBool shouldUpdate = false.obs;
  @override
  void onInit() async {
    super.onInit();
    events.value = await Get.arguments;
  }

  void handleBack() {
    Get.back(result: 'update');
  }

  void goToDetails(int index) async {
    final result = await Get.to(
      () => EventDetailsScreen(),
      duration: Duration(milliseconds: 600),
      transition: Transition.downToUp,
      arguments: events[index],
    );
    if (result != null) {
      if (shouldUpdate.value == true) {
        shouldUpdate.value = false;
      } else {
        shouldUpdate.value = true;
      }
    }
  }
}
