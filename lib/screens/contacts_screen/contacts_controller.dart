import 'package:atherium_saloon_app/models/employee.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
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
