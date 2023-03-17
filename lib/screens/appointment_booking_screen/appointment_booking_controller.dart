import 'dart:developer';

import 'package:get/get.dart';

class AppointMentBookingController extends GetxController {
  Rx<DateTime> date = DateTime.now().obs;

  void changeDate(DateTime newDate) {
    date.value = newDate;
    update();
  }

  void resetDate() {
    date.value = DateTime.now();
    log("reset date");
    update();
  }
}
