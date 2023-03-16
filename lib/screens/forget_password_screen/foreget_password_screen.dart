import 'package:atherium_saloon_app/screens/forget_password_screen/forget_password_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/form_field_widget.dart';
import '../../widgets/top_bar_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final ForgetPasswordController controller =
      Get.put(ForgetPasswordController());

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(
                firstItem: GestureDetector(
                  onTap: Get.back,
                  child: SvgPicture.asset(AppAssets.BACK_ARROW),
                ),
                space: 15.0,
                secondItem: const Text(
                  AppLanguages.FORGET_PASSWORD,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 22.0,
                    color: AppColors.BLACK_COLOR,
                  ),
                ),
              ),
              const SizedBox(height: 35.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      AppLanguages.EMAIL,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Obx(
                      () => CustomInputFormField(
                        hintText: 'Email@gmail.com ',
                        iconUrl: AppAssets.MESSAGE_ICON,
                        textEdigintController: controller.emailController,
                        isValid: controller.isEmailValid.value,
                        onSubmit: controller.validateEmail,
                      ),
                    ),
                    Obx(() {
                      if (!controller.isEmailValid.value) {
                        return Text(
                          controller.emailErrorMessage.value,
                          style: TextStyle(color: AppColors.ERROR_COLOR),
                        );
                      } else {
                        return const SizedBox(height: 0.0);
                      }
                    }),
                    const SizedBox(
                      height: 34.0,
                    ),
                    ButtonWidget(
                      width: Get.width,
                      buttonText: AppLanguages.INVIA,
                      color: AppColors.PRIMARY_COLOR,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
