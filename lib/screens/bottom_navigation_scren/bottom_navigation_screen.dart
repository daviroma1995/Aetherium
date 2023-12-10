// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_controller.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen.dart';
import 'package:atherium_saloon_app/screens/profile_screen/profile_screen.dart';
import 'package:atherium_saloon_app/screens/services_screen/services_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
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

class _BottomNavigationScreenState extends State<BottomNavigationScreen>
    with TickerProviderStateMixin {
  late Animation _rightButtonXAnimation;
  late Animation _rightButtonYAnimation;

  late Animation _leftButtonXAnimation;
  late Animation _leftButtonYAnimation;

  @override
  void initState() {
    controller.rightButtonController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    controller.leftButtonController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _rightButtonXAnimation = Tween<double>(begin: 0.0, end: 50.0).animate(
        CurvedAnimation(
            parent: controller.rightButtonController, curve: Curves.bounceOut));
    _rightButtonYAnimation = Tween<double>(begin: 0.0, end: -50.0).animate(
        CurvedAnimation(
            parent: controller.rightButtonController, curve: Curves.bounceOut));

    _leftButtonXAnimation = Tween<double>(begin: 0.0, end: -50.0).animate(
        CurvedAnimation(
            parent: controller.leftButtonController, curve: Curves.bounceOut));
    _leftButtonYAnimation = Tween<double>(begin: 0.0, end: -50.0).animate(
        CurvedAnimation(
            parent: controller.leftButtonController, curve: Curves.bounceOut));
    controller.treatmentCategories.value = Get.arguments;
    super.initState();
  }

  // @override
  // void dispose() {
  //   controller.leftButtonController.dispose();
  //   controller.rightButtonController.dispose();
  //   super.dispose();
  // }

  final controller = Get.put(BottomNavigationController());
  int _currentIndex = 0;

  // PageController pageController =
  //     PageController(initialPage: 0, keepPage: true);

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
              label: tr('home'),
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
              label: tr('agenda'),
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
              label: tr('card'),
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
              label: tr('profile'),
            ),
          ],
        ),
      ),
      body: PageView(
        allowImplicitScrolling: true,
        onPageChanged: (value) {
          controller.reverse();
          setState(
            () {
              if (value == 2) {
                _currentIndex = 3;
              } else if (value == 3) {
                _currentIndex = 4;
              } else {
                _currentIndex = value;
              }
            },
          );
        },
        controller: controller.pageController,
        children: [
          HomeScreen(controller.treatmentCategories),
          AgendaScreen(),
          LoyalityCardScreen(),
          ProfileScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 150.0,
        width: 150.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 25.0,
              child: AnimatedBuilder(
                animation: controller.leftButtonController,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.translationValues(
                        _leftButtonXAnimation.value,
                        _leftButtonYAnimation.value,
                        0),
                    child: GestureDetector(
                      onTap: () async {
                        controller.reverse();
                        Get.to(
                          () => AddNewClient(),
                          duration: const Duration(milliseconds: 600),
                          transition:
                              Platform.isIOS ? null : Transition.downToUp,
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
                  );
                },
              ),
            ),
            Positioned(
              bottom: 25.0,
              child: AnimatedBuilder(
                animation: controller.rightButtonController,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.translationValues(
                        _rightButtonXAnimation.value,
                        _rightButtonYAnimation.value,
                        0),
                    child: GestureDetector(
                      onTap: () {
                        controller.reverse();
                        Get.to(
                          () => SelectClientScreen(),
                          duration: const Duration(milliseconds: 600),
                          transition:
                              Platform.isIOS ? null : Transition.downToUp,
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
                        child: SvgPicture.asset(AppAssets.CALANDER_ICON_BUTTON),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 25.0,
              child: GestureDetector(
                onTap: () {
                  if (controller.client.value.isAdmin == null) {}
                  if (controller.client.value.isAdmin!) {
                    if (controller.toggle.value == false) {
                      controller.forward();
                    } else {
                      controller.reverse();
                    }
                  } else {
                    Get.to(
                      () => const ServicesScreen(),
                      duration: const Duration(milliseconds: 600),
                      // transition: Platform.isIOS ? null : Transition.downToUp,
                      fullscreenDialog: true,
                      preventDuplicates: true,
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
