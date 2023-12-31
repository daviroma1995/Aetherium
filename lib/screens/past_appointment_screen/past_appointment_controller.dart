// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:atherium_saloon_app/models/appointment_status.dart';
import 'package:atherium_saloon_app/models/employee.dart';
import 'package:atherium_saloon_app/models/treatment_category.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/agenda_screen/agenda_controller.dart';
import 'package:atherium_saloon_app/screens/appointment_details/appointment_details.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/appointment.dart';
import '../../models/client.dart';
import '../../models/treatment.dart';

class PastAppointmentController extends GetxController {
  var pastAppointments = <Appointment>[].obs;
  String currentUid = FirebaseServices.cuid;
  var employees = <Employee>[].obs;
  var appointmentEmployees = <Employee>[].obs;
  var appointmentStatus = <AppointmentStatus>[].obs;
  var services = <Treatment>[].obs;
  RxBool isInititalized = false.obs;
  var listOfTreatmentCategory = <TreatmentCategory>[];
  bool isAdmin = false;
  var treatmentCategoryList = <TreatmentCategory>[];
  var listOfClients = <Client>[];
  @override
  void onInit() async {
    super.onInit();
    await loadData();
  }

  Future<void> loadData() async {
    pastAppointments = <Appointment>[].obs;
    employees = <Employee>[].obs;
    appointmentEmployees = <Employee>[].obs;
    appointmentStatus = <AppointmentStatus>[].obs;
    listOfTreatmentCategory = [];
    services = <Treatment>[].obs;
    isInititalized.value = false;
    var data = await FirebaseServices.getFilteredAppointments(
        collection: 'appointments');
    var treatments = await FirebaseServices.getData(collection: 'treatments');
    var employeeData = await FirebaseServices.getData(collection: 'employees');
    var statusData =
        await FirebaseServices.getData(collection: 'appointment_status');
    var currentClient = await FirebaseServices.getCurrentUser();
    isAdmin = currentClient['isAdmin'];

    // for (var employee in employeeData!) {
    //   employees.add(Employee.fromJson(employee));
    // }
    var homeController = Get.find<HomeScreenController>();
    var listOftreatmentCategories = homeController.treatmentCategories;
    if (AgendaController.instance.currentUser.value.isAdmin!) {
      var clients = await FirebaseServices.getData(collection: 'clients');
      for (var appointment in data!) {
        if (appointment['date_timestamp'].seconds + 86400 <=
            Timestamp.now().seconds) {
          pastAppointments.add(Appointment.fromJson(appointment));
        }
      }
      if (clients != null) {
        for (var appointment in pastAppointments) {
          var client = clients
              .firstWhere((element) => element['id'] == appointment.clientId);
          listOfClients.add(Client.fromJson(client));
        }
      }
      for (var appointment in data) {
        for (int i = 0; i < statusData!.length; i++) {
          if (appointment['status_id'] == statusData[i]['id'] &&
              appointment['date_timestamp'].seconds + 86400 <=
                  Timestamp.now().seconds) {
            appointmentStatus.add(AppointmentStatus.fromJson(statusData[i]));
          }
        }
      }
    } else {
      for (var appointment in data!) {
        if (currentUid == appointment['client_id']) {
          if (appointment['date_timestamp'].seconds + 86400 <=
                  Timestamp.now().seconds &&
              appointment['is_regular'] == true) {
            pastAppointments.add(Appointment.fromJson(appointment));
          }
        }
      }
      for (var appointment in data) {
        if (currentUid == appointment['client_id']) {
          for (int i = 0; i < statusData!.length; i++) {
            if (appointment['status_id'] == statusData[i]['id'] &&
                appointment['is_regular'] == true &&
                appointment['date_timestamp'].seconds + 86400 <=
                    Timestamp.now().seconds) {
              appointmentStatus.add(AppointmentStatus.fromJson(statusData[i]));
            }
          }
        }
      }
    }
    for (var element in employees) {
      // for (int i = 0; i < pastAppointments.length; i++) {
      //   // if (pastAppointments[i].employeeId == element.id) {
      //   //   appointmentEmployees.add(element);
      //   // }
      //   pastAppointments[i].employeeId!.forEach((employeeId) {
      //     if (employeeId == element.id) {
      //       appointmentEmployees.add(element);
      //     }
      //   });
      // }
    }
    for (var appointment in pastAppointments) {
      // appointment.employeeId!.forEach((employeeId) {
      // for (int i = 0; i < employees!.length; i++) {
      //   if (employees[i]['id'] == employeeId) {
      //     var employee = Employee.fromJson(employees[i]);
      //     employeesData.add(employee);
      //   }
      //   }
      // });
      for (int i = 0; i < employeeData!.length; i++) {
        if (appointment.employeeId!.isEmpty) {
          break;
        }
        if (employeeData[i]['id'] == appointment.employeeId?[0]) {
          var employee = Employee.fromJson(employeeData[i]);
          employees.add(employee);
          break;
        } else {
          employees.add(Employee(name: tr('appointment')));
        }
      }
    }
    for (var treatment in treatments!) {
      for (var pastAppointment in pastAppointments) {
        if (treatment['id'] == pastAppointment.serviceId![0]) {
          services.add(Treatment.fromJson(treatment));
        }
      }
    }
    for (var service in services) {
      var treatmentCategory = listOftreatmentCategories
          .firstWhere((element) => element.id == service.treatmentCategoryId);
      listOfTreatmentCategory.add(treatmentCategory);
    }
    isInititalized.value = true;
  }

  Color getColor(String label) {
    switch (label) {
      case "archiviato":
        return AppColors.ARCHIVED_COLOR;
      case "cancellato":
        return AppColors.CANCELED_COLOR;
      case "confermato":
        return AppColors.CONFIRMED_COLOR;
      default:
        return AppColors.NO_SHOW_COLOR;
    }
  }

  goToDetails(int index) async {
    await Get.to(
      () => AppointmentDetailsScreen(
        appointment: pastAppointments[index],
        isDetail: true,
        isPast: true,
        isAdmin: isAdmin,
      ),
      transition: Platform.isIOS ? null : Transition.rightToLeft,
      duration: const Duration(milliseconds: 400),
    )?.then((value) {
      if (value == true) {
        loadData();
      }
    });
  }

  Future<void> deleteAppointment(int id) async {
    try {
      var appointmentId = pastAppointments[id].id;
      var uri = Uri.parse(
          'https://us-central1-aetherium-salon.cloudfunctions.net/googleCalendarEvent');
      var response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "operation": "DELETE",
          "appointment_id": appointmentId,
        }),
      );
      log('Response :: ${response.body}');
    } catch (ex) {
      log("Exception::: ${ex.toString()}");
    }
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(pastAppointments[id].id)
        .delete()
        .then((value) async {});
    var homeControlelr = Get.find<HomeScreenController>();
    var agendaContrller = Get.find<AgendaController>();
    homeControlelr.loadHomeScreen();
    agendaContrller.loadData();
    Fluttertoast.showToast(
        msg: tr('appointment_deleted_successfully'),
        backgroundColor: AppColors.GREEN_COLOR);
  }
}
