import 'package:atherium_saloon_app/models/appointment_status.dart';
import 'package:atherium_saloon_app/models/employee.dart';
import 'package:atherium_saloon_app/models/treatment.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/agenda_screen/agenda_controller.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../models/appointment.dart';
import '../../utils/constants.dart';

class UpcomingAppointmentsController extends GetxController {
  var upcommingAppointments = <Appointment>[].obs;
  var employeesData = <Employee>[].obs;
  var services = <Treatment>[].obs;
  var status = <AppointmentStatus>[].obs;
  var uid = LoginController.instance.user?.uid;
  RxBool isLoading = false.obs;
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
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(upcommingAppointments[id].id)
        .delete();
    Fluttertoast.showToast(
        msg: 'Appointment deleted Successfully',
        backgroundColor: AppColors.GREEN_COLOR);
  }

  Future<void> loadData() async {
    isLoading.value = true;
    upcommingAppointments = <Appointment>[].obs;
    employeesData = <Employee>[].obs;
    services = <Treatment>[].obs;
    status = <AppointmentStatus>[].obs;
    var data = await FirebaseServices.getFilteredAppointments(
        collection: 'appointments');
    var employees = await FirebaseServices.getData(collection: 'employees');
    var treatments = await FirebaseServices.getData(collection: 'treatments');
    var statusData =
        await FirebaseServices.getData(collection: 'appointment_status');
    if (data != null &&
        AgendaController.instance.currentUser.value.isAdmin! == false) {
      for (var treatment in data) {
        if (treatment['client_id'] == uid &&
            treatment['date_timestamp'].seconds + 86400 >=
                Timestamp.now().seconds) {
          upcommingAppointments.add(Appointment.fromJson(treatment));
        }
      }
      for (var appointment in data) {
        if (appointment['client_id'] == uid) {
          for (int i = 0; i < statusData!.length; i++) {
            if (appointment['status_id'] == statusData[i]['id'] &&
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
        if (employees[i]['id'] == appointment.employeeId![0]) {
          var employee = Employee.fromJson(employees[i]);
          employeesData.add(employee);
          break;
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
    isLoading.value = false;
  }
}
