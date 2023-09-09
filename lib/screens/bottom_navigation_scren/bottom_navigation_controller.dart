import 'package:atherium_saloon_app/models/client.dart';
import 'package:atherium_saloon_app/models/treatment_category.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../agenda_screen/agenda_screen.dart';
// import '../home_screen/home_screen.dart';
import '../loyality_card_screen/loyality_card_screen.dart';
import '../profile_screen/profile_screen.dart';

class BottomNavigationController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxString buttonText = '+'.obs;
  var client = Client().obs;
  RxBool toggle = false.obs;
  RxInt bottom = 25.obs;
  RxDouble leftRight = (Get.width / 2 - 25).obs;
  late final AnimationController rightButtonController;
  late final AnimationController leftButtonController;
  var treatmentCategories = <TreatmentCategory>[].obs;
  @override
  void onInit() async {
    super.onInit();

    if (FirebaseAuth.instance.currentUser != null) {
      var data = await FirebaseServices.getDataWhere(
          collection: 'clients', key: 'user_id', value: FirebaseServices.cuid);
      client.value = Client.fromJson(data ?? {});
    }
  }

  @override
  void onClose() {
    super.onClose();
    rightButtonController.dispose();
    leftButtonController.dispose();
  }

  final screens = [
    // HomeScreen(),
    AgendaScreen(),
    LoyalityCardScreen(),
    ProfileScreen(),
  ];
  final PageController pageController = PageController(initialPage: 0);
  void changeTab(int index) {
    // if (index == 1) {

    // }
    if (index == 3) {
      currentIndex.value = 2;
      pageController.animateToPage(2,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else if (index == 4) {
      pageController.animateToPage(3,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      currentIndex.value = index;
    }
  }

  void reverse() {
    rightButtonController.reverse();
    leftButtonController.reverse();
    toggle.value = false;
  }

  void forward() {
    rightButtonController.forward();
    leftButtonController.forward();
    toggle.value = true;
  }
}
