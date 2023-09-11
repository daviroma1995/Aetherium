import 'dart:developer';

import 'package:atherium_saloon_app/screens/appointment_details/appointment_details.dart';
import 'package:atherium_saloon_app/screens/upcoming_appointments_screen/upcoming_appointments_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../widgets/appointments_card_widget.dart';
import '../../widgets/primary_button.dart';

class UpcomingAppointmentsScreen extends StatelessWidget {
  final controller = Get.put(UpcomingAppointmentsController());
  UpcomingAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(() => controller.upcommingAppointments.isEmpty && controller.isLoading.value == false
              ? Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: Get.height - 250,
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.CALENDER_ICON_LIGHT,
                            colorFilter: const ColorFilter.mode(AppColors.BORDER_COLOR, BlendMode.srcIn),
                          ),
                          const SizedBox(height: 48.0),
                          Text(
                            'scheduled_appointments',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                ),
                          ).tr(),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22.0),
                            child: const Text(
                              'appointment_description',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: AppColors.GREY_COLOR,
                                letterSpacing: .75,
                              ),
                            ).tr(),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Obx(
                  () => controller.isLoading.isTrue
                      ? SizedBox(
                          height: Get.height / 1.5,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: isDark ? AppColors.SECONDARY_COLOR : AppColors.GREY_COLOR,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.upcommingAppointments.length + 1,
                                itemBuilder: (context, index) {
                                  return index == controller.upcommingAppointments.length
                                      ? const SizedBox(height: 94.0)
                                      : Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                  () => AppointmentDetailsScreen(
                                                    appointment: controller.upcommingAppointments[index],
                                                    isDetail: true,
                                                    isEditable: true,
                                                    isAdmin: controller.isAdmin,
                                                  ),
                                                  duration: const Duration(milliseconds: 300),
                                                  transition: Transition.rightToLeft,
                                                  curve: Curves.linear,
                                                );
                                              },
                                              onLongPress: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      var yesButton = PrimaryButton(
                                                          color: AppColors.ERROR_COLOR,
                                                          width: 60,
                                                          buttonText: 'Yes',
                                                          onTap: () async {
                                                            log('Pressed');
                                                            await controller.deleteAppointment(index);
                                                            // ignore: use_build_context_synchronously
                                                            Get.back();
                                                            await controller.loadData();
                                                          });
                                                      var noButton = TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: const Text('No'),
                                                      );
                                                      return AlertDialog(
                                                        alignment: Alignment.center,
                                                        title: const Text('Are you sure?'),
                                                        content: const Text('Appointment will be deleted permanently'),
                                                        actions: [yesButton, noButton],
                                                      );
                                                    });
                                              },
                                              child: AppointmentsCardWidget(
                                                imageUrl: AppAssets.EVENT_IMAGE_ONE,
                                                title: controller.isAdmin
                                                    ? '${controller.listOfClients[index].firstName.toString().capitalize} - ${controller.listOfClients[index].lastName.toString().capitalize}'
                                                    : controller.employeesData[index].name!,
                                                subTitle:
                                                    '${controller.listOfTreatmentCategory[index].name} - ${controller.services[index].name!}',
                                                color: controller.getColor(controller.status[index].label!),
                                                status: controller.status[index].label,
                                                date: controller.upcommingAppointments[index].dateWithMonthName,
                                                time: controller.upcommingAppointments[index].time ?? 'Nill',
                                              ),
                                            ),
                                            const SizedBox(height: 10.0),
                                          ],
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                )),
        ),
      ),
    );
  }
}
