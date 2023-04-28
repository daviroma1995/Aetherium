import 'package:atherium_saloon_app/screens/past_appointment_screen/past_appointment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../widgets/appointments_card_widget.dart';

class PastAppointmentScreen extends StatelessWidget {
  final controller = Get.put(PastAppointmentController());
  PastAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                                        child: AppointmentsCardWidget(
                                          imageUrl: AppAssets.EVENT_IMAGE_ONE,
                                          title: controller
                                              .appointmentEmployees[index]
                                              .name!,
                                          subTitle: 'Fragrances & Perfumes',
                                          color: Colors.red,
                                          status: 'Status Here',
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
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
