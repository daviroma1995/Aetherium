import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_screen.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/primary_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../network_utils/firebase_services.dart';

class NewClientConfirmScreen extends StatelessWidget {
  const NewClientConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
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
                    isDark ? AppColors.PRIMARY_DARK : AppColors.SECONDARY_LIGHT,
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
                  'client_creating_message_I',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.GREY_COLOR,
                  ),
                ).tr(),
                const Text(
                  'client_creation_message_II',
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
                onTap: () async {
                  // Get.delete<HomeScreenController>();
                  // var treatmentCategories =
                  //     await FirebaseServices.getTreatmentCategories();
                  // Get.offAll(() => const BottomNavigationScreen(),
                  //     arguments: treatmentCategories);
                  Get.back();
                  Get.back();
                },
                color: isDark
                    ? AppColors.SECONDARY_LIGHT
                    : AppColors.PRIMARY_COLOR,
                buttonTextColor:
                    isDark ? AppColors.BACKGROUND_DARK : AppColors.WHITE_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
