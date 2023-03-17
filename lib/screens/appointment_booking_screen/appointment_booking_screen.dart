import 'dart:developer';

import 'package:atherium_saloon_app/screens/appointment_booking_screen/appointment_booking_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';

class AppointmentBookingScreen extends StatelessWidget {
  final controller = Get.put(AppointMentBookingController());
  AppointmentBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 22.0, right: 22.0, top: 10.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: SvgPicture.asset(AppAssets.BACK_ARROW),
                  ),
                  const SizedBox(width: 15.0),
                  const Text(
                    AppLanguages.CHOOSE_DATE_ADN_TIME,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.BACK_ARROW),
                      const SizedBox(width: 20.0),
                      const Text('March'),
                      const SizedBox(width: 20.0),
                      SvgPicture.asset(
                        AppAssets.RIGHT_ARROW,
                        colorFilter: ColorFilter.mode(
                            AppColors.GREY_COLOR, BlendMode.srcIn),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.resetDate();
                    },
                    child: SvgPicture.asset(AppAssets.CALANDER_ICON),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 17.0),
            GetBuilder<AppointMentBookingController>(builder: (_) {
              return HorizontalCalendar(
                date: controller.date.value,
                initialDate: DateTime.now(),
                selectedColor: AppColors.SECONDARY_COLOR,
                onDateSelected: (date) {
                  () => controller.changeDate(date);

                  log(date);
                },
              );
            })
          ],
        ),
      )),
    );
  }
}
