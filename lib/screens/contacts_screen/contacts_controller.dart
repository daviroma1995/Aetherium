// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:get/get.dart';

class ContactsController extends GetxController {
  // TODO
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
