import 'dart:developer';

import 'package:atherium_saloon_app/screens/appointment_confirm_screen/appointment_confirm_screen.dart';
import 'package:atherium_saloon_app/screens/appointments_screen/appointments_screen.dart';
import 'package:get/get.dart';

import '../appointment_confirm_detail_screen/appointment_confirm_detail_screen.dart';

int monthIndex = DateTime.now().month;

class AppointMentBookingController extends GetxController {
  double totalPrice = 0.0;
  Rx<DateTime> date = DateTime.now().obs;
  RxString currentMonth = months[monthIndex - 1].obs;

  void prevMonth() {
    if (monthIndex > 1) {
      monthIndex--;
      currentMonth.value = months[monthIndex - 1];
    } else {
      monthIndex = 13;
      currentMonth.value = months[monthIndex - 1];
    }
  }

  void nextMonth() {
    if (monthIndex < 13) {
      monthIndex++;
      currentMonth.value = months[monthIndex - 1];
    } else {
      monthIndex = 1;
      currentMonth.value = months[monthIndex - 1];
    }
  }

  RxInt selectedSlot = 0.obs;
  void changeDate(DateTime newDate) {
    date.value = newDate;
    update();
  }

  void resetDate() {
    date.value = DateTime.now();
    monthIndex = DateTime.now().month;
    currentMonth.value = months[monthIndex - 1];
    log("reset date");
    update();
  }

  void selectSlot(int index) {
    selectedSlot.value = index;
  }

  void next() {
    Get.to(
      AppointmentConfirmDetailScreen(
        isDetail: false,
        isEditable: false,
      ),
      duration: const Duration(milliseconds: 600),
      transition: Transition.downToUp,
      arguments: Get.arguments,
    );
  }
}

List avaliableSlots = [
  '10:30 AM',
  '11:00 AM',
  '11:30 AM',
  '12:00 PM',
  '1:30 PM',
  '1:30 PM',
];
List<String> months = [
  'January',
  'Fabruary',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'August',
  'November',
  'December'
];
