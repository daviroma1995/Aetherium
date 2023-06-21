// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_screen.dart';

import '../../models/appointment.dart';
import '../../utils/constants.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_row_widget.dart';
import '../home_screen/home_screen_controller.dart';
import 'appointment_details_controller.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final controller = Get.put(AppointmentDetailsController());
  final HomeScreenController homecontroller = Get.find();
  AppointmentDetailsScreen({
    Key? key,
    this.isDetail = false,
    this.isEditable = false,
    required this.appointment,
  }) : super(key: key);
  final bool? isDetail;
  final bool? isEditable;
  final Appointment appointment;
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: controller.isChanged);
        return controller.isChanged;
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
                onTap: isDetail! == false
                    ? () {
                        Get.back(result: controller.isChanged);
                      }
                    : () => Get.back(),
                child: Container(
                  alignment: Alignment.center,
                  width: 25.0,
                  height: 25.0,
                  child: SvgPicture.asset(AppAssets.BACK_ARROW,
                      height: 14.0, width: 14.0),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  AppLanguages.AppuntamentoDettagli,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: Get.width * .055),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 18.0),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.PRIMARY_DARK
                            : AppColors.WHITE_COLOR,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        border: isDark
                            ? const Border()
                            : Border.all(color: AppColors.BORDER_COLOR)),
                    child: Padding(
                      padding: const EdgeInsets.all(27.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextRowWidget(
                                    textOne: 'Date: ',
                                    textTwo: 'Time: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.0,
                                            color: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.SECONDARY_COLOR),
                                  ),
                                  const SizedBox(height: 10.0),
                                  TextRowWidget(
                                    textOne: appointment.dateString,
                                    textTwo: appointment.time ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      color: isDark
                                          ? AppColors.GREY_COLOR
                                          : AppColors.BLACK_COLOR,
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextRowWidget(
                                    textOne: 'Number',
                                    textTwo: 'Email',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.0,
                                            color: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.SECONDARY_COLOR),
                                  ),
                                  const SizedBox(height: 10.0),
                                  TextRowWidget(
                                    textOne: appointment.number!,
                                    textTwo: appointment.email!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      color: isDark
                                          ? AppColors.GREY_COLOR
                                          : AppColors.BLACK_COLOR,
                                    ),
                                  ),
                                  const SizedBox(height: 26.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Services Details',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.0,
                                                color: isDark
                                                    ? AppColors.WHITE_COLOR
                                                    : AppColors
                                                        .SECONDARY_COLOR),
                                      ),
                                      const SizedBox(height: 10.0),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            appointment.serviceId!.length,
                                        itemBuilder: (context, index) {
                                          return Obx(
                                            () => controller
                                                    .allTreatments.isEmpty
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              '${controller.getName(appointment.serviceId![index])} - ${controller.getTime(appointment.serviceId![index])} Min',
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: isDark
                                                                    ? AppColors
                                                                        .GREY_COLOR
                                                                    : AppColors
                                                                        .BLACK_COLOR,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            '${controller.getPrice(appointment.serviceId![index])} \$',
                                                            style: TextStyle(
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: isDark
                                                                  ? AppColors
                                                                      .GREY_COLOR
                                                                  : AppColors
                                                                      .BLACK_COLOR,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10.0),
                                                    ],
                                                  ),
                                          );
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Total',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          GetBuilder<
                                              AppointmentDetailsController>(
                                            builder: (controller) {
                                              return Text(
                                                '${controller.totalPrice(appointment.serviceId!)} \$',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                  Text(
                                    'Beauty Specialist:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.0,
                                            color: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.SECONDARY_COLOR),
                                  ),
                                  const SizedBox(height: 20.0),
                                  ListView.builder(
                                      itemCount: appointment.employeeId!.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return specialistCard(
                                          title: homecontroller.getEmployeeName(
                                              appointment.employeeId![index]),
                                          imageUrl: AppAssets.USER_IMAGE,
                                          subtitle: 'Fragrances & Perfumes',
                                          isDark: isDark,
                                        );
                                      }),
                                  const SizedBox(height: 20.0),
                                  Text(
                                    AppLanguages.NOTES,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.0,
                                            color: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.SECONDARY_COLOR),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Text(
                                    appointment.notes ?? 'No Notes avaialbe',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      color: isDark
                                          ? AppColors.GREY_COLOR
                                          : AppColors.BLACK_COLOR,
                                    ),
                                  ),
                                  const SizedBox(height: 33.0),
                                ],
                              ),
                            ),
                          ),
                          if (isEditable == true)
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonWidget(
                                    width: Get.width / 2 - 32,
                                    buttonText: 'Cancel',
                                    buttonTextColor: isDark
                                        ? AppColors.SECONDARY_LIGHT
                                        : AppColors.BLACK_COLOR,
                                    borderColor: isDark
                                        ? AppColors.SECONDARY_LIGHT
                                        : AppColors.BLACK_COLOR,
                                    bordered: true,
                                    onTap: () {
                                      Get.offAll(
                                        const BottomNavigationScreen(),
                                        duration:
                                            const Duration(milliseconds: 600),
                                        transition: Transition.leftToRight,
                                        curve: Curves.linear,
                                      );
                                    },
                                  ),
                                  ButtonWidget(
                                    width: Get.width / 2 - 32,
                                    buttonText: 'Edit',
                                    buttonTextColor: isDark
                                        ? AppColors.BACKGROUND_DARK
                                        : AppColors.WHITE_COLOR,
                                    color: isDark
                                        ? AppColors.SECONDARY_LIGHT
                                        : AppColors.PRIMARY_COLOR,
                                    bordered: false,
                                    onTap: () {
                                      controller.onEdit(appointment);
                                    },
                                  )
                                ],
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
    margin: const EdgeInsets.only(bottom: 5.0),
    decoration: BoxDecoration(
      color: isDark ? AppColors.BACKGROUND_DARK : AppColors.BACKGROUND_COLOR,
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
