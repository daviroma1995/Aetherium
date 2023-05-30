// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/models/timeslot.dart';
import 'package:atherium_saloon_app/widgets/form_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/screens/appointment_booking_screen/appointment_booking_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/button_widget.dart';
import 'package:intl/intl.dart';

import '../../widgets/clean_calendar.dart';
import '../../widgets/drop_down_item_widget.dart';

class AppointmentBookingScreen extends StatelessWidget {
  final controller = Get.put(AppointMentBookingController());
  AppointmentBookingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Calendar(
                          events: {},
                          hideTodayIcon: true,
                          // startOnMonday: true,
                          initialDate: controller.args.dateTimestamp != null
                              ? controller.args.dateTimestamp.toDate()
                              : DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0),
                          onDateSelected: (value) async {
                            controller.args.dateTimestamp = Timestamp.fromDate(
                                DateTime(value.year, value.month, value.day, 0,
                                    0, 0, 0, 0));
                            controller.selectedDate.value =
                                DateFormat("MM/dd/yyyy").format(DateTime(
                                    value.year,
                                    value.month,
                                    value.day,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0));

                            controller.args.date =
                                controller.selectedDate.value;
                            await controller.loadTimeslots(
                                treatments: controller.selectedTreatmentsMap,
                                appointmentDate: controller.selectedDate.value);
                            print(value);
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              child: Obx(
                                () => controller.isLoading.value == true
                                    ? SizedBox(
                                        width: Get.width,
                                        child: const Center(
                                            child: CircularProgressIndicator()))
                                    : GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                mainAxisExtent: 37.0,
                                                maxCrossAxisExtent: 110.0,
                                                crossAxisSpacing: 12.0,
                                                mainAxisSpacing: 7.0),
                                        itemCount:
                                            controller.avaliableSlots.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Obx(
                                            () => InkWell(
                                              onTap: () {
                                                controller.selectSlot(index);
                                                var startTime = controller
                                                    .slotdata[index].startTime;
                                                var endTime = controller
                                                    .slotdata[index].endTime;
                                                var roomIdList = controller
                                                    .slotdata[index].roomIdList;
                                                controller.args.roomId =
                                                    roomIdList;
                                                controller.args.startTime =
                                                    startTime;
                                                controller.args.endTime =
                                                    endTime;
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: controller
                                                              .selectedSlot ==
                                                          index
                                                      ? AppColors
                                                          .SECONDARY_LIGHT
                                                      : isDark
                                                          ? AppColors
                                                              .BACKGROUND_DARK
                                                          : AppColors
                                                              .BACKGROUND_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border:
                                                      controller.selectedSlot !=
                                                              index
                                                          ? isDark
                                                              ? const Border()
                                                              : Border.all(
                                                                  color: AppColors
                                                                      .SECONDARY_LIGHT,
                                                                )
                                                          : Border(),
                                                ),
                                                child: Text(
                                                  controller
                                                      .avaliableSlots[index],
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: controller
                                                                .selectedSlot ==
                                                            index
                                                        ? isDark
                                                            ? AppColors
                                                                .BACKGROUND_DARK
                                                            : AppColors
                                                                .BLACK_COLOR
                                                        : isDark
                                                            ? AppColors
                                                                .WHITE_COLOR
                                                            : AppColors
                                                                .BLACK_COLOR,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.isAdmin.value,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Note',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? AppColors.WHITE_COLOR
                                            : AppColors.SECONDARY_COLOR,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14.0),
                                CustomInputFormField(
                                  hintText:
                                      controller.args.notes ?? 'Some Notes',
                                  isValid: true,
                                  onSubmit: () {},
                                  textEdigintController: controller.notes,
                                  paddingSymetric: 16.0,
                                  paddingVertical: 16.0,
                                  autoFocus: false,
                                  maxLines: 15,
                                  minLInes: 8,
                                  onchange: (value) {
                                    controller.args.notes = value;
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Obx(
                        () => Visibility(
                          visible: controller.isAdmin.value,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: DropDownItemsWidget(
                              options: ['Confermato'],
                              onTap: (selected) {},
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
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
                      Obx(
                        () => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.employees.isEmpty
                              ? 1
                              : controller.employees.length,
                          itemBuilder: (contenxt, index) {
                            if (controller.employees.isEmpty) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0),
                                    child: specialistCard(
                                        title:
                                            controller.employees[index].name!,
                                        subtitle: 'Fragrances & Perfumes',
                                        imageUrl: AppAssets.USER_IMAGE,
                                        isDark: isDark),
                                  ),
                                  const SizedBox(height: 10.0),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
                  buttonText: 'Next',
                  onTap: controller.next,
                ),
              ),
            ],
          ),
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
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.GREY_COLOR : AppColors.BLACK_COLOR,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
