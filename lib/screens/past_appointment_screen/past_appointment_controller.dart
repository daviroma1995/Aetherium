// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/models/appointment_status.dart';
import 'package:atherium_saloon_app/models/employee.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/agenda_screen/agenda_controller.dart';
import 'package:atherium_saloon_app/screens/appointment_details/appointment_details.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/appointment.dart';

class PastAppointmentController extends GetxController {
  var pastAppointments = <Appointment>[].obs;
  String currentUid = LoginController.instance.user.uid;
  var employees = <Employee>[].obs;
  var appointmentEmployees = <Employee>[].obs;
  var appointmentStatus = <AppointmentStatus>[].obs;
  RxBool isInititalized = false.obs;
  @override
  void onInit() async {
    super.onInit();
    var data = await FirebaseServices.getData(collection: 'appointments');
    var employeeData = await FirebaseServices.getData(collection: 'employees');
    var statusData =
        await FirebaseServices.getData(collection: 'appointment_status');

    // for (var employee in employeeData!) {
    //   employees.add(Employee.fromJson(employee));
    // }

    if (AgendaController.instance.currentUser.value.isAdmin!) {
      for (var appointment in data!) {
        if (appointment['date_timestamp'].seconds + 86400 <=
            Timestamp.now().seconds) {
          pastAppointments.add(Appointment.fromJson(appointment));
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
              Timestamp.now().seconds) {
            pastAppointments.add(Appointment.fromJson(appointment));
          }
        }
      }
      for (var appointment in data) {
        if (currentUid == appointment['client_id']) {
          for (int i = 0; i < statusData!.length; i++) {
            if (appointment['status_id'] == statusData[i]['id'] &&
                appointment['date_timestamp'].seconds + 86400 <=
                    Timestamp.now().seconds) {
              appointmentStatus.add(AppointmentStatus.fromJson(statusData[i]));
            }
          }
        }
      }
    }
    print(pastAppointments);
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
    pastAppointments.forEach((appointment) {
      // appointment.employeeId!.forEach((employeeId) {
      // for (int i = 0; i < employees!.length; i++) {
      //   if (employees[i]['id'] == employeeId) {
      //     var employee = Employee.fromJson(employees[i]);
      //     employeesData.add(employee);
      //   }
      //   }
      // });
      for (int i = 0; i < employeeData!.length; i++) {
        if (employeeData[i]['id'] == appointment.employeeId![0]) {
          var employee = Employee.fromJson(employeeData[i]);
          employees.add(employee);
          break;
        }
      }
    });
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

  goToDetails(int index) {
    Get.to(
      () => AppointmentDetailsScreen(
        appointment: pastAppointments[index],
        isDetail: true,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 400),
    );
  }
}

enum Status {
  canceled,
  archived,
  noshow,
  confirmed,
}

// class UserAppointmetn {
//   final String imageUrl;
//   final String title;
//   final String subTitle;
//   final Status status;
//   final String date;
//   final String time;
//   final List<Treatment> services;
//   UserAppointmetn({
//     required this.imageUrl,
//     required this.title,
//     required this.subTitle,
//     required this.status,
//     required this.date,
//     required this.time,
//     required this.services,
//   });
//   Color get color {
//     switch (status) {
//       case (Status.archived):
//         return AppColors.ARCHIVED_COLOR;
//       case (Status.canceled):
//         return AppColors.CANCELED_COLOR;
//       case (Status.confirmed):
//         return AppColors.CONFIRMED_COLOR;
//       case (Status.noshow):
//         return AppColors.GREY_COLOR;
//     }
//   }

//   String get appointmentStatus {
//     switch (status) {
//       case (Status.archived):
//         return 'Archived';
//       case (Status.canceled):
//         return 'Canceled';
//       case (Status.confirmed):
//         return 'Confirmed';
//       case (Status.noshow):
//         return 'No-Show';
//     }
//   }
// }
