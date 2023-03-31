// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/screens/appointment_confirm_detail_screen/appointment_confirm_detail_screen.dart';
import 'package:atherium_saloon_app/screens/services_screen/services_controller.dart';

import '../../utils/constants.dart';

class PastAppointmentController extends GetxController {
  goToDetails(int index) {
    Get.to(
        () => AppointmentConfirmDetailScreen(
              isDetail: true,
              isEditable: false,
            ),
        duration: const Duration(milliseconds: 600),
        transition: Transition.rightToLeft,
        arguments: pastAppointments[index].services);
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
  final List<SubService> services;
  UserAppointmetn({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.status,
    required this.date,
    required this.time,
    required this.services,
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

final pastAppointments = <UserAppointmetn>[
  UserAppointmetn(
    imageUrl:
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
    title: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    status: Status.archived,
    date: '22 June',
    time: '6:00 PM',
    services: [
      SubService(title: 'Hair Services', price: 30, time: '30 Min'),
      SubService(title: 'Textured Services', price: 30, time: '30 Min'),
    ],
  ),
  UserAppointmetn(
    imageUrl:
        'https://images.unsplash.com/photo-1517630800677-932d836ab680?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
    title: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    status: Status.noshow,
    date: '22 June',
    time: '6:00 PM',
    services: [
      SubService(title: 'Hair Services', price: 30, time: '30 Min'),
      SubService(title: 'Textured Services', price: 30, time: '30 Min'),
    ],
  ),
  UserAppointmetn(
    imageUrl:
        'https://images.unsplash.com/photo-1502323777036-f29e3972d82f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    title: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    status: Status.canceled,
    date: '22 June',
    time: '6:00 PM',
    services: [
      SubService(title: 'Hair Services', price: 30, time: '30 Min'),
      SubService(title: 'Textured Services', price: 30, time: '30 Min'),
    ],
  ),
  UserAppointmetn(
    imageUrl:
        'https://images.unsplash.com/photo-1541499768294-44cad3c95755?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80',
    title: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    status: Status.confirmed,
    date: '22 June',
    time: '6:00 PM',
    services: [
      SubService(title: 'Hair Services', price: 30, time: '30 Min'),
      SubService(title: 'Textured Services', price: 30, time: '30 Min'),
    ],
  ),
  UserAppointmetn(
    imageUrl:
        'https://images.unsplash.com/photo-1541499768294-44cad3c95755?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80',
    title: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    status: Status.confirmed,
    date: '22 June',
    time: '6:00 PM',
    services: [
      SubService(title: 'Hair Services', price: 30, time: '30 Min'),
      SubService(title: 'Textured Services', price: 30, time: '30 Min'),
    ],
  ),
  UserAppointmetn(
    imageUrl:
        'https://images.unsplash.com/photo-1541499768294-44cad3c95755?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80',
    title: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    status: Status.confirmed,
    date: '22 June',
    time: '6:00 PM',
    services: [
      SubService(title: 'Hair Services', price: 30, time: '30 Min'),
      SubService(title: 'Textured Services', price: 30, time: '30 Min'),
    ],
  ),
  UserAppointmetn(
    imageUrl:
        'https://images.unsplash.com/photo-1541499768294-44cad3c95755?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80',
    title: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    status: Status.confirmed,
    date: '22 June',
    time: '6:00 PM',
    services: [
      SubService(title: 'Hair Services', price: 30, time: '30 Min'),
      SubService(title: 'Textured Services', price: 30, time: '30 Min'),
    ],
  ),
  UserAppointmetn(
    imageUrl:
        'https://images.unsplash.com/photo-1541499768294-44cad3c95755?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80',
    title: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    status: Status.confirmed,
    date: '22 June',
    time: '6:00 PM',
    services: [
      SubService(title: 'Hair Services', price: 30, time: '30 Min'),
      SubService(title: 'Textured Services', price: 30, time: '30 Min'),
    ],
  ),
  UserAppointmetn(
    imageUrl:
        'https://images.unsplash.com/photo-1541499768294-44cad3c95755?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80',
    title: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    status: Status.confirmed,
    date: '22 June',
    time: '6:00 PM',
    services: [
      SubService(title: 'Hair Services', price: 30, time: '30 Min'),
      SubService(title: 'Textured Services', price: 30, time: '30 Min'),
    ],
  ),
  UserAppointmetn(
    imageUrl:
        'https://images.unsplash.com/photo-1541499768294-44cad3c95755?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80',
    title: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    status: Status.confirmed,
    date: '22 June',
    time: '6:00 PM',
    services: [
      SubService(title: 'Hair Services', price: 30, time: '30 Min'),
      SubService(title: 'Textured Services', price: 30, time: '30 Min'),
    ],
  ),
  UserAppointmetn(
    imageUrl:
        'https://images.unsplash.com/photo-1541499768294-44cad3c95755?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80',
    title: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    status: Status.confirmed,
    date: '22 June',
    time: '6:00 PM',
    services: [
      SubService(title: 'Hair Services', price: 30, time: '30 Min'),
      SubService(title: 'Textured Services', price: 30, time: '30 Min'),
    ],
  ),
];
