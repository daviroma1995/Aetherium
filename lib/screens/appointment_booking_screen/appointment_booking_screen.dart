// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/models/appointment.dart';
import 'package:atherium_saloon_app/models/employee.dart';
import 'package:atherium_saloon_app/models/timeslot.dart';
import 'package:atherium_saloon_app/screens/appointment_booking_screen/appointment_booking_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/form_field_widget.dart';
import 'package:atherium_saloon_app/widgets/primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../widgets/clean_calendar.dart';
import '../../widgets/drop_down_item_widget.dart';

class AppointmentBookingScreen extends StatelessWidget {
  const AppointmentBookingScreen({
    this.isEditing = false,
    this.date = '',
    this.time = '',
    this.appointment,
    Key? key,
  }) : super(key: key);
  final bool isEditing;
  final String date;
  final String time;
  final Appointment? appointment;
  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(AppointMentBookingController(isEditing: isEditing));
    final previousStatusId = appointment!.statusId;
    controller.isEditing = isEditing;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    controller.dateString = date;
    controller.timeString = time;
    controller.appointment = appointment ?? Appointment();

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
                borderRadius: BorderRadius.circular(40.0),
                onTap: controller.back,
                child: Container(
                  alignment: Alignment.center,
                  width: 40.0,
                  height: 40.0,
                  child: SvgPicture.asset(AppAssets.BACK_ARROW,
                      height: 14.0, width: 14.0),
                ),
              ),
              const SizedBox(width: 12.0),
              Text('choose_date_and_time',
                      style: Theme.of(context).textTheme.headlineLarge)
                  .tr(),
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
                        child: Obx(() => controller.calenderState.value
                            ? Calendar(
                                events: const {},
                                hideTodayIcon: true,
                                initialDate: controller.initialDate.value,
                                // controller.args.dateTimestamp != null
                                //     ? controller.args.dateTimestamp.toDate()
                                //     : controller.initialDate.value,
                                onDateSelected: (value) async {
                                  print(controller.openingTime);
                                  controller.selectedDateTime = value;
                                  controller.args.dateTimestamp =
                                      Timestamp.fromDate(DateTime(
                                              value.year,
                                              value.month,
                                              value.day,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0)
                                          .toLocal());
                                  controller.selectedDate.value =
                                      DateFormat("MM/dd/yyyy").format(
                                    DateTime(value.year, value.month, value.day,
                                            0, 0, 0, 0, 0)
                                        .toLocal(),
                                  );
                                  print(controller.args.dateTimestamp.toDate());
                                  controller.initialDate.value = value;
                                  controller.calenderState.value =
                                      !controller.calenderState.value;
                                  controller.args.date =
                                      controller.selectedDate.value;
                                  bool isPastDay = (value.day <
                                              DateTime.now().day ||
                                          value.month < DateTime.now().month ||
                                          value.year < DateTime.now().year) &&
                                      value.month <= DateTime.now().month;
                                  await controller.loadTimeslots(
                                      treatments:
                                          controller.selectedTreatmentsMap,
                                      appointmentDate:
                                          controller.selectedDate.value);
                                  if (isPastDay) {
                                    Fluttertoast.showToast(
                                        msg: tr('appointment_past'));
                                    controller.slotdata = <Timeslot>[];
                                    controller.avaliableSlots.value =
                                        <String>[];
                                    controller.filteredEmployees.value =
                                        <Employee>[];
                                    return;
                                  }
                                  if (value.weekday == 7) {
                                    Fluttertoast.showToast(msg: '');
                                    return;
                                  }
                                },
                              )
                            : Calendar(
                                // ignore: prefer_const_literals_to_create_immutables
                                events: const {},
                                hideTodayIcon: true,
                                initialDate: controller.initialDate.value,
                                // controller.args.dateTimestamp != null
                                //     ? controller.args.dateTimestamp.toDate()
                                //     : controller.initialDate.value,
                                onDateSelected: (value) async {
                                  controller.selectedDateTime = value;
                                  controller.args.dateTimestamp =
                                      Timestamp.fromDate(DateTime(
                                              value.year,
                                              value.month,
                                              value.day,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0)
                                          .toLocal());
                                  controller.selectedDate.value =
                                      DateFormat("MM/dd/yyyy").format(
                                    DateTime(value.year, value.month, value.day,
                                            0, 0, 0, 0, 0)
                                        .toLocal(),
                                  );
                                  print(controller.args.dateTimestamp.toDate());

                                  controller.initialDate.value = value;
                                  controller.calenderState.value =
                                      !controller.calenderState.value;
                                  controller.args.date =
                                      controller.selectedDate.value;
                                  bool isPastDay = (value.day <
                                              DateTime.now().day ||
                                          value.month < DateTime.now().month ||
                                          value.year < DateTime.now().year) &&
                                      value.month <= DateTime.now().month;

                                  await controller.loadTimeslots(
                                      treatments:
                                          controller.selectedTreatmentsMap,
                                      appointmentDate:
                                          controller.selectedDate.value);
                                  if (isPastDay) {
                                    Fluttertoast.showToast(
                                        msg: tr('appointment_past'));
                                    controller.slotdata = <Timeslot>[];
                                    controller.avaliableSlots.value =
                                        <String>[];
                                    controller.filteredEmployees.value =
                                        <Employee>[];
                                    return;
                                  }
                                  if (value.weekday == 7) {
                                    Fluttertoast.showToast(msg: '');
                                    return;
                                  }
                                },
                              )),
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
                                'available_slot',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: .75,
                                    ),
                              ).tr(),
                            ),
                            const SizedBox(height: 15.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
                              child: Obx(
                                () => controller.isLoading.value == true
                                    ? SizedBox(
                                        width: Get.width,
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          color: isDark
                                              ? AppColors.SECONDARY_COLOR
                                              : AppColors.GREY_COLOR,
                                        )))
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
                                                  // ignore: unrelated_type_equality_checks
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
                                                      // ignore: unrelated_type_equality_checks
                                                      controller.selectedSlot !=
                                                              index
                                                          ? isDark
                                                              ? const Border()
                                                              : Border.all(
                                                                  color: AppColors
                                                                      .SECONDARY_LIGHT,
                                                                )
                                                          : const Border(),
                                                ),
                                                child: Text(
                                                  controller
                                                      .avaliableSlots[index],
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                    // ignore: unrelated_type_equality_checks
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
                                const SizedBox(height: 14.0),
                                Row(
                                  children: [
                                    Text(
                                      'note',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? AppColors.WHITE_COLOR
                                            : AppColors.SECONDARY_COLOR,
                                      ),
                                      textAlign: TextAlign.left,
                                    ).tr(),
                                  ],
                                ),
                                const SizedBox(height: 14.0),
                                CustomInputFormField(
                                  hintText: controller.args.notes == null ||
                                          controller.args.notes == ''
                                      ? tr('some_notes')
                                      : controller.args.notes,
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
                        () => controller.statusLabels.isNotEmpty &&
                                controller.isAdmin.value &&
                                controller.appointmentStatusList.isNotEmpty &&
                                isEditing
                            ? Visibility(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: DropDownItemsWidget(
                                    // ignore: invalid_use_of_protected_member
                                    options: controller.statusLabels.value,
                                    selected: controller.getStatusLabel(),
                                    onTap: (selected) {
                                      var previousStatus = controller
                                          .appointmentStatusList
                                          .firstWhere((element) =>
                                              element.id == previousStatusId);
                                      controller.previousStatus =
                                          previousStatus.label ?? '';
                                      print(previousStatus.label);
                                      int id = controller.appointmentStatusList
                                          .indexWhere((status) =>
                                              status.label!.toLowerCase() ==
                                              selected!.toLowerCase());
                                      controller.args.statusId = controller
                                          .appointmentStatusList[id].id;
                                      controller.selectedStatus =
                                          selected ?? '';
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
                            child: Text(
                              'beauty_specialist',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: .75,
                                  ),
                            ).tr(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Obx(
                        () => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.filteredEmployees.isEmpty
                              ? 1
                              : controller.filteredEmployees.length,
                          itemBuilder: (contenxt, index) {
                            if (controller.filteredEmployees.isEmpty ||
                                controller.employeesLoaded.value == false) {
                              return Center(
                                child: Container(),
                              );
                            } else {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0),
                                    child: specialistCard(
                                        title: controller
                                            .filteredEmployees[index].name!,
                                        subtitle: tr('fragrances_and_perfumes'),
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 13.0),
                    child: PrimaryButton(
                      width: Get.width / 2 - 40,
                      bordered: true,
                      borderColor: isDark
                          ? AppColors.SECONDARY_LIGHT
                          : AppColors.PRIMARY_COLOR,
                      buttonTextColor: isDark
                          ? AppColors.WHITE_COLOR
                          : AppColors.PRIMARY_COLOR,
                      buttonText: 'cancel',
                      onTap: () {
                        Get.back();
                        Get.back(result: true);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 13.0),
                    child: PrimaryButton(
                      width: Get.width / 2 - 40,
                      color: isDark
                          ? AppColors.SECONDARY_LIGHT
                          : AppColors.PRIMARY_COLOR,
                      buttonTextColor: !isDark
                          ? AppColors.WHITE_COLOR
                          : AppColors.BLACK_COLOR,
                      buttonText: 'next',
                      onTap: controller.next,
                    ),
                  ),
                ],
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
