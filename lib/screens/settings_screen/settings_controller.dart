// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/notification_permission_screen/notification_permission_screen.dart';
import 'package:atherium_saloon_app/screens/pdf_view_screen/pdf_view_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/policies.dart';
import '../../utils/constants.dart';

class SettingsController extends GetxController {
  var data = <Policies>[];
  var urls = <String>[];
  @override
  void onInit() async {
    var query = await FirebaseFirestore.instance.collection('policies').get();
    var docs = query.docs;
    for (var doc in docs) {
      var documentData = doc.data();
      var url =
          await FirebaseServices.getDownloadUrl(documentData['file_path']);
      data.add(Policies.fromJson(documentData));
      urls.add(url);
    }

    super.onInit();
  }

  void handleBack() {
    Get.back();
  }

  navigationHandle(int index) async {
    if(index == 0){
      Get.to(() => NotificationPermissionScreen());
    }
    if (index == 1) {
      Get.to(() => PdfViewScreen(
            path: urls[0],
            title: data[0].name!,
          ));
    } else if (index == 2) {
      Get.to(() => PdfViewScreen(
            path: urls[1],
            title: data[1].name!,
          ));
    }
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
