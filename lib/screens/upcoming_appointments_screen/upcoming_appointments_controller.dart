import 'package:atherium_saloon_app/models/employee.dart';
import 'package:atherium_saloon_app/models/treatment.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/agenda_screen/agenda_controller.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:atherium_saloon_app/screens/services_screen/services_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../models/appointment.dart';
import '../../utils/constants.dart';

class UpcomingAppointmentsController extends GetxController {
  var upcommingAppointments = <Appointment>[].obs;
  var employeesData = <Employee>[].obs;
  var services = <Treatment>[].obs;
  var uid = LoginController.instance.user.uid;
  @override
  void onInit() async {
    var data = await FirebaseServices.getData(collection: 'appointments');
    var employees = await FirebaseServices.getData(collection: 'employees');
    var treatments = await FirebaseServices.getData(collection: 'treatments');
    if (data != null &&
        AgendaController.instance.currentUser.value.isAdmin! == false) {
      data.forEach((treatment) {
        if (treatment['client_id'] == uid &&
            treatment['date_timestamp'].seconds >= Timestamp.now().seconds) {
          upcommingAppointments.add(Appointment.fromJson(treatment));
        }
      });
    } else {
      data!.forEach((treatment) {
        if (treatment['date_timestamp'].seconds >= Timestamp.now().seconds) {
          upcommingAppointments.add(Appointment.fromJson(treatment));
        }
      });
    }
    upcommingAppointments.forEach((appointment) {
      // appointment.employeeId!.forEach((employeeId) {
      // for (int i = 0; i < employees!.length; i++) {
      //   if (employees[i]['id'] == employeeId) {
      //     var employee = Employee.fromJson(employees[i]);
      //     employeesData.add(employee);
      //   }
      //   }
      // });
      for (int i = 0; i < employees!.length; i++) {
        if (employees[i]['id'] == appointment.employeeId![0]) {
          var employee = Employee.fromJson(employees[i]);
          employeesData.add(employee);
          break;
        }
      }
    });
    upcommingAppointments.forEach((appointment) {
      // appointment.serviceId!.forEach((serviceId) {
      //   for (int i = 0; i < treatments!.length; i++) {
      //     if (serviceId == treatments[i]['id']) {
      //       services.add(Treatment.fromJson(treatments[i]));
      //     }
      //   }
      // });
      for (int i = 0; i < treatments!.length; i++) {
        if (appointment.serviceId![0] == treatments[i]['id']) {
          services.add(Treatment.fromJson(treatments[i]));
          break;
        }
      }
    });
    super.onInit();
  }

  void createAppointment() {
    // Get.to(() => ServicesScreen());
    print(uid);
  }
}
