import 'dart:io';

import 'package:atherium_saloon_app/models/appointment.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/agenda_screen/agenda_controller.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen_controller.dart';
import 'package:atherium_saloon_app/screens/services_screen/services_screen.dart';
import 'package:atherium_saloon_app/screens/update_appointment_status/update_appointment_status_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/treatment.dart';

class AppointmentDetailsController extends GetxController {
  var allTreatments = <Treatment>[].obs;
  final appointmentServicesIds = Get.arguments;
  var servicesList = <Treatment>[].obs;
  bool isChanged = false;
  RxInt price = 0.obs;
  bool isAdmin =
      Get.find<AgendaController>().currentUser.value.isAdmin ?? false;
  @override
  void onInit() async {
    super.onInit();
    allTreatments.bindStream(FirebaseServices.treatments());
  }

  @override
  void onClose() {
    super.onClose();
    allTreatments.close();
  }

  String totalPrice(List<String> service) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
    double totalPrice = 0.0;
    for (var element in allTreatments) {
      for (int i = 0; i < service.length; i++) {
        if (service[i] == element.id) {
          totalPrice += double.parse(element.price!.toString());
        }
      }
    }

    return totalPrice.toString();
  }

  String getName(String id) {
    for (var treatment in allTreatments) {
      if (treatment.id == id) {
        return treatment.name!;
      }
    }
    return '';
  }

  String getTime(String id) {
    for (var treatment in allTreatments) {
      if (treatment.id == id) {
        return treatment.duration!.toString();
      }
    }
    return '';
  }

  void getTreatment(String id) {
    for (var treatment in allTreatments) {
      if (treatment.id == id) {
        servicesList.add(treatment);
      }
    }
  }

  var prices = [];
  String getToatlPrice() {
    var totalprice = 0;
    for (var price in prices) {
      totalprice += int.parse(price);
      price.value = totalprice.toString();
      update();
    }
    return totalprice.toString();
  }

  String getPrice(String id) {
    double tempPrice = 0;
    for (var treatment in allTreatments) {
      if (treatment.id == id) {
        if (!prices.contains(treatment.price)) {
          prices.add(treatment.price);
          // ignore: avoid_function_literals_in_foreach_calls, unused_local_variable
          var sum = prices.forEach((element) {
            tempPrice += double.parse(element);
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            update();
          });
        }
        price.value = tempPrice.toInt();
        return treatment.price.toString();
      }
    }
    return '';
  }

  void onEdit(Appointment appointment) async {
    var data = await Get.to(
        () => ServicesScreen(
              uid: appointment.clientId,
              isEditing: true,
              date: appointment.date,
              time: appointment.time,
              appointment: appointment,
            ),
        duration: const Duration(milliseconds: 700),
        curve: Curves.linear,
        transition: Transition.downToUp,
        arguments: appointment);
    isChanged = data;
  }

  void editStatus(Appointment appointment) {
    Get.to(
      () => UpdateAppointmentStatusScreen(appointment: appointment),
      duration: const Duration(milliseconds: 700),
      curve: Curves.linear,
      transition: Transition.downToUp,
      arguments: appointment,
    );
  }

  Future<bool> updateDuration(Appointment appointment, num duration) async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointment.id)
          .set({"total_duration": FieldValue.increment(duration)},
              SetOptions(merge: true));
      var homeController = Get.find<HomeScreenController>();
      homeController.loadAppointments();
      var agendaController = Get.find<AgendaController>();
      agendaController.loadData();
      return true;
    } catch (ex) {
      stdout.writeln('Error: $ex');
      return false;
    }
  }
}
