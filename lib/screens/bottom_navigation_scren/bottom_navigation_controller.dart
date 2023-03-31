import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../agenda_screen/agenda_screen.dart';
import '../home_screen/home_screen.dart';
import '../loyality_card_screen/loyality_card_screen.dart';
import '../profile_screen/profile_screen.dart';

class BottomNavigationController extends GetxController {
  RxInt currentIndex = 0.obs;
  final screens = [
    HomeScreen(),
    const AgendaScreen(),
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
