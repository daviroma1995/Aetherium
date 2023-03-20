// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/screens/contacts_screen/contacts_screen.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class SettingsController extends GetxController {
  navigationHandle(int index) {
    if (index == 0) Get.to(() => ContactsScreen());
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
  SettingItem(title: AppLanguages.CONTACTS, iconUrl: AppAssets.PROFILE_ICON),
  SettingItem(
      title: AppLanguages.NOTIFICATION_SETTINGS, iconUrl: AppAssets.BELL_ICON),
  SettingItem(
      title: AppLanguages.TERMS_OF_SERVICE, iconUrl: AppAssets.FILE_ICON),
  SettingItem(title: AppLanguages.TERMS_OF_USE, iconUrl: AppAssets.CROWN_ICON),
  SettingItem(title: AppLanguages.PRIVACY, iconUrl: AppAssets.SHIELD_ICON),
];
