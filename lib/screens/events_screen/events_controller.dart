import 'dart:io';

import 'package:get/get.dart';

import '../../models/event.dart';
import '../../network_utils/firebase_services.dart';
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

  void setFavorite(int index) async {
    final uid = FirebaseServices.cuid;
    if (events[index].isfavorite == true) {
      events[index].clientId!.removeWhere((element) => element == uid);
    } else {
      events[index].clientId!.add(uid);
    }
    FirebaseServices.toggleFavorite(
        eventId: events[index].eventId!, data: events[index]);
    events[index].isfavorite = !events[index].isfavorite!;
  }

  void goToDetails(int index) async {
    final result = await Get.to(
      () => EventDetailsScreen(),
      duration: const Duration(milliseconds: 600),
      transition: Platform.isIOS ? null : Transition.downToUp,
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
