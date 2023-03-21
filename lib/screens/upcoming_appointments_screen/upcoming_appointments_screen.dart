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
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              upcomingAppointments.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      height: Get.height - 250,
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.CALENDER_ICON_LIGHT,
                            colorFilter: const ColorFilter.mode(
                                AppColors.GREY_DARK, BlendMode.srcIn),
                          ),
                          const SizedBox(height: 48.0),
                          Text(
                            'Scheduled Appointments',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
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
                                letterSpacing: .75,
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
                        itemCount: upcomingAppointments.length + 1,
                        itemBuilder: (context, index) {
                          return index == upcomingAppointments.length
                              ? const SizedBox(height: 94.0)
                              : Column(
                                  children: [
                                    AppointmentsCardWidget(
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
                                    ),
                                    const SizedBox(height: 10.0),
                                  ],
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
