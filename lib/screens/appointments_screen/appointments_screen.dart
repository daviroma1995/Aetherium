// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/screens/appointments_screen/appointments_controller.dart';

import '../../utils/constants.dart';

class AppointmentsScreen extends StatelessWidget {
  final controller = Get.put(AppointmentsController());
  AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(Get.previousRoute);
    print(Get.currentRoute);
    print(Get.defaultOpaqueRoute);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: isDark
                    ? AppColors.BACKGROUND_DARK
                    : AppColors.BACKGROUND_COLOR,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 22.0, top: 10.0, right: 22.0),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () => controller.handleBack(),
                          child: SvgPicture.asset(AppAssets.BACK_ARROW)),
                      const SizedBox(width: 12.0),
                      Text(AppLanguages.APPOINTMENTS,
                          style: Theme.of(context).textTheme.headlineLarge),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Expanded(
                        child: InkWell(
                          onTap: () => controller.onTap(0),
                          child: Container(
                            height: 50.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.isCurrentPast.value
                                  ? isDark
                                      ? AppColors.PRIMARY_DARK
                                      : AppColors.WHITE_COLOR
                                  : isDark
                                      ? AppColors.BACKGROUND_DARK
                                      : AppColors.WHITE_COLOR,
                              border: Border(
                                bottom: BorderSide(
                                    color: controller.isCurrentPast.value
                                        ? isDark
                                            ? AppColors.PRIMARY_DARK
                                            : AppColors.BLACK_COLOR
                                        : isDark
                                            ? AppColors.PRIMARY_DARK
                                            : AppColors.GREY_COLOR),
                              ),
                            ),
                            child: Text(
                              'Past',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: controller.isCurrentPast.value
                                      ? FontWeight.w800
                                      : FontWeight.w500,
                                  color: controller.isCurrentPast.value
                                      ? !isDark
                                          ? AppColors.PRIMARY_COLOR
                                          : AppColors.GREY_COLOR
                                      : AppColors.GREY_COLOR,
                                  letterSpacing: .75),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Expanded(
                        child: InkWell(
                          onTap: () => controller.onTap(1),
                          child: Container(
                            height: 50.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.isCurrentUpcomming.value
                                  ? isDark
                                      ? AppColors.PRIMARY_DARK
                                      : AppColors.WHITE_COLOR
                                  : isDark
                                      ? AppColors.BACKGROUND_DARK
                                      : AppColors.WHITE_COLOR,
                              border: Border(
                                bottom: BorderSide(
                                    color: controller.isCurrentUpcomming.value
                                        ? isDark
                                            ? AppColors.PRIMARY_DARK
                                            : AppColors.BLACK_COLOR
                                        : isDark
                                            ? AppColors.PRIMARY_DARK
                                            : AppColors.GREY_COLOR),
                              ),
                            ),
                            child: Text(
                              'Upcoming',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: controller.isCurrentUpcomming.value
                                    ? FontWeight.w800
                                    : FontWeight.w500,
                                color: controller.isCurrentUpcomming.value
                                    ? !isDark
                                        ? AppColors.PRIMARY_COLOR
                                        : AppColors.GREY_COLOR
                                    : AppColors.GREY_COLOR,
                                letterSpacing: .75,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: Get.height - 150,
                child: Obx(
                  () => IndexedStack(
                    children: [
                      controller.screens[controller.currentIndex.value],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          controller.createAppointment();
        },
        child: Container(
          alignment: Alignment.center,
          height: 66,
          width: 66,
          decoration: BoxDecoration(
            color:
                isDark ? AppColors.BACKGROUND_DARK : AppColors.SECONDARY_COLOR,
            border: Border.all(width: 6.0, color: AppColors.BORDER_COLOR),
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: const Icon(
            Icons.add,
            color: AppColors.WHITE_COLOR,
          ),
        ),
      ),
    );
  }
}
