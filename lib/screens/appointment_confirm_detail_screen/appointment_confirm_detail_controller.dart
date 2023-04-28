import 'package:atherium_saloon_app/screens/appointment_confirm_screen/appointment_confirm_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/appointment.dart';
import '../../models/treatment.dart';
import '../../network_utils/firebase_services.dart';

class AppointmentConfirmDetailController extends GetxController {
  var args = Get.arguments;
  var allTreatments = <Treatment>[].obs;
  final appointmentServicesIds = Get.arguments;
  var servicesList = <Treatment>[].obs;
  RxInt price = 0.obs;

  @override
  void onInit() {
    super.onInit();
    allTreatments.bindStream(FirebaseServices.treatments());
  }

  String getName(String id) {
    for (var treatment in allTreatments) {
      if (treatment.id == id) {
        return treatment.name!;
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });

    return '';
  }

  String getTime(String id) {
    for (var treatment in allTreatments) {
      if (treatment.id == id) {
        return treatment.duration!;
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
    return '';
  }

  void getTreatment(String id) {
    for (var treatment in allTreatments) {
      if (treatment.id == id) {
        servicesList.add(treatment);
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
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
    print(id);
    int tempPrice = 0;
    for (var treatment in allTreatments) {
      if (treatment.id == id) {
        if (!prices.contains(treatment.price)) {
          prices.add(treatment.price);
          var sum = prices.forEach((element) {
            tempPrice += int.parse(element);
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            update();
          });
        }
        price.value = tempPrice;
        return treatment.price.toString();
      }
    }
    return '';
  }

  String getTotalPrice(List<Treatment> services) {
    int price = 0;
    services.forEach((service) {
      price += int.parse(service.price!);
    });
    return price.toString();
  }

  double totalprice = 0.0;
  double get totalPrice {
    if (args!.isNotEmpty && totalprice == 0.0) {
      for (int i = 0; i < args!.length; i++) {
        totalprice += args![i].price;
      }
    }
    return totalprice;
  }

  void confirm() {
    if (args.id == null) {
      print('new appointment');
      FirebaseFirestore.instance.collection('appointments').add(args.toJson());
      Get.to(
        () => const AppointmentConfirmScreen(),
        duration: const Duration(milliseconds: 400),
        transition: Transition.leftToRight,
        curve: Curves.linear,
      );
    } else {
      print('update appointment');
      var appointment = Appointment;
      FirebaseFirestore.instance
          .collection('appointments')
          .doc(args.id)
          .update(args.toJson());
      Get.to(
        () => const AppointmentConfirmScreen(),
        duration: const Duration(milliseconds: 400),
        transition: Transition.leftToRight,
        curve: Curves.linear,
      );
    }
  }
}
