import 'package:atherium_saloon_app/screens/appointment_confirm_screen/appointment_confirm_screen.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/treatment.dart';
import '../../network_utils/firebase_services.dart';
import '../agenda_screen/agenda_controller.dart';

class AppointmentConfirmDetailController extends GetxController {
  var args = Get.arguments;
  var allTreatments = <Treatment>[].obs;
  final appointmentServicesIds = Get.arguments;
  var servicesList = <Treatment>[].obs;
  RxInt price = 0.obs;
  String selectedStatus = '';
  String previousStatus = '';
  @override
  void onInit() {
    super.onInit();
    allTreatments.bindStream(FirebaseServices.treatments());
  }

  @override
  void onClose() {
    super.onClose();
    allTreatments.close();
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
        return treatment.duration!.toString();
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
    for (var price in prices) {
      totalprice += int.parse(price);
      price.value = totalprice.toString();
      update();
    }
    return totalprice.toString();
  }

  String getPrice(String id) {
    int tempPrice = 0;
    for (var treatment in allTreatments) {
      if (treatment.id == id) {
        if (!prices.contains(treatment.price)) {
          prices.add(treatment.price);
          // ignore: avoid_function_literals_in_foreach_calls, unused_local_variable
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
    double price = 0;
    for (var service in services) {
      price += double.parse(service.price!.toString());
    }
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

  void confirm() async {
    HomeScreenController homeController = Get.find();
    AgendaController agendaController = Get.find();

    if (args.id == null) {
      FirebaseFirestore.instance.collection('appointments').add(args.toJson());
      Get.to(
        () => const AppointmentConfirmScreen(),
        duration: const Duration(milliseconds: 400),
        transition: Transition.leftToRight,
        curve: Curves.linear,
      );
      homeController.loadHomeScreen();
      agendaController.loadData();
    } else {
      FirebaseFirestore.instance.collection('appointments').doc(args.id).set({
        'date': args.date,
        'time': args.time,
        'date_timestamp': args.dateTimestamp,
        'notes': args.notes,
        'start_time': args.startTime,
        'end_time': args.endTime,
        'total_duration': args.duration,
        'employee_id_list': args.employeeId,
        'treatment_id_list': args.serviceId,
        'status_id': args.statusId,
      }, SetOptions(merge: true));
      homeController.loadHomeScreen();
      agendaController.loadData();
      print(selectedStatus != '');
      print(selectedStatus.toLowerCase() == 'archiviato');
      print('Selected : $selectedStatus');
      print(previousStatus.toLowerCase() != 'archiviato');
      print('Previous: $previousStatus');
      var snapshot = await FirebaseFirestore.instance.collection('client_memberships').doc(args.clientId).get();
      var data = snapshot.data();
      var points = data?['points'];
      if (selectedStatus != '' &&
          selectedStatus.toLowerCase() == 'archiviato' &&
          previousStatus.toLowerCase() != 'archiviato' &&
          points + 25 <= 300) {
        print('if Called');
        await FirebaseFirestore.instance.collection('client_memberships').doc(args.clientId).update(
          {
            "points": FieldValue.increment(25),
          },
        );
        await homeController.loadHomeScreen();
        await agendaController.loadData();
      } else if (previousStatus.toLowerCase() == 'archiviato' &&
          selectedStatus.toLowerCase() != 'archiviato' &&
          points - 25 >= 0) {
        print('Else if called');
        await FirebaseFirestore.instance.collection('client_memberships').doc(args.clientId).update(
          {
            "points": FieldValue.increment(-25),
          },
        );
        await homeController.loadHomeScreen();
        await agendaController.loadData();
      } else {
        print('Else called');
        print(selectedStatus);
        print(previousStatus);
        print(points);
        await homeController.loadHomeScreen();
        await agendaController.loadData();
      }
      await homeController.loadHomeScreen();
      await agendaController.loadData();
      homeController.refresh();
      Get.to(
        () => const AppointmentConfirmScreen(),
        duration: const Duration(milliseconds: 400),
        transition: Transition.leftToRight,
        curve: Curves.linear,
      );
      // await homeController.loadHomeScreen();
      // await agendaController.loadData();
    }
  }

  String getEndTime(String startTime, num duration) {
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
    String endHours = (duration ~/ 60).toString().replaceAll('-', '')[0];
    String endMinutes = (duration % 60).toString();

    var endTimeHours = int.parse(hours) + int.parse(endHours);
    var endTimeMinutes = int.parse(minutes) + int.parse(endMinutes);
    if (endTimeMinutes >= 60) {
      endTimeHours += 1;
      endTimeMinutes -= 60;
    }
    if (endTimeHours >= 24) {
      endTimeHours = endTimeHours - 24;
    }
    String totalEndHours = endTimeHours < 9 ? '0$endTimeHours' : endTimeHours.toString();
    String totalMinutes = endTimeMinutes < 9 ? '0$endTimeMinutes' : endTimeMinutes.toString();

    return '$totalEndHours:$totalMinutes';
  }
}
