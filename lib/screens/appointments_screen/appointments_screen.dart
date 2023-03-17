// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColors.BACKGROUND_COLOR,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 22.0, top: 10.0, right: 22.0),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () => Get.back(),
                          child: SvgPicture.asset(AppAssets.BACK_ARROW)),
                      const SizedBox(width: 12.0),
                      const Text(
                        AppLanguages.APPOINTMENTS,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: AppColors.BLACK_COLOR,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .75,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                                color: AppColors.WHITE_COLOR,
                                border: Border(
                                    bottom: BorderSide(
                                        color: controller.isCurrentPast.value
                                            ? AppColors.BLACK_COLOR
                                            : AppColors.GREY_COLOR))),
                            child: Text(
                              'Past',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: controller.isCurrentPast.value
                                      ? FontWeight.w800
                                      : FontWeight.w500,
                                  color: controller.isCurrentPast.value
                                      ? AppColors.PRIMARY_COLOR
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
                                color: AppColors.WHITE_COLOR,
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            controller.isCurrentUpcomming.value
                                                ? AppColors.BLACK_COLOR
                                                : AppColors.GREY_COLOR))),
                            child: Text(
                              'Upcoming',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight:
                                      controller.isCurrentUpcomming.value
                                          ? FontWeight.w800
                                          : FontWeight.w500,
                                  color: controller.isCurrentUpcomming.value
                                      ? AppColors.PRIMARY_COLOR
                                      : AppColors.GREY_COLOR,
                                  letterSpacing: .75),
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
    );
  }
}
