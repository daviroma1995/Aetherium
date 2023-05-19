import 'package:atherium_saloon_app/models/client.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../agenda_screen/agenda_screen.dart';
import '../home_screen/home_screen.dart';
import '../loyality_card_screen/loyality_card_screen.dart';
import '../profile_screen/profile_screen.dart';

class BottomNavigationController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxString buttonText = '+'.obs;
  var client = Client().obs;
  RxBool toggle = false.obs;
  RxInt bottom = 25.obs;
  RxDouble leftRight = (Get.width / 2 - 25).obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    var data = await FirebaseServices.getDataWhere(
        collection: 'clients',
        key: 'user_id',
        value: LoginController.instance.user?.uid ?? '') ;
    client.value = Client.fromJson(data!);
  }

  final screens = [
    HomeScreen(),
    AgendaScreen(),
    LoyalityCardScreen(),
    ProfileScreen(),
  ];
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  void changeTab(int index) {
    if (index == 3) {
      pageController.animateToPage(2,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      currentIndex.value = 2;
    } else if (index == 4) {
      pageController.animateToPage(3,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      currentIndex.value = index;
    }
  }
}
