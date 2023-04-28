import 'dart:async';
import 'dart:developer';

import 'package:atherium_saloon_app/models/employee.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/treatment.dart';
import '../appointment_confirm_detail_screen/appointment_confirm_detail_screen.dart';

int monthIndex = DateTime.now().month;

class AppointMentBookingController extends GetxController {
  var args = Get.arguments;
  var employees = <Employee>[].obs;
  var treatments = <Treatment>[].obs;
  var selectedTreatements = <Treatment>[];
  @override
  void onInit() {
    super.onInit();
    employees.bindStream(FirebaseServices.employeeStrem());
    treatments.bindStream(FirebaseServices.treatments());
    print(args.serviceId);
    args.time = avaliableSlots[0];
    args.dateTimestamp = Timestamp.fromDate(DateTime.now());
    Timer(Duration(milliseconds: 500), () {
      args.serviceId.forEach((service) {
        log('Called');
        for (int index = 0; index < treatments.length; index++) {
          if (treatments[index].name == service ||
              treatments[index].id == service) {
            selectedTreatements.add(treatments[index]);
          }
        }
      });
    });
    print(selectedTreatements);
  }

  double totalPrice = 0.0;
  Rx<DateTime> date = DateTime.now().obs;

  RxInt selectedSlot = 0.obs;
  void changeDate(DateTime newDate) {
    date.value = newDate;
    update();
  }

  void selectSlot(int index) {
    selectedSlot.value = index;
    print(index);
    args.time = avaliableSlots[index];
  }

  void next() {
    if (args.time == null) {
      args.time = avaliableSlots[0];
    }
    if (args.dateTimestamp == null) {
      args.dateTimestamp = Timestamp.fromDate(DateTime.now());
    }
    Get.to(
      AppointmentConfirmDetailScreen(
        isDetail: false,
        isEditable: false,
        services: selectedTreatements,
      ),
      duration: const Duration(milliseconds: 600),
      transition: Transition.downToUp,
      arguments: args,
    );
  }
}

List avaliableSlots = [
  '10:30',
  '11:00',
  '11:30',
  '12:00',
  '14:30',
  '17:30',
];
