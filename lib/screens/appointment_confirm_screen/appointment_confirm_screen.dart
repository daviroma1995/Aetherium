import 'package:atherium_saloon_app/screens/appointments_screen/appointments_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AppointmentConfirmScreen extends StatelessWidget {
  const AppointmentConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: Get.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset(AppAssets.APPOINTMENT_TOP),
            ),
            Positioned(
              bottom: 100.0,
              right: 0,
              child: SvgPicture.asset(AppAssets.APPOINTMENT_BOTTOM),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.APPOINTMENT_CONFIRM),
                const SizedBox(height: 44.0),
                const Text(
                  'Congrats!',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.BLACK_COLOR,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  AppLanguages.YOUR_APPOINTMENT,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.GREY_COLOR,
                  ),
                ),
                Text(
                  AppLanguages.BOOKING_IS_SUCCESSFULLY,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.GREY_COLOR,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 47.0,
              left: 22.0,
              right: 22.0,
              child: ButtonWidget(
                width: Get.width,
                buttonText: 'Close',
                onTap: () {
                  Get.offAll(AppointmentsScreen());
                },
                color: AppColors.PRIMARY_COLOR,
              ),
            )
          ],
        ),
      ),
    );
  }
}
