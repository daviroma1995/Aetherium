import 'package:atherium_saloon_app/screens/appointment_details/appointment_details.dart';
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
          child: Obx(() => controller.upcommingAppointments.isEmpty
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
                            colorFilter: const ColorFilter.mode(
                                AppColors.BORDER_COLOR, BlendMode.srcIn),
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
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.upcommingAppointments.length + 1,
                        itemBuilder: (context, index) {
                          return index ==
                                  controller.upcommingAppointments.length
                              ? const SizedBox(height: 94.0)
                              : Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print('on Tap ');
                                        Get.to(
                                          () => AppointmentDetailsScreen(
                                            appointment: controller
                                                .upcommingAppointments[index],
                                            isDetail: true,
                                            isEditable: true,
                                          ),
                                          duration:
                                              const Duration(milliseconds: 300),
                                          transition: Transition.rightToLeft,
                                          curve: Curves.linear,
                                        );
                                      },
                                      child: AppointmentsCardWidget(
                                        imageUrl: AppAssets.EVENT_IMAGE_ONE,
                                        title: controller
                                            .employeesData[index].name!,
                                        subTitle:
                                            controller.services[index].name!,
                                        color: controller.getColor(
                                            controller.status[index].label!),
                                        status: controller.status[index].label,
                                        date: controller
                                            .upcommingAppointments[index]
                                            .dateWithMonthName,
                                        time: controller
                                            .upcommingAppointments[index].time!,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                  ],
                                );
                        },
                      ),
                    ),
                  ],
                )),
        ),
      ),
    );
  }
}
