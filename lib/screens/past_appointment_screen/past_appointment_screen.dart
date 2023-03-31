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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              pastAppointments.isEmpty
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
                                color: AppColors.GREY_COLOR,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: Get.height * .826,
                      child: ListView.builder(
                        // shrinkWrap: false,
                        physics: const BouncingScrollPhysics(),
                        itemCount: pastAppointments.length + 1,
                        itemBuilder: (context, index) {
                          return index == pastAppointments.length
                              ? const SizedBox(height: 94.0)
                              : InkWell(
                                  onTap: () => controller.goToDetails(index),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: AppointmentsCardWidget(
                                      imageUrl:
                                          pastAppointments[index].imageUrl,
                                      title: pastAppointments[index].title,
                                      subTitle:
                                          pastAppointments[index].subTitle,
                                      color: pastAppointments[index].color,
                                      status: pastAppointments[index]
                                          .appointmentStatus,
                                      date: pastAppointments[index].date,
                                      time: pastAppointments[index].time,
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
