import 'package:atherium_saloon_app/screens/upcoming_appointments_screen/upcoming_appointments_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../widgets/appointments_card_widget.dart';

class UpcomingAppointmentsScreen extends StatelessWidget {
  final controller = Get.put(UpcomingAppointmentsController());
  UpcomingAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              upcomingAppointments.length < 1
                  ? Container(
                      height: Get.height - 250.0,
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppAssets.CALENDER_ICON_LIGHT),
                          const SizedBox(height: 48.0),
                          Text(
                            'Scheduled Appointments',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
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
                  : Container(
                      height: Get.height * .826,
                      child: ListView.builder(
                        // shrinkWrap: false,
                        itemCount: upcomingAppointments.length + 1,
                        itemBuilder: (context, index) {
                          return index == upcomingAppointments.length
                              ? const SizedBox(height: 94.0)
                              : AppointmentsCardWidget(
                                  imageUrl:
                                      upcomingAppointments[index].imageUrl,
                                  title: upcomingAppointments[index].title,
                                  subTitle:
                                      upcomingAppointments[index].subTitle,
                                  color: upcomingAppointments[index].color,
                                  status: upcomingAppointments[index]
                                      .appointmentStatus,
                                  date: upcomingAppointments[index].date,
                                  time: upcomingAppointments[index].time,
                                );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          controller.createAppointment();
        },
        child: Container(
          alignment: Alignment.center,
          height: 66,
          width: 66,
          decoration: BoxDecoration(
            color: AppColors.SECONDARY_COLOR,
            border: Border.all(width: 6.0, color: AppColors.BORDER_COLOR),
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: const Icon(
            Icons.add,
            color: AppColors.WHITE_COLOR,
          ),
        ),
      ),
    );
  }
}
