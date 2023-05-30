import 'dart:developer';

import 'package:atherium_saloon_app/models/treatment_category.dart';
import 'package:atherium_saloon_app/screens/appointment_details/appointment_details.dart';
import 'package:atherium_saloon_app/screens/appointments_screen/appointments_screen.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';

import 'package:atherium_saloon_app/screens/services_screen/services_screen.dart';
import 'package:atherium_saloon_app/utils/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/appointment.dart';
import '../../models/client.dart';
import '../../models/employee.dart';
import '../../models/event.dart';
import '../../models/treatment.dart';
import '../../network_utils/firebase_services.dart';
import '../../utils/constants.dart';
import '../event_details/event_details_screen.dart';
import '../../models/notification.dart' as notification;

class HomeScreenController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt searchServicesLength = 0.obs;
  RxBool isVisible = true.obs;
  RxBool isInitialized = false.obs;
  RxBool shoueldReload = false.obs;
  var currentUser = Client().obs;
  late String _uid;
  var events = <Event>[].obs;
  var appointments = <Appointment>[].obs;
  var appointmentsEmployee = <Employee>[].obs;
  var notifications = <notification.Notification>[].obs;
  var services = <Treatment>[].obs;
  var treatmentCategories = <TreatmentCategory>[].obs;
  var searchedService = "".obs;

  @override
  void onInit() async {
    isLoading.value = true;
    _uid = LoginController.instance.auth.currentUser!.uid;
    treatmentCategories.value = await FirebaseServices.getTreatmentCategories();
    log(treatmentCategories.toString());
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        var map = await FirebaseServices.getCurrentUser();
        currentUser.value = Client.fromJson(map);

        appointmentsEmployee.bindStream(FirebaseServices.employeeStrem());
        notifications
            .bindStream(FirebaseServices.getUnreadNotficationsStream());
        events.bindStream(FirebaseServices.eventStream());

        isInitialized.value = true;
        LocalData.setIsLogedIn(true);
        var treatments =
            await FirebaseServices.getData(collection: 'treatments');
        var data = await FirebaseServices.getAppointments(
            isAdmin: currentUser.value.isAdmin!);
        appointments.value = data;
        appointments.forEach(
          (appointment) {
            for (int i = 0; i < treatments!.length; i++) {
              if (appointment.serviceId![0] == treatments[i]['id']) {
                services.add(Treatment.fromJson(treatments[i]));
              }
            }
          },
        );
      },
    );
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    print('Ready called');
  }

  void navigateToAppointmentDetail(int index) {
    Get.to(
      () => AppointmentDetailsScreen(
          appointment: appointments[index], isEditable: true),
      duration: const Duration(milliseconds: 600),
      transition: Transition.rightToLeft,
      arguments: appointments[index].clientId,
    );
  }

  final searchController = TextEditingController();
  void onChange(String value) {
    searchedService.value = value;
  }

  void onFocus() {
    isVisible.value = false;
    searchServicesLength.value = services.length;
  }

  void setFavorite(int index) async {
    if (events[index].isfavorite == true) {
      events[index].clientId!.removeWhere((element) => element == _uid);
    } else {
      events[index].clientId!.add(_uid);
    }
    FirebaseServices.toggleFavorite(
        eventId: events[index].eventId!, data: events[index]);
    events[index].isfavorite = !events[index].isfavorite!;
  }
  // Get Employee name

  String getEmployeeName(String id) {
    for (var employee in appointmentsEmployee) {
      if (employee.id == id) {
        return employee.name!;
      }
    }
    return 'No Name!';
  }

  String getServices(String id) {
    for (var treatments in services) {
      if (treatments.id == id) {
        return treatments.name!;
      }
    }
    return '';
  }

  void navigateToServices() {
    Get.to(
      () => ServicesScreen(),
      duration: const Duration(milliseconds: 600),
      curve: Curves.linear,
      transition: Transition.rightToLeft,
    );
  }

  void navigateToAppointments() {
    Get.to(
      () => const AppointmentsScreen(),
      duration: const Duration(milliseconds: 600),
      curve: Curves.linear,
      transition: Transition.rightToLeft,
    );
  }

  void serviceNavigation(int index) {
    Get.to(() => ServicesScreen(),
        arguments: index,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInCubic,
        transition: Transition.downToUp);
  }

  void eventNavigation(int index) async {
    final result = await Get.to(
      () => EventDetailsScreen(),
      arguments: events[index],
      transition: Transition.downToUp,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInCubic,
    );
    if (result != null) {
      events[index].isfavorite = result;
      if (shoueldReload.value == true) {
        shoueldReload.value = false;
      } else {
        shoueldReload.value = true;
      }
    }
  }

  Future<void> onRefresh() async {
    _uid = LoginController.instance.user?.uid ?? '';
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        var map = await FirebaseServices.getCurrentUser();
        currentUser.value = Client.fromJson(map);

        appointmentsEmployee.bindStream(FirebaseServices.employeeStrem());
        notifications
            .bindStream(FirebaseServices.getUnreadNotficationsStream());
        events.bindStream(FirebaseServices.eventStream());

        isInitialized.value = true;
        LocalData.setIsLogedIn(true);
        var treatments =
            await FirebaseServices.getData(collection: 'treatments');

        var data = await FirebaseServices.getAppointments(
            isAdmin: currentUser.value.isAdmin!);
        appointments.value = data;

        appointments.forEach(
          (appointment) {
            for (int i = 0; i < treatments!.length; i++) {
              if (appointment.serviceId![0] == treatments[i]['id']) {
                services.add(Treatment.fromJson(treatments[i]));
              }
            }
          },
        );
      },
    );
  }
}

List searchServices = [];

// TODO  Fake data will me removed soon

List services = [
  {
    'service_title': 'Textured Skin',
    'service_image': AppAssets.MIRROR_ICON,
    'dark_image': AppAssets.DARK_MIRROR_ICON,
  },
  {
    'service_title': 'Hair',
    'service_image': AppAssets.HAIR_ICON,
    'dark_image': AppAssets.DARK_HAIR_ICON,
  },
  {
    'service_title': 'Porcelain',
    'service_image': AppAssets.PORCELAIN_ICON,
    'dark_image': AppAssets.DARK_PORCELAIN_ICON,
  },
  {
    'service_title': 'Emergent',
    'service_image': AppAssets.EMERGENT_ICON,
    'dark_image': AppAssets.DARK_EMERGENT_ICON,
  },
];

// class Appointment {
//   final String userName;
//   final String subTitle;
//   final String imageUrl;
//   final String time;
//   final String date;
//   Appointment({
//     required this.userName,
//     required this.subTitle,
//     required this.imageUrl,
//     required this.time,
//     required this.date,
//   });
// }

// List upcomingAppointments = [
//   Appointment(
//     userName: 'Ruth Okazaki',
//     subTitle: 'Fragrances & Perfumes',
//     imageUrl: AppAssets.PROFILE_IMAGE_ONE,
//     time: '8:02 AM',
//     date: '06/02/2022',
//   ),
//   Appointment(
//     userName: 'Ruth Okazaki',
//     subTitle: 'Fragrances & Perfumes',
//     imageUrl: AppAssets.PROFILE_IMAGE_TWO,
//     time: '8:02 AM',
//     date: '06/02/2022',
//   ),
//   Appointment(
//     userName: 'Ruth Okazaki',
//     subTitle: 'Fragrances & Perfumes',
//     imageUrl: AppAssets.PROFILE_IMAGE_TWO,
//     time: '8:02 AM',
//     date: '06/02/2022',
//   ),
// ];

// enum Status {
//   canceled,
//   archived,
//   noshow,
//   confirmed,
// }

// class Agenda {
//   final String startTime;
//   final String endTime;
//   final String duration;
//   final String userName;
//   final String service;
//   final String iamgeUrl;
//   final Status status;
//   Agenda({
//     required this.startTime,
//     required this.endTime,
//     required this.duration,
//     required this.userName,
//     required this.service,
//     required this.iamgeUrl,
//     required this.status,
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
//         return AppColors.NO_SHOW_COLOR;
//     }
//   }

//   Color get darkolor {
//     switch (status) {
//       case (Status.archived):
//         return AppColors.DARK_ARCHIVED_COLOR;
//       case (Status.canceled):
//         return AppColors.DARK_CANCELED_COLOR;
//       case (Status.confirmed):
//         return AppColors.DARK_CONFIRMED_COLOR;
//       case (Status.noshow):
//         return AppColors.DARK_NO_SHOW_COLOR;
//     }
//   }
// }

// List<Agenda> agendas = [
//   Agenda(
//     startTime: '8:00 AM',
//     endTime: '8:30 Am',
//     duration: '30 Mints',
//     userName: 'Savannah Nguyen',
//     service: 'Flair Cosmetics',
//     iamgeUrl: AppAssets.USER_IMAGE,
//     status: Status.canceled,
//   ),
//   Agenda(
//     startTime: '8:00 AM',
//     endTime: '8:30 Am',
//     duration: '30 Mints',
//     userName: 'Savannah Nguyen',
//     service: 'Finesse Cosmetics',
//     iamgeUrl: AppAssets.USER_IMAGE,
//     status: Status.confirmed,
//   ),
//   Agenda(
//     startTime: '8:00 AM',
//     endTime: '8:30 Am',
//     duration: '30 Mints',
//     userName: 'Savannah Nguyen',
//     service: 'Nourish Petals',
//     iamgeUrl: AppAssets.USER_IMAGE,
//     status: Status.noshow,
//   ),
//   Agenda(
//     startTime: '8:00 AM',
//     endTime: '8:30 Am',
//     duration: '30 Mints',
//     userName: 'Savannah Nguyen',
//     service: 'Flair Cosmetics',
//     iamgeUrl: AppAssets.USER_IMAGE,
//     status: Status.archived,
//   ),
//   Agenda(
//     startTime: '8:00 AM',
//     endTime: '8:30 Am',
//     duration: '30 Mints',
//     userName: 'Savannah Nguyen',
//     service: 'Flair Cosmetics',
//     iamgeUrl: AppAssets.USER_IMAGE,
//     status: Status.confirmed,
//   ),
//   Agenda(
//     startTime: '8:00 AM',
//     endTime: '8:30 Am',
//     duration: '30 Mints',
//     userName: 'Savannah Nguyen',
//     service: 'Flair Cosmetics',
//     iamgeUrl: AppAssets.USER_IMAGE,
//     status: Status.noshow,
//   ),
//   Agenda(
//     startTime: '8:00 AM',
//     endTime: '8:30 Am',
//     duration: '30 Mints',
//     userName: 'Savannah Nguyen',
//     service: 'Flair Cosmetics',
//     iamgeUrl: AppAssets.USER_IMAGE,
//     status: Status.canceled,
//   ),
// ];

class LoyalityCard {
  final double totalPoints;
  final double gainedPoints;
  LoyalityCard({
    required this.totalPoints,
    required this.gainedPoints,
  });

  double get percentage {
    return gainedPoints / totalPoints;
  }
}

final loyalityCard = LoyalityCard(totalPoints: 300, gainedPoints: 126);
