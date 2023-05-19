import 'dart:io';

import 'package:atherium_saloon_app/models/employee.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/shop_info.dart';

class ContactsController extends GetxController {
  var shopinfo = ShopInfo().obs;
  var beautySpecialists = <Employee>[].obs;
  RxBool isInitialized = false.obs;
  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      shopinfo.bindStream(FirebaseServices.shopInfoStream());
      beautySpecialists.bindStream(FirebaseServices.employeeStrem());
      isInitialized.value = true;
    });
  }

  void openwhatsapp() async {
    var whatsapp = shopinfo.value.phoneNumber;
    if (Platform.isAndroid) {
      // add the [https]
      Uri url = Uri.parse(
          "https://wa.me/$whatsapp:/?text=${Uri.parse('')}"); // new line
      print(launchUrl(url));
    } else {
      // add the [https]
      Uri url = Uri.parse(
          "https://api.whatsapp.com/send?phone=$whatsapp=${Uri.parse('')}"); // new line
      print(launchUrl(url));
    }
  }

  void launchWhatsApp() async {
    var whatsapp = shopinfo.value.phoneNumber;

    String url() {
      if (Platform.isAndroid) {
        return "http://wa.me/$whatsapp";
      } else {
        return "http://api.whatsapp.com/send?phone=$whatsapp";
      }
    }

    // if (await canLaunchUrl(Uri.parse(url()))) {
    await launchUrl(Uri.parse(url()), mode: LaunchMode.externalApplication);
    // } else {
    //  Fluttertoast.showToast(msg: 'Application is not installed');
    //}
  }
}

class ShopTime {
  final String day;
  final String? startTime;
  final String? endTim;
  ShopTime({
    required this.day,
    this.startTime,
    this.endTim,
  });
}

List<ShopTime> timeTable = [
  ShopTime(day: 'Monday', startTime: '8:00 AM', endTim: '8:30 Am'),
  ShopTime(day: 'Tuesday', startTime: '8:00 AM', endTim: '8:30 Am'),
  ShopTime(day: 'Wednesday', startTime: '8:00 AM', endTim: '8:30 Am'),
  ShopTime(day: 'Thursday', startTime: '8:00 AM', endTim: '8:30 Am'),
  ShopTime(day: 'Friday', endTim: 'Closed'),
  ShopTime(day: 'Saturday', endTim: 'Closed'),
];

class BeautySpecialist {
  String name;
  String designation;
  String imageUrl;
  BeautySpecialist({
    required this.name,
    required this.designation,
    required this.imageUrl,
  });
}

List<BeautySpecialist> beautySpecialist = [
  BeautySpecialist(
    name: 'Ruth Okazaki',
    designation: 'Fragrances & Perfumes',
    imageUrl: AppAssets.USER_IMAGE,
  ),
  BeautySpecialist(
    name: 'Ruth Okazaki',
    designation: 'Fragrances & Perfumes',
    imageUrl: AppAssets.PROFILE_IMAGE_ONE,
  ),
  BeautySpecialist(
    name: 'Ruth Okazaki',
    designation: 'Fragrances & Perfumes',
    imageUrl: AppAssets.PROFILE_IMAGE_TWO,
  ),
  BeautySpecialist(
    name: 'Ruth Okazaki',
    designation: 'Fragrances & Perfumes',
    imageUrl: AppAssets.PROFILE_PIC,
  )
];
