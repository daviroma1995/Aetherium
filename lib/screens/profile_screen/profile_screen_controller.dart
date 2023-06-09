// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/models/client.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/account_info_screen/account_info_screen.dart';

import 'package:atherium_saloon_app/screens/consultations_screen/consultations_screen.dart';
import 'package:atherium_saloon_app/screens/contacts_screen/contacts_screen.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:atherium_saloon_app/screens/scan_screen/scan_screen.dart';
import 'package:atherium_saloon_app/screens/settings_screen/settings_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appointments_screen/appointments_screen.dart';
import '../login_screen/login_screen.dart';

List<ProfileItem> profileItems = [
  const ProfileItem(
      title: AppLanguages.MY_APPOINTMENTS, iconUrl: AppAssets.CALANDER_ICON),
  const ProfileItem(
      title: AppLanguages.SETTINGS, iconUrl: AppAssets.SETTINGS_ICON),
  const ProfileItem(
      title: AppLanguages.CONSULTATIONS, iconUrl: AppAssets.CONSULTATIONS_ICON),
  const ProfileItem(
      title: AppLanguages.CONTACTS, iconUrl: AppAssets.PROFILE_ICON),
  const ProfileItem(
      title: AppLanguages.ACCOUNT_INFO_DETAIL,
      iconUrl: AppAssets.PROFILE_INFO_ICON),
  const ProfileItem(title: AppLanguages.SCAN, iconUrl: AppAssets.SCAN_ICON),
  const ProfileItem(title: AppLanguages.LOGOUT, iconUrl: AppAssets.EXIT_ICON),
];

class ProfileController extends GetxController {
  late String uid;
  var user = Client().obs;
  @override
  void onInit() async {
    uid = LoginController.instance.auth.currentUser == null
        ? ''
        : LoginController.instance.auth.currentUser!.uid;
    if (LoginController.instance.auth.currentUser == null) {
      Get.offAll(() => LoginScreen());
    }
    var data = await FirebaseServices.getCurrentUser();
    user.value = Client.fromJson(data);
    if (data['isAdmin'] == false) {
      profileItems = [
        const ProfileItem(
            title: AppLanguages.MY_APPOINTMENTS,
            iconUrl: AppAssets.CALANDER_ICON),
        const ProfileItem(
            title: AppLanguages.SETTINGS, iconUrl: AppAssets.SETTINGS_ICON),
        const ProfileItem(
            title: AppLanguages.CONSULTATIONS,
            iconUrl: AppAssets.CONSULTATIONS_ICON),
        const ProfileItem(
            title: AppLanguages.CONTACTS, iconUrl: AppAssets.PROFILE_ICON),
        const ProfileItem(
            title: AppLanguages.ACCOUNT_INFO_DETAIL,
            iconUrl: AppAssets.PROFILE_INFO_ICON),
        const ProfileItem(
            title: AppLanguages.LOGOUT, iconUrl: AppAssets.EXIT_ICON),
      ];
    } else {
      profileItems = [
        const ProfileItem(
            title: AppLanguages.MY_APPOINTMENTS,
            iconUrl: AppAssets.CALANDER_ICON),
        const ProfileItem(
            title: AppLanguages.SETTINGS, iconUrl: AppAssets.SETTINGS_ICON),
        const ProfileItem(
            title: AppLanguages.CONSULTATIONS,
            iconUrl: AppAssets.CONSULTATIONS_ICON),
        const ProfileItem(
            title: AppLanguages.CONTACTS, iconUrl: AppAssets.PROFILE_ICON),
        const ProfileItem(
            title: AppLanguages.ACCOUNT_INFO_DETAIL,
            iconUrl: AppAssets.PROFILE_INFO_ICON),
        const ProfileItem(
            title: AppLanguages.SCAN, iconUrl: AppAssets.SCAN_ICON),
        const ProfileItem(
            title: AppLanguages.LOGOUT, iconUrl: AppAssets.EXIT_ICON),
      ];
    }
    super.onInit();
  }

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
    if (user.value.isAdmin == true) {
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
}

class ProfileItem {
  final String title;
  final String iconUrl;
  const ProfileItem({
    required this.title,
    required this.iconUrl,
  });
}
