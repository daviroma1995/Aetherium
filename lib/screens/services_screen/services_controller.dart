// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls, unnecessary_overrides, avoid_print

import 'dart:async';
import 'dart:developer';

import 'package:atherium_saloon_app/models/appointment.dart';
import 'package:atherium_saloon_app/models/treatment_category.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:atherium_saloon_app/screens/service_detail_screen/service_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/client.dart';
import '../../models/treatment.dart';
import '../../network_utils/firebase_services.dart';
import '../appointment_booking_screen/appointment_booking_screen.dart';

class ServicesController extends GetxController {
  // late int args;
  ServicesController({this.uid, this.clientEmail, this.number});
  bool isChanged = false;
  var args = Get.arguments;
  var services = <TreatmentCategory>[].obs;
  var subServices = <Treatment>[].obs;
  var selectedServices = <String>[].obs;
  var search = TextEditingController();
  Appointment appointment = Appointment();
  RxString searchedValue = ''.obs;
  var client = Client().obs;
  var list = <String>[];
  var checkedServices = <Treatment>[].obs;
  String? uid;
  String? clientEmail;
  String? number;
  int duration = 0;
  // On Init
  @override
  void onInit() async {
    var _uid = uid ?? FirebaseServices.cuid;
    // services.bindStream(FirebaseServices.treatmentsCategory());
    services.value = await FirebaseServices.getTreatmentCategories();
    subServices.bindStream(await FirebaseServices.getTreatmentsFiltered(_uid));
    client.bindStream(FirebaseServices.currentUserStream());
    if(args != null && args.id != ''){
    appointment = args ?? Appointment();
    list.addAll(args.serviceId);
    }
    print(list);
    Timer(const Duration(milliseconds: 500), () {
      updateScreen();
    });
    super.onInit();
  }
  
  void updateScreen() async {
    if (args != null && services.isNotEmpty && subServices.isNotEmpty) {
      await reArrange();
    }
  }

  List<String> getServiceTitle(List<Treatment> items, index) {
    var titles = <String>[];
    for (var element in items) {
      if (services[index].id == element.treatmentCategoryId) {
        titles.add(element.name!);
      }
    }
    return titles;
  }

  List<String> getServicePrice(List<Treatment> items, index) {
    var titles = <String>[];
    items.forEach((element) {
      if (services[index].id == element.treatmentCategoryId) {
        titles.add(element.price!.toString());
      }
    });
    return titles;
  }

  List<String> getServiceTime(List<Treatment> items, index) {
    var titles = <String>[];
    items.forEach((element) {
      if (services[index].id == element.treatmentCategoryId) {
        titles.add(element.duration!.toString());
      }
    });
    return titles;
  }

  @override
  void onClose() {
    super.onClose();
    subServices.close();
    client.close();
    // if (args != null && args != 0) {
    //   var current = services[0];
    //   var prev = services[args];
    //   var temp = current;
    //   services[0] = prev;
    //   services[args] = temp;
    //   for (int i = 0; i < services.length; i++) {
    //     services[i].isExtended.value = false;
    //   }
    // }
  }

  RxBool isExpanded = false.obs;
  Future<void> reArrange() async {
    var treatmentCategoryId = [];
    if (args == null) {
      return;
    } else {
      try {
        for (var serviceId in args.serviceId) {
          for (var subservice in subServices) {
            if (serviceId == subservice.id) {
              treatmentCategoryId.add(subservice.treatmentCategoryId);
              selectedServices.add(subservice.name!);
            }
          }
        }
        for (var treatementId in treatmentCategoryId) {
          for (var service in services) {
            if (service.id == treatementId) {
              service.isExtended.value = true;

              for (int serviceIndex = 0;
                  serviceIndex < treatmentCategoryId.length;
                  serviceIndex++) {
                final prevService = services[serviceIndex];
                final index = services
                    .indexWhere((element) => element.id == treatementId);
                final currentService = services[index];
                final temp = prevService;
                services[serviceIndex] = currentService;
                services[serviceIndex].isExtended.value = true;
                services[index] = temp;
              }
            }
          }
        }
      } catch (ex) {
        log(ex.toString());
        var past = services[args];
        past.isExtended.value = true;
        var newData = services[0];
        var temp = newData;
        services[0] = past;
        services[args] = temp;
        args = null;
      }
    }
  }

  void reset() {
    for (int i = 1; i < services.length; i++) {
      services[i].isExtended.value = false;
    }
  }

  void dropDownController() {
    isExpanded.value = !isExpanded.value;
  }

  void moveToAppointmentBookingScreen() {
    if (appointment.serviceId == null ||
        args == null && appointment.serviceId!.isEmpty) {
      print('Empty');
    }
     else {
      Get.to(
        () => AppointmentBookingScreen(),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInQuad,
        transition: Transition.rightToLeft,
        arguments: appointment,
      );
    }
  }

  void serviceDetailController(int serviceIndex, int subServiceIndex) {
    String serviceDocId = services[serviceIndex].id!;
    var listSubServices = subServices
        .where((subService) => subService.treatmentCategoryId == serviceDocId)
        .toList();

    Get.to(
      () =>
          ServiceDetailScreen(treatmentData: listSubServices[subServiceIndex]),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInQuad,
      transition: Transition.downToUp,
    );
  }

  void selectedServiceController(int serviceIndex, int subServiceIndex) async {
    isChanged = true;
    var listOfSubServices = subServices
        .where((subService) =>
            subService.treatmentCategoryId == services[serviceIndex].id)
        .toList();
    if (list.isEmpty) {
      list.add(listOfSubServices[subServiceIndex].id!);

      duration += int.parse(listOfSubServices[subServiceIndex].duration!);
      print(checkedServices);
    } else {
      if (list.contains(listOfSubServices[subServiceIndex].id!)) {
        list.removeWhere(
            (element) => element == listOfSubServices[subServiceIndex].id!);

        duration -= int.parse(listOfSubServices[subServiceIndex].duration!);
        print(checkedServices);
      } else {
        list.add(listOfSubServices[subServiceIndex].id!);
        duration += int.parse(listOfSubServices[subServiceIndex].duration!);
        print(checkedServices);
      }
    }

    if (args != null) {
      list = args.serviceId;
      if (list.isEmpty) {
        list.add(listOfSubServices[subServiceIndex].id!);
      } else {
        if (list.contains(listOfSubServices[subServiceIndex].id!)) {
          list.removeWhere(
              (element) => element == listOfSubServices[subServiceIndex].id!);
        } else {
          list.add(listOfSubServices[subServiceIndex].id!);
        }
      }
      print('called');
      appointment = args;
      args = null;
    } else {
      appointment.serviceId = list;
      appointment.clientId = uid ?? FirebaseServices.cuid;
      appointment.email = clientEmail ?? client.value.email;
      appointment.number = number ?? client.value.phoneNumber;
      appointment.employeeId = ['8f1cYZExVjeOo2sBDmQC'];
      appointment.duration = duration;
    }
  }

  void searchService(String value) {
    print(search.text);
    searchedValue.value = search.text;
  }
}
