// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/utils/constants.dart';

List services = [
  {
    'service_title': 'Textured Skin',
    'service_image': AppAssets.MIRROR_ICON,
  },
  {
    'service_title': 'Hair',
    'service_image': AppAssets.HAIR_ICON,
  },
  {
    'service_title': 'Porcelain',
    'service_image': AppAssets.PORCELAIN_ICON,
  },
  {
    'service_title': 'Emergent',
    'service_image': AppAssets.EMERGENT_ICON,
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

class Event {
  final String imageUrl;
  final String title;
  final String subTitle;
  final String date;

  RxBool isFavorite;
  Event({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.isFavorite,
  });
}

List<Event> events = [
  Event(
    imageUrl: AppAssets.EVENT_IMAGE_ONE,
    title: 'Flourish Essentials',
    subTitle: 'Fragrances & Perfumes',
    date: '06/02/2022',
    isFavorite: false.obs,
  ),
  Event(
    imageUrl: AppAssets.EVENT_IMAGE_TWO,
    title: 'Flourish Essentials',
    subTitle: 'Fragrances & Perfumes',
    date: '06/02/2022',
    isFavorite: false.obs,
  ),
  Event(
    imageUrl: AppAssets.EVENT_IMAGE_THREE,
    title: 'Flourish Essentials',
    subTitle: 'Fragrances & Perfumes',
    date: '06/02/2022',
    isFavorite: false.obs,
  ),
];

enum AgendaStatus {
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
  final AgendaStatus status;
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
      case (AgendaStatus.archived):
        return AppColors.ARCHIVED_COLOR;
      case (AgendaStatus.canceled):
        return AppColors.CANCELED_COLOR;
      case (AgendaStatus.confirmed):
        return AppColors.CONFIRMED_COLOR;
      case (AgendaStatus.noshow):
        return AppColors.NO_SHOW_COLOR;
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
    status: AgendaStatus.canceled,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Finesse Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: AgendaStatus.confirmed,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Nourish Petals',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: AgendaStatus.noshow,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Flair Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: AgendaStatus.archived,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Flair Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: AgendaStatus.confirmed,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Flair Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: AgendaStatus.noshow,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Flair Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: AgendaStatus.canceled,
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
