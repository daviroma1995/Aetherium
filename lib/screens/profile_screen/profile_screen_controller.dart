// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/models/client.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/account_info_screen/account_info_screen.dart';
import 'package:atherium_saloon_app/screens/agenda_screen/agenda_controller.dart';

import 'package:atherium_saloon_app/screens/consultations_screen/consultations_screen.dart';
import 'package:atherium_saloon_app/screens/contacts_screen/contacts_screen.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen_controller.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:atherium_saloon_app/screens/loyality_card_screen/loyality_card_controller.dart';
import 'package:atherium_saloon_app/screens/scan_screen/scan_screen.dart';
import 'package:atherium_saloon_app/screens/settings_screen/settings_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../appointments_screen/appointments_screen.dart';

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
    uid = FirebaseServices.cuid;
    // if (LoginController.instance.auth.currentUser == null) {
    //   Get.offAll(() => LoginScreen());
    // }
    var data = await FirebaseServices.getCurrentUser();
    user.value = Client.fromJson(data);
    if (data['isAdmin'] == false) {
      profileItems = [
        ProfileItem(
            title: tr('my_appointments'), iconUrl: AppAssets.CALANDER_ICON),
        ProfileItem(title: tr('settigns'), iconUrl: AppAssets.SETTINGS_ICON),
        ProfileItem(
            title: tr('consultations'), iconUrl: AppAssets.CONSULTATIONS_ICON),
        ProfileItem(title: tr('contacts'), iconUrl: AppAssets.PROFILE_ICON),
        ProfileItem(
            title: tr('my_information'), iconUrl: AppAssets.PROFILE_INFO_ICON),
        ProfileItem(title: tr('logout'), iconUrl: AppAssets.EXIT_ICON),
      ];
    } else {
      profileItems = [
        ProfileItem(
            title: tr('my_appointments'), iconUrl: AppAssets.CALANDER_ICON),
        ProfileItem(title: tr('settigns'), iconUrl: AppAssets.SETTINGS_ICON),
        ProfileItem(
            title: tr('consultations'), iconUrl: AppAssets.CONSULTATIONS_ICON),
        ProfileItem(title: tr('contacts'), iconUrl: AppAssets.PROFILE_ICON),
        ProfileItem(
            title: tr('my_information'), iconUrl: AppAssets.PROFILE_INFO_ICON),
        ProfileItem(title: tr('scan'), iconUrl: AppAssets.SCAN_ICON),
        ProfileItem(title: tr('logout'), iconUrl: AppAssets.EXIT_ICON),
      ];
    }
    super.onInit();
  }

  /// this will delete cache
  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  void navigator(int index) async {
    if (index == profileItems.length - 1) {
      // Get.offAll(
      //   () => LoginScreen(),
      //   duration: const Duration(milliseconds: 500),
      //   transition: Transition.circularReveal,
      //   curve: Curves.ease,
      // );
      // Get.reloadAll();
      final LoginController controller = Get.put(LoginController());
      _deleteCacheDir();
      Get.delete<HomeScreenController>(force: true);
      Get.delete<AgendaController>(force: true);
      Get.delete<LoyalityCardController>(force: true);
      Get.delete<ProfileController>(force: true);
      controller.logout();
      // LocalData.setIsLogedIn(false);
      // Get.offAll(() => LoginScreen());
    }
    if (index == 0) {
      Get.to(
        () => const AppointmentsScreen(),
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
          () => const ScanScreen(),
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
