import 'package:atherium_saloon_app/screens/appointments_screen/appointments_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/primary_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AppointmentConfirmScreen extends StatelessWidget {
  const AppointmentConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async {
        Get.offUntil(
            GetPageRoute(page: () => const AppointmentsScreen()),
            (route) =>
                (route as GetPageRoute).routeName == '/BottomNavigationScreen');
        return false;
      },
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: Get.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: SvgPicture.asset(
                  AppAssets.APPOINTMENT_TOP,
                  colorFilter: ColorFilter.mode(
                    isDark ? AppColors.PRIMARY_DARK : AppColors.SECONDARY_LIGHT,
                    BlendMode.srcIn,
                  ),
                  width: Get.width * .4,
                ),
              ),
              Positioned(
                bottom: 100.0,
                right: 0,
                child: SvgPicture.asset(
                  AppAssets.APPOINTMENT_BOTTOM,
                  colorFilter: ColorFilter.mode(
                      isDark
                          ? AppColors.PRIMARY_DARK
                          : AppColors.SECONDARY_LIGHT,
                      BlendMode.srcIn),
                  width: Get.width * .15,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isDark
                      ? SvgPicture.asset(AppAssets.DARK_CONFIRM_ICON)
                      : SvgPicture.asset(AppAssets.APPOINTMENT_CONFIRM),
                  const SizedBox(height: 44.0),
                  Text('congratulations',
                          style: Theme.of(context).textTheme.headlineLarge)
                      .tr(),
                  const SizedBox(height: 10.0),
                  const Text(
                    'your_appointment',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.GREY_COLOR,
                    ),
                  ).tr(),
                  const Text(
                    'booking_is_successfull',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.GREY_COLOR,
                    ),
                  ).tr(),
                ],
              ),
              Positioned(
                bottom: 47.0,
                left: 22.0,
                right: 22.0,
                child: PrimaryButton(
                  width: Get.width,
                  buttonText: 'close',
                  onTap: () {
                    Get.offUntil(
                        GetPageRoute(page: () => const AppointmentsScreen()),
                        (route) =>
                            (route as GetPageRoute).routeName ==
                            '/BottomNavigationScreen');
                  },
                  color: isDark
                      ? AppColors.SECONDARY_LIGHT
                      : AppColors.PRIMARY_COLOR,
                  buttonTextColor: isDark
                      ? AppColors.BACKGROUND_DARK
                      : AppColors.WHITE_COLOR,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
