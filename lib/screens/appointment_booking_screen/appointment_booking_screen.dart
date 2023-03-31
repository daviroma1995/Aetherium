import 'dart:developer';

import 'package:atherium_saloon_app/screens/appointment_booking_screen/appointment_booking_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:
            isDark ? AppColors.BACKGROUND_DARK : AppColors.BACKGROUND_COLOR,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(25.0),
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                width: 25.0,
                height: 25.0,
                child: SvgPicture.asset(AppAssets.BACK_ARROW,
                    height: 14.0, width: 14.0),
              ),
            ),
            const SizedBox(width: 12.0),
            Text(AppLanguages.CHOOSE_DATE_AND_TIME,
                style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
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
                        color: isDark
                            ? AppColors.PRIMARY_DARK
                            : AppColors.CARD_COLOR,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: controller.selectedSlot != index
                                            ? isDark
                                                ? Border()
                                                : Border.all(
                                                    color: AppColors
                                                        .SECONDARY_LIGHT,
                                                  )
                                            : Border(),
                                      ),
                                      child: Text(
                                        avaliableSlots[index],
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: controller.selectedSlot ==
                                                    index
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: Text(
                            AppLanguages.BEAUTY_SPECIALIST,
                            textAlign: TextAlign.start,
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
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (contenxt, index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
                              child: specialistCard(
                                  title: 'Ruth Okazaki',
                                  subtitle: 'Fragrances & Perfumes',
                                  imageUrl: AppAssets.USER_IMAGE,
                                  isDark: isDark),
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
              child: ButtonWidget(
                width: Get.width,
                color: isDark
                    ? AppColors.SECONDARY_LIGHT
                    : AppColors.PRIMARY_COLOR,
                buttonTextColor:
                    !isDark ? AppColors.WHITE_COLOR : AppColors.BLACK_COLOR,
                buttonText: 'Next',
                onTap: controller.next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container specialistCard({
  required String title,
  required String subtitle,
  required String imageUrl,
  required bool isDark,
}) {
  return Container(
    height: 82.0,
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
    decoration: BoxDecoration(
      color: isDark ? AppColors.PRIMARY_DARK : AppColors.BACKGROUND_COLOR,
      border: isDark
          ? const Border()
          : Border.all(
              width: 1.0,
              color: AppColors.BORDER_COLOR,
            ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1.3, color: AppColors.BORDER_COLOR),
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: CircleAvatar(
              radius: 25.0,
              backgroundImage: AssetImage(imageUrl),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.WHITE_COLOR : AppColors.BLACK_COLOR,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppColors.GREY_COLOR,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
