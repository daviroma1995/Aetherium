// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/utils/constants.dart';

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

class Appointment {
  final String userName;
  final String subTitle;
  final String imageUrl;
  final String time;
  final String date;
  Appointment({
    required this.userName,
    required this.subTitle,
    required this.imageUrl,
    required this.time,
    required this.date,
  });
}

List upcomingAppointments = [
  Appointment(
    userName: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    imageUrl: AppAssets.PROFILE_IMAGE_ONE,
    time: '8:02 AM',
    date: '06/02/2022',
  ),
  Appointment(
    userName: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    imageUrl: AppAssets.PROFILE_IMAGE_TWO,
    time: '8:02 AM',
    date: '06/02/2022',
  ),
  Appointment(
    userName: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    imageUrl: AppAssets.PROFILE_IMAGE_TWO,
    time: '8:02 AM',
    date: '06/02/2022',
  ),
];

class Events {
  final String imageUrl;
  final String title;
  final String subTitle;
  final String date;

  RxBool isFavorite;
  Events({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.isFavorite,
  });
}

List<Events> events = [
  Events(
    imageUrl: AppAssets.EVENT_IMAGE_ONE,
    title: 'Flourish Essentials',
    subTitle: 'Fragrances & Perfumes',
    date: '06/02/2022',
    isFavorite: false.obs,
  ),
  Events(
    imageUrl: AppAssets.EVENT_IMAGE_TWO,
    title: 'Embrace Skincare',
    subTitle: 'Fragrances & Perfumes',
    date: '06/02/2022',
    isFavorite: false.obs,
  ),
  Events(
    imageUrl: AppAssets.EVENT_IMAGE_THREE,
    title: 'Flourish Essentials',
    subTitle: 'Fragrances & Perfumes',
    date: '06/02/2022',
    isFavorite: false.obs,
  ),
];

enum Status {
  canceled,
  archived,
  noshow,
  confirmed,
}

class Agenda {
  final String startTime;
  final String endTime;
  final String duration;
  final String userName;
  final String service;
  final String iamgeUrl;
  final Status status;
  Agenda({
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.userName,
    required this.service,
    required this.iamgeUrl,
    required this.status,
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

  Color get darkolor {
    switch (status) {
      case (Status.archived):
        return AppColors.DARK_ARCHIVED_COLOR;
      case (Status.canceled):
        return AppColors.DARK_CANCELED_COLOR;
      case (Status.confirmed):
        return AppColors.DARK_CONFIRMED_COLOR;
      case (Status.noshow):
        return AppColors.DARK_NO_SHOW_COLOR;
    }
  }
}

List<Agenda> agendas = [
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Flair Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: Status.canceled,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Finesse Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: Status.confirmed,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Nourish Petals',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: Status.noshow,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Flair Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: Status.archived,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Flair Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: Status.confirmed,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Flair Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: Status.noshow,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Flair Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: Status.canceled,
  ),
];

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
