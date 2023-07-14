import 'package:atherium_saloon_app/models/client.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/select_client_screen/select_client_screen.dart';
import 'package:atherium_saloon_app/screens/upcoming_appointments_screen/upcoming_appointments_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../past_appointment_screen/past_appointment_screen.dart';
import '../services_screen/services_screen.dart';

class AppointmentsController extends GetxController {
  var currentUser = Client().obs;
  RxInt selectedTab = 1.obs;
  @override
  void onInit() async {
    super.onInit();
    // ignore: unused_local_variable
    var myargs = Get.arguments;
    var uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    var data = await FirebaseServices.getCurrentUser();
    currentUser.value = Client.fromJson(data);
  }

  void handleBack(BuildContext context) {
    Navigator.pop(context);
  }

  RxBool isCurrentPast = false.obs;
  RxBool isCurrentUpcomming = true.obs;
  RxList screens = [
    PastAppointmentScreen(),
    UpcomingAppointmentsScreen(),
  ].obs;
  RxInt currentIndex = 1.obs;
  void onTap(int index) {
    if (index == 0) {
      isCurrentPast.value = true;
      isCurrentUpcomming.value = false;
      currentIndex.value = index;
    } else {
      isCurrentPast.value = false;
      isCurrentUpcomming.value = true;
      currentIndex.value = index;
    }
  }

  void createAppointment() {
    if (!currentUser.value.isAdmin!) {
      Get.to(
        () => const ServicesScreen(),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInQuad,
        transition: Transition.rightToLeft,
      );
    } else {
      Get.to(
        () => SelectClientScreen(),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInQuad,
        transition: Transition.rightToLeft,
      );
    }
  }
}
