import 'dart:developer';

import 'package:atherium_saloon_app/screens/appointment_booking_screen/appointment_booking_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/appointments_card_widget.dart';
import 'package:atherium_saloon_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';

class AppointmentBookingScreen extends StatelessWidget {
  final controller = Get.put(AppointMentBookingController());
  AppointmentBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text(AppLanguages.CHOOSE_DATE_ADN_TIME,
                        style: Theme.of(context).textTheme.headlineLarge),
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
                        InkWell(
                          onTap: controller.prevMonth,
                          child: SvgPicture.asset(AppAssets.BACK_ARROW),
                        ),
                        const SizedBox(width: 20.0),
                        Obx(
                          () => Text(
                            controller.currentMonth.value,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        InkWell(
                          onTap: controller.nextMonth,
                          child: SvgPicture.asset(
                            AppAssets.RIGHT_ARROW,
                            colorFilter: const ColorFilter.mode(
                                AppColors.GREY_COLOR, BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.resetDate();
                      },
                      child: SvgPicture.asset(
                        AppAssets.CALANDER_ICON,
                        colorFilter: ColorFilter.mode(
                            isDark
                                ? AppColors.GREY_COLOR
                                : AppColors.PRIMARY_COLOR,
                            BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 17.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: GetBuilder<AppointMentBookingController>(
                  builder: (_) {
                    return HorizontalCalendar(
                      date: controller.date.value,
                      initialDate: DateTime.now(),
                      selectedColor: isDark
                          ? AppColors.SECONDARY_LIGHT
                          : AppColors.SECONDARY_COLOR,
                      backgroundColor: !isDark
                          ? AppColors.WHITE_COLOR
                          : AppColors.BACKGROUND_DARK,
                      textColor: isDark
                          ? AppColors.WHITE_COLOR
                          : AppColors.BLACK_COLOR,
                      onDateSelected: (date) {
                        () => controller.changeDate(date);

                        log(date);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 35.0),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 22.0),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.PRIMARY_DARK : AppColors.CARD_COLOR,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Text(
                        AppLanguages.AVAILABLE_SLOT,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: .75,
                            ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                mainAxisExtent: 37.0,
                                maxCrossAxisExtent: 110.0,
                                crossAxisSpacing: 12.0,
                                mainAxisSpacing: 7.0),
                        itemCount: avaliableSlots.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => InkWell(
                              onTap: () => controller.selectedSlot(index),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: controller.selectedSlot == index
                                      ? AppColors.SECONDARY_LIGHT
                                      : isDark
                                          ? AppColors.BACKGROUND_DARK
                                          : AppColors.BACKGROUND_COLOR,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: controller.selectedSlot != index
                                      ? isDark
                                          ? Border()
                                          : Border.all(
                                              color: AppColors.SECONDARY_LIGHT,
                                            )
                                      : Border(),
                                ),
                                child: Text(
                                  avaliableSlots[index],
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: controller.selectedSlot == index
                                          ? isDark
                                              ? AppColors.BACKGROUND_DARK
                                              : AppColors.BLACK_COLOR
                                          : isDark
                                              ? AppColors.WHITE_COLOR
                                              : AppColors.BLACK_COLOR),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 41.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Text(
                  AppLanguages.ADDED_APPOINTMENT,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .75,
                      ),
                ),
              ),
              const SizedBox(height: 20.0),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (contenxt, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: AppointmentsCardWidget(
                      imageUrl: AppAssets.EVENT_IMAGE_ONE,
                      title: 'Ruth',
                      subTitle: 'Fragrances & Perfumes',
                      color: AppColors.BLACK_COLOR,
                      date: '22 June',
                      time: '8:30 AM',
                      timeContainerHeight: 40.0,
                      timeContainerRadius: 20.0,
                      timeContainerHorizontalPadding: 15.0,
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 13.0),
                child: ButtonWidget(
                  width: Get.width,
                  color: isDark
                      ? AppColors.SECONDARY_LIGHT
                      : AppColors.PRIMARY_COLOR,
                  buttonTextColor:
                      !isDark ? AppColors.WHITE_COLOR : AppColors.BLACK_COLOR,
                  buttonText: AppLanguages.CONFIRM_APPOINTMENT,
                  onTap: controller.confirmAppointment,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
