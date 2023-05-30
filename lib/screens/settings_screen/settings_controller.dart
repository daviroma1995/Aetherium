// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/constants.dart';
import 'package:http/http.dart' as http;

class SettingsController extends GetxController {
  void handleBack() {
    Get.back();
  }

  navigationHandle(int index) async {
    if (index == 1) {}
  }
}

class SettingItem {
  final String title;
  final String iconUrl;
  const SettingItem({
    required this.title,
    required this.iconUrl,
  });
}

List<SettingItem> settingsItems = const [
  SettingItem(
      title: AppLanguages.NOTIFICATION_SETTINGS, iconUrl: AppAssets.BELL_ICON),
  SettingItem(
      title: AppLanguages.TERMS_OF_SERVICE, iconUrl: AppAssets.FILE_MINUS),
  SettingItem(title: AppLanguages.PRIVACY, iconUrl: AppAssets.LOCK),
];
