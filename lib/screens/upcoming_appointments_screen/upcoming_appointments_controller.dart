import 'package:atherium_saloon_app/screens/services_screen/services_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class UpcomingAppointmentsController extends GetxController {
  // TODO
  void createAppointment() {
    Get.to(() => ServicesScreen());
  }
}

enum Status {
  canceled,
  archived,
  noshow,
  confirmed,
}

class UserAppointmetn {
  final String imageUrl;
  final String title;
  final String subTitle;
  final Status status;
  final String date;
  final String time;
  UserAppointmetn({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.status,
    required this.date,
    required this.time,
  });
  Color get color {
    switch (status) {
      case (Status.archived):
        return AppColors.ARCHIVED_COLOR;
      case (Status.canceled):
        return AppColors.CANCELED_COLOR;
      case (Status.confirmed):
        return AppColors.CONFIRMED_COLOR;
      case (Status.noshow):
        return AppColors.NO_SHOW_COLOR;
    }
  }

  String get appointmentStatus {
    switch (status) {
      case (Status.archived):
        return 'Archived';
      case (Status.canceled):
        return 'Canceled';
      case (Status.confirmed):
        return 'Confirmed';
      case (Status.noshow):
        return 'No-Show';
    }
  }
}

List upcomingAppointments = [];
