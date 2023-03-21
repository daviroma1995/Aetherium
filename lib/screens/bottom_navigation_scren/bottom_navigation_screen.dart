// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_controller.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen.dart';
import 'package:atherium_saloon_app/screens/profile_screen/profile_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/bottom_navigation_pill_widget.dart';
import '../agenda_screen/agenda_screen.dart';
import '../loyality_card_screen/loyality_card_screen.dart';

class BottomNavigationScreen extends StatelessWidget {
  final controller = Get.put(BottomNavigationController());

  BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => IndexedStack(
                // index: controller.currentIndex.value,
                children: [
                  controller.screens[controller.currentIndex.value],
                ],
              ),
            ),
          ),
          Container(
            height: 80.0,
            color: Theme.of(context).colorScheme.onSurface,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width < 321 ? 10.0 : 22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => BottomNavigationPill(
                            index: 0,
                            iconUrl: controller.currentIndex.value == 0
                                ? AppAssets.HOME_ICON_SOLID
                                : AppAssets.HOME_ICON,
                            label: 'Home',
                            isCurrent: controller.currentIndex.value == 0,
                            onTap: controller.changeTab,
                          ),
                        ),
                        Obx(
                          () => BottomNavigationPill(
                            index: 1,
                            iconUrl: controller.currentIndex.value == 1
                                ? AppAssets.PEN_ICON_SOLID
                                : AppAssets.PEN_ICON,
                            label: 'Agenda',
                            isCurrent: controller.currentIndex.value == 1,
                            onTap: controller.changeTab,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width < 321
                                  ? (Get.width / 100) * 2.5
                                  : (Get.width / 100) * 4),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 5.0, color: AppColors.WHITE_COLOR),
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: const Text(
                                '+',
                                style: TextStyle(
                                  color: AppColors.WHITE_COLOR,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => BottomNavigationPill(
                            index: 2,
                            iconUrl: controller.currentIndex.value == 2
                                ? AppAssets.DEBIT_CARD_ICON_SOLID
                                : AppAssets.DEBIT_CARD_ICON,
                            label: 'Loyalty card',
                            isCurrent: controller.currentIndex.value == 2,
                            onTap: controller.changeTab,
                          ),
                        ),
                        Obx(
                          () => BottomNavigationPill(
                            index: 3,
                            iconUrl: controller.currentIndex.value == 3
                                ? AppAssets.PROFILE_ICON_SOLID
                                : AppAssets.PROFILE_ICON,
                            label: 'Profile',
                            isCurrent: controller.currentIndex.value == 3,
                            onTap: controller.changeTab,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
