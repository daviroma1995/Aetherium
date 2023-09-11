// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/screens/agenda_screen/agenda_controller.dart';
import 'package:atherium_saloon_app/screens/appointment_details/appointment_details.dart';
import 'package:atherium_saloon_app/widgets/clean_calendar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/custom_title_row_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

// ignore: must_be_immutable
class AgendaScreen extends StatelessWidget {
  DateTime selectedDay = DateTime.now();
  AgendaScreen({super.key});
  final controller = Get.put(AgendaController());
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Obx(() => Visibility(
                  visible: controller.reload.value,
                  replacement: Obx(
                    () => Calendar(
                      events: controller.events,
                      hideArrows: true,
                      hideTodayIcon: true,
                      initialDate: controller.selectedDate.value,
                      onDateSelected: (value) {
                        controller.selectedDate.value = value;
                        controller.onDateChange(value);
                      },
                    ),
                  ),
                  child: Obx(
                    () => Calendar(
                      events: controller.events,
                      hideArrows: true,
                      hideTodayIcon: true,
                      initialDate: controller.selectedDate.value,
                      onDateSelected: (value) {
                        controller.selectedDate.value = value;
                        controller.onDateChange(value);
                      },
                    ),
                  ),
                )),
          ),
          const SizedBox(height: 13.0),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                width: Get.width,
                height: null,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.PRIMARY_DARK : AppColors.WHITE_COLOR,
                  border: isDark ? const Border() : Border.all(width: 1.0, color: AppColors.BORDER_COLOR),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: LiquidPullToRefresh(
                  backgroundColor: isDark ? AppColors.SECONDARY_LIGHT : AppColors.WHITE_COLOR,
                  onRefresh: () async => await controller.loadData(),
                  child: ListView(
                    shrinkWrap: true,
                    // physics: const BouncingScrollPhysics(),
                    children: [
                      Obx(
                        () => CustomTitle(
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                          title: controller.day.value,
                          subTitle: controller.date.value,
                          isUnderLined: false,
                          subtitleColor: isDark ? AppColors.GREY_COLOR : AppColors.BLACK_COLOR,
                        ),
                      ),
                      const SizedBox(height: 17.0),
                      Obx(
                        () => controller.appointments.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.appointments.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 23.0, bottom: 10.0),
                                    child: GestureDetector(
                                      onTap: () => Get.to(
                                        AppointmentDetailsScreen(appointment: controller.appointments[index], isDetail: true),
                                        duration: const Duration(
                                          milliseconds: 600,
                                        ),
                                        transition: Transition.downToUp,
                                      ),
                                      child: AgendaCustomCardWidget(
                                        startTime: controller.getTime(controller.appointments[index].time!),
                                        endTime: controller.getEndTime(
                                          controller.appointments[index].time!,
                                          controller.appointments[index].duration!,
                                        ),
                                        duration: '${controller.appointments[index].duration.toString()} Min',
                                        // duration: controller.getDuration(
                                        //     controller
                                        //         .appointments[index].serviceId!,
                                        //     controller
                                        //         .appointments[index].time!)[0],
                                        userImageUrl: AppAssets.CALANDER_ICON,
                                        userName: controller.currentUser.value.isAdmin ?? false
                                            ? '${controller.listofClients[index].firstName.toString().capitalize} - ${controller.listofClients[index].lastName.toString().capitalize}'
                                            : controller.employees[index].name!,
                                        service:
                                            '${controller.appointmentsTreatmentCategoryList.isNotEmpty ? controller.appointmentsTreatmentCategoryList[index].name : ''} - ${controller.treatmentsData.isNotEmpty ? controller.treatmentsData[index].name ?? '' : ''}',
                                        agendaColor: AppColors.SECONDARY_LIGHT,
                                        agendaBarsColor: AppColors.SECONDARY_LIGHT,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : SizedBox(
                                width: Get.width,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: Get.height * .05),
                                      SvgPicture.asset(AppAssets.CALENDER_ICON_LIGHT),
                                      const SizedBox(height: 35.0),
                                      Text(
                                        'no_appointments',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: isDark ? AppColors.WHITE_COLOR : AppColors.BLACK_COLOR,
                                        ),
                                      ).tr(),
                                      const SizedBox(height: 10.0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 22.0),
                                        child: const Text(
                                          'empty_agenda_message',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0,
                                            color: AppColors.GREY_COLOR,
                                          ),
                                        ).tr(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class AgendaCustomCardWidget extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String duration;
  final String userImageUrl;
  final String userName;
  final String service;
  final Color agendaColor;
  final Color agendaBarsColor;
  const AgendaCustomCardWidget({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.userImageUrl,
    required this.userName,
    required this.service,
    required this.agendaColor,
    required this.agendaBarsColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Container(
          width: 3.0,
          height: 82.0,
          color: agendaBarsColor,
        ),
        const SizedBox(width: 16.0),
        SizedBox(
          width: 75.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.CLOCK_ICON,
                    colorFilter: ColorFilter.mode(isDark ? AppColors.WHITE_COLOR : AppColors.PRIMARY_COLOR, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 5.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        startTime,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        endTime,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 7.0),
              Row(
                children: [
                  Container(
                    height: 8.0,
                    width: 8.0,
                    decoration: BoxDecoration(
                      color: agendaBarsColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: Text(
                      duration,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 17.0),
        Expanded(
          child: Container(
            height: 82.0,
            decoration: BoxDecoration(
                color: agendaColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
              child: Row(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: isDark ? AppColors.PRIMARY_DARK : AppColors.PRIMARY_COLOR),
                    child: SvgPicture.asset(
                      userImageUrl,
                      height: 28,
                      colorFilter: const ColorFilter.mode(AppColors.WHITE_COLOR, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: isDark ? AppColors.BLACK_COLOR : AppColors.PRIMARY_COLOR,
                          ),
                        ),
                        Text(
                          service,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                            color: isDark ? AppColors.SECONDARY_COLOR : AppColors.PRIMARY_COLOR,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
