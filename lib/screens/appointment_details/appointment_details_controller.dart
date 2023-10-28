import 'dart:io';

import 'package:add_2_calendar/add_2_calendar.dart' as calendar;
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:atherium_saloon_app/models/appointment.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/agenda_screen/agenda_controller.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen_controller.dart';
import 'package:atherium_saloon_app/screens/services_screen/services_screen.dart';
import 'package:atherium_saloon_app/screens/upcoming_appointments_screen/upcoming_appointments_controller.dart';
import 'package:atherium_saloon_app/screens/update_appointment_status/update_appointment_status_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/treatment.dart';

class AppointmentDetailsController extends GetxController {
  final durationText = TextEditingController();
  var allTreatments = <Treatment>[].obs;
  RxString endTime = ''.obs;
  final appointmentServicesIds = Get.arguments;
  var servicesList = <Treatment>[].obs;
  bool isChanged = false;
  RxInt price = 0.obs;
  bool isAdmin =
      Get.find<AgendaController>().currentUser.value.isAdmin ?? false;
  late WebViewController controller;
  late calendar.Event event;
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

  Future<void> addToCalendar({
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required String email,
  }) async {
    event = calendar.Event(
      title: title,
      description: description,
      location: 'Aetherium Estetica Saloon',
      startDate: startDate,
      endDate: endDate,
      timeZone: DateTime.now().timeZoneName,
      iosParams: const IOSParams(
        reminder: Duration(
            hours:
                1), // on iOS, you can set alarm notification after your event.
      ),
      androidParams: AndroidParams(
        emailInvites: [email],
        // on Android, you can add invite emails to your event.
      ),
    );
    bool isAdded = await calendar.Add2Calendar.addEvent2Cal(event);
    print(isAdded);
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
        transition: Platform.isIOS ? null : Transition.downToUp,
        arguments: appointment);
    isChanged = data;
  }

  void editStatus(Appointment appointment) {
    Get.to(
      () => UpdateAppointmentStatusScreen(appointment: appointment),
      duration: const Duration(milliseconds: 700),
      curve: Curves.linear,
      transition: Platform.isIOS ? null : Transition.downToUp,
      arguments: appointment,
    );
  }

  Future<bool> updateDuration(Appointment appointment, num duration) async {
    String endTimeStr = appointment.endTime!;
    DateTime endTimeDate = DateTime.parse(endTimeStr);
    endTimeDate =
        endTimeDate.add(Duration(minutes: int.parse(durationText.text)));
    String hours = endTimeDate.hour.toString();
    String minutes = endTimeDate.minute.toString();
    endTime.value = '$hours:$minutes';
    endTimeStr = endTimeDate.toIso8601String();
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointment.id)
          .set({
        "total_duration": FieldValue.increment(duration),
        "end_time": endTimeStr,
      }, SetOptions(merge: true));
      var homeController = Get.find<HomeScreenController>();
      homeController.loadAppointments();
      var agendaController = Get.find<AgendaController>();
      agendaController.loadData();
      Get.find<UpcomingAppointmentsController>().loadData();
      return true;
    } catch (ex) {
      stdout.writeln('Error: $ex');
      return false;
    }
  }

  String getEndTime(String startTime, num duration, Appointment appointment) {
    String endTimeStr = appointment.endTime!;
    DateTime endTimeDate = DateTime.parse(endTimeStr);
    if (durationText.text.isNotEmpty) {
      endTimeDate =
          endTimeDate.add(Duration(minutes: int.parse(durationText.text)));
    }
    endTime.value =
        '${endTimeDate.hour < 10 ? '0${endTimeDate.hour}' : endTimeDate.hour}:${endTimeDate.minute < 10 ? '0${endTimeDate.minute}' : endTimeDate.minute}';
    return endTime.toString();

    String hours;
    String minutes;
    if (startTime[1] != ':') {
      hours = startTime[0] + startTime[1];
      if (startTime.length == 5) {
        minutes = startTime[3] + startTime[4];
      } else {
        minutes = startTime[3];
      }
    } else {
      hours = startTime[0];
      if (startTime.length == 4) {
        minutes = startTime[2] + startTime[3];
      } else {
        minutes = startTime[2];
      }
    }
    String endHours = (duration / 60).toString()[0];
    String endMinutes = (duration % 60).toString();

    var endTimeHours = num.parse(hours) + num.parse(endHours);
    var endTimeMinutes = num.parse(minutes) + num.parse(endMinutes);
    if (endTimeMinutes >= 60) {
      endTimeHours += 1;
      endTimeMinutes -= 60;
    }
    if (endTimeHours >= 24) {
      endTimeHours = endTimeHours - 24;
    }
    String totalEndHours =
        endTimeHours < 9 ? '0$endTimeHours' : endTimeHours.toString();
    String totalMinutes =
        endTimeMinutes < 9 ? '0$endTimeMinutes' : endTimeMinutes.toString();
    endTime.value = '$totalEndHours:$totalMinutes';
    return '$totalEndHours:$totalMinutes';
  }
}
