// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/screens/appointment_confirm_detail_screen/appointment_confirm_detail_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../models/treatment.dart';
import '../../utils/constants.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/text_row_widget.dart';
import '../home_screen/home_screen_controller.dart';

class AppointmentConfirmDetailScreen extends StatelessWidget {
  final controller = Get.put(AppointmentConfirmDetailController());
  final HomeScreenController homecontroller = Get.find();
  AppointmentConfirmDetailScreen({
    Key? key,
    required this.isDetail,
    required this.isEditable,
    required this.services,
    this.selectedStatus,
    this.previousStatus,
  }) : super(key: key);
  final bool isDetail;
  final bool isEditable;
  final List<Treatment> services;
  final String? selectedStatus;
  final String? previousStatus;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    controller.selectedStatus = selectedStatus ?? '';
    controller.previousStatus = previousStatus ?? '';
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
              borderRadius: BorderRadius.circular(40.0),
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                width: 40.0,
                height: 40.0,
                child: SvgPicture.asset(AppAssets.BACK_ARROW,
                    height: 14.0, width: 14.0),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'confirm_appointment',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: Get.width * .055),
              ).tr(),
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
                                  textOne: '${tr('date')}:',
                                  textTwo: '${tr('time')}:',
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
                                  textOne: controller.args.dateString ??
                                      'Date Here ido',
                                  textTwo:
                                      '${controller.args.time} - ${controller.getEndTime(controller.args.time, controller.args.duration)}',
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
                                  textOne: '${tr('number')}:',
                                  textTwo: '${tr('email')}:',
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
                                  textOne: controller.args.number,
                                  textTwo: controller.args.email,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${tr('service_details')}:',
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
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: services.length,
                                      itemBuilder: (context, index) {
                                        return Obx(
                                          () => controller.allTreatments.isEmpty
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: isDark
                                                        ? AppColors
                                                            .SECONDARY_COLOR
                                                        : AppColors.GREY_COLOR,
                                                  ),
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
                                                            '${services[index].name} - ${services[index].duration} Min',
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
                                                          '${services[index].price} €',
                                                          style: TextStyle(
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                          'total',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ).tr(),
                                        GetBuilder<
                                            AppointmentConfirmDetailController>(
                                          builder: (controller) {
                                            return Text(
                                              '${controller.getTotalPrice(services)} €',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 40.0),
                                if (controller.args.employeeId != null)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${tr('beauty_specialist')}:',
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
                                      const SizedBox(height: 20.0),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            controller.args.employeeId.length,
                                        itemBuilder: (context, index) {
                                          return specialistCard(
                                            title: homecontroller
                                                .getEmployeeName(controller.args
                                                        .employeeId[index] ??
                                                    '8f1cYZExVjeOo2sBDmQC'),
                                            imageUrl: AppAssets.USER_IMAGE,
                                            subtitle:
                                                tr('fragrances_and_perfumes'),
                                            isDark: isDark,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 20.0),
                                Text(
                                  '${tr('note')}:',
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
                                  controller.args.notes == null ||
                                          controller.args.notes == ''
                                      ? ''
                                      : controller.args.notes,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => PrimaryButton(
                                  width: Get.width - 56,
                                  buttonText: 'confirm',
                                  buttonTextColor: isDark
                                      ? AppColors.BLACK_COLOR
                                      : AppColors.WHITE_COLOR,
                                  color: isDark
                                      ? AppColors.SECONDARY_LIGHT
                                      : AppColors.PRIMARY_COLOR,
                                  onTap: () {
                                    controller.confirm();
                                  },
                                ).loading(controller.isLoading.value,
                                    loadingColor: isDark
                                        ? AppColors.SECONDARY_LIGHT
                                        : AppColors.GREY_COLOR),
                              ),
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
    margin: const EdgeInsets.only(bottom: 10.0),
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
