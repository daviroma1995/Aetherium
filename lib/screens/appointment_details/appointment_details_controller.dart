import 'dart:developer';

import 'package:atherium_saloon_app/models/appointment.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:atherium_saloon_app/screens/services_screen/services_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/treatment.dart';

class AppointmentDetailsController extends GetxController {
  var allTreatments = <Treatment>[].obs;
  final appointmentServicesIds = Get.arguments;
  var servicesList = <Treatment>[].obs;
  bool isChanged = false;
  RxInt price = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    allTreatments.bindStream(await FirebaseServices.treatments());
  }

  String totalPrice(List<String> service) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
    double totalPrice = 0.0;
    allTreatments.forEach((element) {
      for (int i = 0; i < service.length; i++) {
        if (service[i] == element.id) {
          totalPrice += double.parse(element.price!.toString());
        }
      }
    });

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
    prices.forEach((price) {
      totalprice += int.parse(price);
      price.value = totalprice.toString();
      update();
    });
    return totalprice.toString();
  }

  String getPrice(String id) {
    double tempPrice = 0;
    for (var treatment in allTreatments) {
      if (treatment.id == id) {
        if (!prices.contains(treatment.price)) {
          prices.add(treatment.price);
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
      () => ServicesScreen(uid: appointment.clientId),
      duration: const Duration(milliseconds: 700),
      curve: Curves.linear,
      transition: Transition.downToUp,
      arguments: appointment,
    );
    isChanged = data;
  }
}
