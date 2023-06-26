// ignore_for_file: unused_local_variable

import 'package:atherium_saloon_app/screens/past_appointment_screen/past_appointment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../widgets/appointments_card_widget.dart';
import '../../widgets/primary_button.dart';

class PastAppointmentScreen extends StatelessWidget {
  final controller = Get.put(PastAppointmentController());
  PastAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    final dismisibleKey = GlobalKey();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(
        () => Column(
          children: [
            controller.pastAppointments.isEmpty
                ? SizedBox(
                    height: Get.height - 250.0,
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppAssets.CALENDER_ICON_LIGHT),
                        const SizedBox(height: 48.0),
                        const Text(
                          'Scheduled Appointments',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22.0),
                          child: Text(
                            AppLanguages.APPOINTMENT_DESCRIPTION,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: AppColors.BORDER_COLOR,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Obx(
                    () => controller.isInititalized.value == true
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.pastAppointments.length + 1,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return index == controller.pastAppointments.length
                                  ? const SizedBox(height: 72.0)
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: InkWell(
                                        onTap: () =>
                                            controller.goToDetails(index),
                                        onLongPress: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                var yesButton = PrimaryButton(
                                                    color:
                                                        AppColors.ERROR_COLOR,
                                                    width: 60,
                                                    buttonText: 'Yes',
                                                    onTap: () async {
                                                      await controller
                                                          .deleteAppointment(
                                                              index);
                                                      // ignore: use_build_context_synchronously
                                                      Get.back();
                                                      controller.loadData();
                                                    });
                                                var noButton = TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('No'),
                                                );
                                                return AlertDialog(
                                                  alignment: Alignment.center,
                                                  title: const Text(
                                                      'Are you sure?'),
                                                  content: const Text(
                                                      'Appointment will be deleted permanently'),
                                                  actions: [
                                                    yesButton,
                                                    noButton
                                                  ],
                                                );
                                              });
                                        },
                                        child: AppointmentsCardWidget(
                                          imageUrl: AppAssets.EVENT_IMAGE_ONE,
                                          title: controller.employees[0].name!,
                                          subTitle:
                                              controller.services[index].name!,
                                          color: controller.getColor(controller
                                              .appointmentStatus[index].label!),
                                          status: controller
                                              .appointmentStatus[index].label,
                                          date: controller
                                              .pastAppointments[index]
                                              .dateWithMonthName,
                                          time: controller
                                              .pastAppointments[index].time!,
                                        ),
                                      ),
                                    );
                            },
                          )
                        :  Center(
                            child: CircularProgressIndicator(
                                              color: isDark? AppColors.SECONDARY_COLOR : AppColors.GREY_COLOR,

                            ),
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
