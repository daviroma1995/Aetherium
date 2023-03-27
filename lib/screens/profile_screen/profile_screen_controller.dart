// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/screens/account_info_screen/account_info_screen.dart';
import 'package:atherium_saloon_app/screens/agenda_screen/agenda_screen.dart';
import 'package:atherium_saloon_app/screens/consultations_screen/consultations_screen.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_screen.dart';
import 'package:atherium_saloon_app/screens/settings_screen/settings_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appointments_screen/appointments_screen.dart';

class ProfileController extends GetxController {
  // TODO Implementation required

  void Navigator(int index) {
    if (index == profileItems.length - 1) {
      Get.offAll(LoginScreen());
    }
    if (index == 0) Get.to(() => AppointmentsScreen());
    if (index == 1) Get.to(() => SettingsScreen());
    if (index == 2) Get.to(() => ConsultationsScreen());
    if (index == 3) Get.to(() => AccountInfoScreen());
  }
}

class ProfileItem {
  final String title;
  final String iconUrl;
  const ProfileItem({
    required this.title,
    required this.iconUrl,
  });
}

List<ProfileItem> profileItems = const [
  ProfileItem(
      title: AppLanguages.MY_APPOINTMENTS, iconUrl: AppAssets.BOOK_ICON),
  ProfileItem(title: AppLanguages.SETTINGS, iconUrl: AppAssets.SETTINGS_ICON),
  ProfileItem(
      title: AppLanguages.CONSULTATIONS,
      iconUrl: AppAssets.INVITE_FRIENDS_ICON),
  ProfileItem(
      title: AppLanguages.ACCOUNT_INFO_DETAIL, iconUrl: AppAssets.PROFILE_ICON),
  ProfileItem(title: AppLanguages.LOGOUT, iconUrl: AppAssets.EXIT_ICON),
];
