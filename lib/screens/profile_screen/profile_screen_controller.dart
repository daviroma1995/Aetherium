// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/screens/account_info_screen/account_info_screen.dart';

import 'package:atherium_saloon_app/screens/consultations_screen/consultations_screen.dart';
import 'package:atherium_saloon_app/screens/contacts_screen/contacts_screen.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:atherium_saloon_app/screens/scan_screen/scan_screen.dart';
import 'package:atherium_saloon_app/screens/settings_screen/settings_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/utils/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appointments_screen/appointments_screen.dart';
import '../login_screen/login_screen.dart';

class ProfileController extends GetxController {
  late String uid;

  void navigator(int index) async {
    if (index == profileItems.length - 1) {
      // Get.offAll(
      //   () => LoginScreen(),
      //   duration: const Duration(milliseconds: 500),
      //   transition: Transition.circularReveal,
      //   curve: Curves.ease,
      // );
      LoginController.instance.logout();
    }
    if (index == 0) {
      Get.to(
        () => AppointmentsScreen(),
        duration: const Duration(milliseconds: 500),
        transition: Transition.rightToLeft,
        curve: Curves.ease,
      );
    }
    if (index == 1) {
      Get.to(
        () => SettingsScreen(),
        duration: const Duration(milliseconds: 500),
        transition: Transition.rightToLeft,
        curve: Curves.ease,
      );
    }
    if (index == 2) {
      Get.to(
        () => ConsultationsScreen(),
        duration: const Duration(milliseconds: 500),
        transition: Transition.rightToLeft,
        curve: Curves.ease,
      );
    }
    if (index == 3) {
      Get.to(
        () => ContactsScreen(),
        duration: const Duration(milliseconds: 500),
        transition: Transition.rightToLeft,
        curve: Curves.ease,
      );
    }
    if (index == 4) {
      Get.to(
        () => AccountInfoScreen(),
        duration: const Duration(milliseconds: 500),
        transition: Transition.rightToLeft,
        curve: Curves.ease,
      );
    }
    if (index == 5) {
      Get.to(
        () => ScanScreen(),
        duration: const Duration(milliseconds: 500),
        transition: Transition.rightToLeft,
        curve: Curves.ease,
      );
    }
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
      title: AppLanguages.MY_APPOINTMENTS, iconUrl: AppAssets.CALANDER_ICON),
  ProfileItem(title: AppLanguages.SETTINGS, iconUrl: AppAssets.SETTINGS_ICON),
  ProfileItem(
      title: AppLanguages.CONSULTATIONS, iconUrl: AppAssets.CONSULTATIONS_ICON),
  ProfileItem(title: AppLanguages.CONTACTS, iconUrl: AppAssets.PROFILE_ICON),
  ProfileItem(
      title: AppLanguages.ACCOUNT_INFO_DETAIL,
      iconUrl: AppAssets.PROFILE_INFO_ICON),
  ProfileItem(title: AppLanguages.SCAN, iconUrl: AppAssets.SCAN_ICON),
  ProfileItem(title: AppLanguages.LOGOUT, iconUrl: AppAssets.EXIT_ICON),
];
