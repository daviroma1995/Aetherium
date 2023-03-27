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
    AgendaScreen(),
    LoyalityCardScreen(),
    ProfileScreen(),
  ];
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  void changeTab(int index) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    currentIndex.value = index;
  }
}
