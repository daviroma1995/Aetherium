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
  void changeTab(int index) {
    currentIndex.value = index;
  }
}
