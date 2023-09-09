// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/screens/agenda_screen/agenda_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../models/appointment.dart';
import '../../network_utils/firebase_services.dart';
import '../../utils/constants.dart';
import '../../utils/google_calendar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/text_row_widget.dart';
import '../home_screen/home_screen_controller.dart';
import 'appointment_details_controller.dart';
// import 'package:flutter_googlecalendar/flutter_googlecalendar.dart';
// import 'package:atherium_saloon_app/packages/google_calendar/lib/flutter_googlecalendar.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final controller = Get.put(AppointmentDetailsController());
  final HomeScreenController homecontroller = Get.find();
  AppointmentDetailsScreen({
    Key? key,
    this.isDetail = false,
    this.isEditable = false,
    this.isPast = false,
    this.isAdmin = false,
    required this.appointment,
  }) : super(key: key);
  final bool isDetail;
  final bool isEditable;
  final bool isPast;
  final bool isAdmin;
  final Appointment appointment;
  final durationText = TextEditingController();

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
                onTap: isDetail == false
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
                  'appointment_details',
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
                                        'service_details',
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
                                      ).tr(),
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
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: isDark
                                                          ? AppColors
                                                              .SECONDARY_COLOR
                                                          : AppColors
                                                              .GREY_COLOR,
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
                                          Text(
                                            tr('total'),
                                            style: const TextStyle(
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
                                  Visibility(
                                    visible: isEditable,
                                    child: PrimaryButton(
                                        width: Get.width,
                                        color: isDark
                                            ? AppColors.SECONDARY_LIGHT
                                            : AppColors.PRIMARY_COLOR,
                                        buttonText: 'add_to_google_calendar',
                                        onTap: () async {
                                          final startTime = DateTime.parse(
                                                  appointment.startTime!)
                                              .toUtc();
                                          final rfcStartTime =
                                              DateFormat("yyyyMMdd'T'HHmmss")
                                                  .format(startTime);
                                          final endTime = DateTime.parse(
                                                  appointment.endTime!)
                                              .toUtc();
                                          final rfcEndTime =
                                              DateFormat("yyyyMMdd'T'HHmmss")
                                                  .format(endTime);
                                          print('$startTime, $endTime');
                                          print('$rfcStartTime , $rfcEndTime');
                                          String url =
                                              'https://calendar.google.com/calendar/u/0/r/eventedit?text=Meeting+with+Beauty+Specialist&dates=$rfcStartTime/$rfcEndTime&details=&location=G7F5%2B6GJ+Brescia,+Province+of+Brescia,+Italy&sf=true&output=xml';
                                          try {
                                            launchUrlString(url,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          } catch (ex) {
                                            print(ex);
                                          }
                                        }),
                                  ),
                                  const SizedBox(height: 20.0),
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
                                                : AppColors.SECONDARY_COLOR),
                                  ),
                                  const SizedBox(height: 20.0),
                                  ListView.builder(
                                      itemCount: appointment.employeeId!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                                    appointment.notes == null ||
                                            appointment.notes!.isEmpty
                                        ? 'No Notes avaialbe'
                                        : appointment.notes!,
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
                          if (isEditable && isAdmin)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 60,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        controller: durationText,
                                        decoration: InputDecoration(
                                          hintText:
                                              appointment.duration!.toString(),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 0.0),
                                          enabledBorder:
                                              const OutlineInputBorder(),
                                          focusedBorder:
                                              const OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5.0),
                                    const Text('Min'),
                                  ],
                                ),
                                PrimaryButton(
                                    width: Get.width * .5,
                                    buttonText: 'increase_total_duration_by',
                                    buttonTextColor: isDark
                                        ? AppColors.BACKGROUND_DARK
                                        : AppColors.WHITE_COLOR,
                                    color: isDark
                                        ? AppColors.SECONDARY_LIGHT
                                        : AppColors.PRIMARY_COLOR,
                                    onTap: () async {
                                      if (durationText.text != '') {
                                        bool duartionIsUpdated =
                                            await controller.updateDuration(
                                                appointment,
                                                num.parse(durationText.text));
                                        if (duartionIsUpdated) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Duration Increased by ${durationText.text} Minutes');
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          durationText.text = '';
                                          Get.find<HomeScreenController>()
                                              .loadHomeScreen();
                                          Get.find<AgendaController>()
                                              .loadData();
                                          return;
                                        }
                                        Fluttertoast.showToast(
                                            msg:
                                                'Duration is not updated Something went Wrong');
                                        return;
                                      }
                                      Fluttertoast.showToast(
                                          msg: 'The duration Field is Empty');
                                    })
                              ],
                            ),
                          if (isEditable == true)
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      PrimaryButton(
                                        width: Get.width / 2 - 32,
                                        buttonText: 'cancel',
                                        buttonTextColor: isDark
                                            ? AppColors.SECONDARY_LIGHT
                                            : AppColors.BLACK_COLOR,
                                        borderColor: isDark
                                            ? AppColors.SECONDARY_LIGHT
                                            : AppColors.BLACK_COLOR,
                                        bordered: true,
                                        onTap: () async {
                                          Get.back(
                                              result: controller.isChanged);
                                          return controller.isChanged;
                                        },
                                      ),
                                      PrimaryButton(
                                        width: Get.width / 2 - 32,
                                        buttonText: 'edit',
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
                                ],
                              ),
                            ),
                          if (isPast && controller.isAdmin)
                            PrimaryButton(
                              width: Get.width - 32,
                              buttonText: 'Edit',
                              buttonTextColor: isDark
                                  ? AppColors.BACKGROUND_DARK
                                  : AppColors.WHITE_COLOR,
                              color: isDark
                                  ? AppColors.SECONDARY_LIGHT
                                  : AppColors.PRIMARY_COLOR,
                              bordered: false,
                              onTap: () {
                                controller.editStatus(appointment);
                              },
                            )
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
