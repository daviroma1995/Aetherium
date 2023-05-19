import 'dart:async';
import 'dart:developer';

import 'package:atherium_saloon_app/models/client.dart';
import 'package:atherium_saloon_app/models/employee.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/treatment.dart';
import '../appointment_confirm_detail_screen/appointment_confirm_detail_screen.dart';

int monthIndex = DateTime.now().month;

class AppointMentBookingController extends GetxController {
  var args = Get.arguments;
  var employees = <Employee>[].obs;
  var treatments = <Treatment>[].obs;
  var selectedTreatements = <Treatment>[];
  var currentUser = Client().obs;
  RxBool isAdmin = false.obs;
  TextEditingController notes = TextEditingController();
  @override
  void onInit() async {
    super.onInit();
    employees.bindStream(FirebaseServices.employeeStrem());
    treatments.bindStream(FirebaseServices.treatments());
    var data = await FirebaseServices.getDataWhere(
        collection: 'clients',
        value: LoginController.instance.user?.uid ?? '',
        key: 'user_id');
    currentUser.value = Client.fromJson(data!);
    if (currentUser.value.isAdmin == true) {
      isAdmin.value = true;
    }
    args.time = args.time ?? avaliableSlots[0];
    args.dateTimestamp = args.dateTimestamp ??
        Timestamp.fromDate(DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 0, 0, 0, 0, 0));
    args.statusId = '88aa7cf3-c6b6-4cab-91eb-247aa6445a4g';
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
    selectedTreatements = <Treatment>[];
    DateTime time = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 0, 0, 0, 0, 0);
    print(time);
    args.dateTimestamp ??= Timestamp.fromDate(time);

    args.serviceId.forEach((service) {
      log('Called');
      for (int index = 0; index < treatments.length; index++) {
        if (treatments[index].name == service ||
            treatments[index].id == service) {
          selectedTreatements.add(treatments[index]);
        }
      }
    });
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
