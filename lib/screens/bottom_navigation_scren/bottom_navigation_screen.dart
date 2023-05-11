// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_controller.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen.dart';
import 'package:atherium_saloon_app/screens/profile_screen/profile_screen.dart';
import 'package:atherium_saloon_app/screens/services_screen/services_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../add_new_client/new_client_screen.dart';
import '../agenda_screen/agenda_screen.dart';
import '../loyality_card_screen/loyality_card_screen.dart';
import '../select_client_screen/select_client_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final controller = Get.put(BottomNavigationController());
  int _currentIndex = 0;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            if (value == 2) {
              return;
            } else {
              setState(() {
                _currentIndex = value;
              });
            }

            controller.changeTab(value);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor:
              isDark ? AppColors.PRIMARY_DARK : AppColors.PRIMARY_COLOR,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.SECONDARY_LIGHT,
          unselectedItemColor: AppColors.WHITE_COLOR,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: .75,
            height: 1.4,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            letterSpacing: .75,
            height: 1.4,
          ),
          items: [
            BottomNavigationBarItem(
              backgroundColor:
                  isDark ? AppColors.PRIMARY_DARK : AppColors.PRIMARY_COLOR,
              icon: SvgPicture.asset(
                AppAssets.HOME_ICON,
                colorFilter: ColorFilter.mode(
                    _currentIndex == 0
                        ? AppColors.SECONDARY_LIGHT
                        : AppColors.WHITE_COLOR,
                    BlendMode.srcIn),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor:
                  isDark ? AppColors.PRIMARY_DARK : AppColors.PRIMARY_COLOR,
              icon: SvgPicture.asset(
                AppAssets.CALANDER_ICON,
                height: 24.0,
                width: 24.0,
                colorFilter: ColorFilter.mode(
                    _currentIndex == 1
                        ? AppColors.SECONDARY_LIGHT
                        : AppColors.WHITE_COLOR,
                    BlendMode.srcIn),
              ),
              label: 'Agenda',
            ),
            BottomNavigationBarItem(
              backgroundColor:
                  isDark ? AppColors.PRIMARY_DARK : AppColors.PRIMARY_COLOR,
              icon: const Icon(
                Icons.add,
                color: Colors.transparent,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              backgroundColor:
                  isDark ? AppColors.PRIMARY_DARK : AppColors.PRIMARY_COLOR,
              icon: SvgPicture.asset(
                AppAssets.DEBIT_CARD_ICON,
                height: 24.0,
                width: 24.0,
                colorFilter: ColorFilter.mode(
                    _currentIndex == 3
                        ? AppColors.SECONDARY_LIGHT
                        : AppColors.WHITE_COLOR,
                    BlendMode.srcIn),
              ),
              label: 'Carta',
            ),
            BottomNavigationBarItem(
              backgroundColor:
                  isDark ? AppColors.PRIMARY_DARK : AppColors.PRIMARY_COLOR,
              icon: SvgPicture.asset(
                AppAssets.PROFILE_ICON,
                height: 24.0,
                width: 24.0,
                colorFilter: ColorFilter.mode(
                    _currentIndex == 4
                        ? AppColors.SECONDARY_LIGHT
                        : AppColors.WHITE_COLOR,
                    BlendMode.srcIn),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: PageView(
        allowImplicitScrolling: true,
        onPageChanged: (value) {
          setState(() {
            if (value == 2) {
              _currentIndex = 3;
            } else if (value == 3) {
              _currentIndex = 4;
            } else {
              _currentIndex = value;
            }
          });
        },
        controller: controller.pageController,
        children: [
          HomeScreen(),
          AgendaScreen(),
          LoyalityCardScreen(),
          ProfileScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 150.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Obx(
              () => controller.toggle.value == true
                  ? AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      bottom: controller.bottom.value.toDouble(),
                      left: controller.leftRight.value,
                      child: GestureDetector(
                        onTap: () async {
                          Get.to(
                            () => AddNewClient(),
                            duration: const Duration(milliseconds: 600),
                            transition: Transition.downToUp,
                            curve: Curves.easeInQuad,
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: isDark
                                ? AppColors.PRIMARY_DARK
                                : AppColors.SECONDARY_LIGHT,
                          ),
                          child: SvgPicture.asset(AppAssets.USER_PLUS),
                        ),
                      ),
                    )
                  : Container(),
            ),
            Obx(
              () => controller.toggle.value == true
                  ? AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      bottom: controller.bottom.value.toDouble(),
                      right: controller.leftRight.value,
                      child: GestureDetector(
                        onTap: () async {
                          Get.to(
                            () => SelectClientScreen(),
                            duration: const Duration(milliseconds: 600),
                            transition: Transition.downToUp,
                            curve: Curves.easeInQuad,
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: isDark
                                ? AppColors.PRIMARY_DARK
                                : AppColors.SECONDARY_LIGHT,
                          ),
                          child:
                              SvgPicture.asset(AppAssets.CALANDER_ICON_BUTTON),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            Positioned(
              bottom: 25.0,
              child: GestureDetector(
                onTap: () {
                  if (controller.client.value.isAdmin!) {
                    controller.toggle.value = !controller.toggle.value;
                    controller.bottom.value = 85;
                    controller.leftRight.value = Get.width * .25;
                  } else {
                    Get.to(
                      () => ServicesScreen(),
                      duration: const Duration(milliseconds: 600),
                      transition: Transition.downToUp,
                      curve: Curves.easeInQuad,
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 53.0,
                  width: 53.0,
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 5.0, color: AppColors.WHITE_COLOR),
                    borderRadius: BorderRadius.circular(100.0),
                    color: isDark
                        ? AppColors.PRIMARY_DARK
                        : AppColors.PRIMARY_COLOR,
                  ),
                  child: Obx(
                    () => controller.toggle.value == false
                        ? SvgPicture.asset(AppAssets.PLUSS_BTN)
                        : SvgPicture.asset(AppAssets.CROSS_BTN),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
