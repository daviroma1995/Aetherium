import 'dart:convert';
import 'dart:developer';

import 'package:atherium_saloon_app/models/appointment_status.dart';
import 'package:atherium_saloon_app/models/employee.dart';
import 'package:atherium_saloon_app/models/treatment.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/agenda_screen/agenda_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/appointment.dart';
import '../../models/client.dart';
import '../../models/treatment_category.dart';
import '../../utils/constants.dart';
import '../home_screen/home_screen_controller.dart';

class UpcomingAppointmentsController extends GetxController {
  var upcommingAppointments = <Appointment>[].obs;
  var employeesData = <Employee>[].obs;
  var services = <Treatment>[].obs;
  var status = <AppointmentStatus>[].obs;
  var uid = FirebaseServices.cuid;
  var listOfClients = <Client>[];
  RxBool isLoading = false.obs;
  bool isAdmin = AgendaController.instance.currentUser.value.isAdmin ?? false;
  var listOfTreatmentCategory = <TreatmentCategory>[];
  var treatmentCategoryList = <TreatmentCategory>[];
  @override
  void onInit() async {
    super.onInit();
    await loadData();
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

  // void createAppointment() {
  //   // Get.to(() => ServicesScreen());
  //   print(uid);
  // }

  Future<void> deleteAppointment(int id) async {
    try {
      var appointmentId = upcommingAppointments[id].id;
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
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(upcommingAppointments[id].id)
          .delete()
          .then((value) async {});
      var homeController = Get.find<HomeScreenController>();
      homeController.loadHomeScreen();
      var agenda = Get.find<AgendaController>();
      agenda.loadData();
      Fluttertoast.showToast(
          msg: tr('appointment_deleted_successfully'),
          backgroundColor: AppColors.GREEN_COLOR);
    } catch (ex) {
      // Fluttertoast.showToast(msg: 'Something went wrong');
      log(ex.toString());
    }
  }

  Future<void> loadData() async {
    isLoading.value = true;
    upcommingAppointments = <Appointment>[].obs;
    employeesData = <Employee>[].obs;
    services = <Treatment>[].obs;
    status = <AppointmentStatus>[].obs;
    listOfClients = [];
    var data = await FirebaseServices.getFilteredAppointments(
        collection: 'appointments');
    var employees = await FirebaseServices.getData(collection: 'employees');
    var treatments = await FirebaseServices.getData(collection: 'treatments');
    var clients = await FirebaseServices.getData(collection: 'clients');
    var statusData =
        await FirebaseServices.getData(collection: 'appointment_status');
    var homeController = Get.find<HomeScreenController>();
    var listOftreatmentCategories = homeController.treatmentCategories;
    if (data != null &&
        AgendaController.instance.currentUser.value.isAdmin! == false) {
      for (var treatment in data) {
        if (treatment['client_id'] == uid &&
            treatment['is_regular'] == true &&
            treatment['date_timestamp'].seconds + 86400 >=
                Timestamp.now().seconds) {
          upcommingAppointments.add(Appointment.fromJson(treatment));
        }
      }
      for (var appointment in data) {
        if (appointment['client_id'] == uid) {
          for (int i = 0; i < statusData!.length; i++) {
            if (appointment['status_id'] == statusData[i]['id'] &&
                appointment['is_regular'] == true &&
                appointment['date_timestamp'].seconds + 86400 >=
                    Timestamp.now().seconds) {
              status.add(AppointmentStatus.fromJson(statusData[i]));
            }
          }
        }
      }
    } else {
      for (var treatment in data!) {
        if (treatment['date_timestamp'].seconds + 86400 >=
            Timestamp.now().seconds) {
          upcommingAppointments.add(Appointment.fromJson(treatment));
        }
      }
      for (var appointment in data) {
        for (int i = 0; i < statusData!.length; i++) {
          if (appointment['status_id'] == statusData[i]['id'] &&
              appointment['date_timestamp'].seconds + 86400 >=
                  Timestamp.now().seconds) {
            status.add(AppointmentStatus.fromJson(statusData[i]));
            break;
          }
        }
      }
    }
    for (var appointment in upcommingAppointments) {
      for (int i = 0; i < employees!.length; i++) {
        if (appointment.employeeId != null &&
            appointment.employeeId!.isNotEmpty) {
          if (employees[i]['id'] == appointment.employeeId?[0]) {
            var employee = Employee.fromJson(employees[i]);
            employeesData.add(employee);
            break;
          } else {
            employeesData.add(Employee(name: tr('appointment')));
          }
        }
      }
    }
    for (var appointment in upcommingAppointments) {
      for (int i = 0; i < treatments!.length; i++) {
        if (appointment.serviceId![0] == treatments[i]['id']) {
          services.add(Treatment.fromJson(treatments[i]));
          break;
        }
      }
    }
    for (var appointment in upcommingAppointments) {
      if (clients != null) {
        var client = clients
            .firstWhere((element) => element['id'] == appointment.clientId);
        listOfClients.add(Client.fromJson(client));
      }
    }
    for (var service in services) {
      var treatmentCategory = listOftreatmentCategories
          .firstWhere((element) => element.id == service.treatmentCategoryId);
      listOfTreatmentCategory.add(treatmentCategory);
    }
    upcommingAppointments.sort((a, b) => a.dateTimestamp!.compareTo(b.dateTimestamp!));

    isLoading.value = false;
  }
}
