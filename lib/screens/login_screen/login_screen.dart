// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/screens/forget_password_screen/foreget_password_screen.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/custom_label_widget.dart';
import '../../widgets/form_field_widget.dart';
import '../../widgets/top_bar_widget.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(
                firstItem: Text(
                  AppLanguages.WELCOME_TO,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                secondItem: Text(
                  AppLanguages.AETHERIUM,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Text(AppLanguages.LOGIN,
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(height: 27.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomLabelWidget(label: AppLanguages.EMAIL),
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
                    const SizedBox(height: 17.0),
                    const CustomLabelWidget(label: AppLanguages.LOGIN),
                    const SizedBox(height: 10.0),
                    Obx(
                      () => CustomInputFormField(
                        hintText: '***************',
                        iconUrl: AppAssets.LOCK_ICON,
                        isPassword: true,
                        isObsecure: controller.isObsecure.value,
                        textEdigintController: controller.passwordController,
                        isValid: controller.isPasswordValid.value,
                        onSubmit: controller.validatePassword,
                        onPressed: controller.hideOrShowPassword,
                      ),
                    ),
                    Obx(() {
                      if (!controller.isPasswordValid.value) {
                        return Text(
                          controller.passwordErrorMessage.value,
                          style: TextStyle(color: AppColors.ERROR_COLOR),
                        );
                      } else {
                        return const SizedBox(height: 0.0);
                      }
                    }),
                    const SizedBox(height: 17.0),
                    GestureDetector(
                      // TODO add navigation to forget password screen
                      onTap: () => Get.to(ForgetPasswordScreen()),
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${AppLanguages.FORGET_PASSWORD}?',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 34.0,
                    ),
                    ButtonWidget(
                      width: Get.width,
                      buttonText: AppLanguages.ACCEDI,
                      color: isDark
                          ? AppColors.SECONDARY_LIGHT
                          : AppColors.PRIMARY_COLOR,
                      onTap: controller.navigator,
                      buttonTextColor: !isDark
                          ? AppColors.WHITE_COLOR
                          : AppColors.BLACK_COLOR,
                    ),
                    const SizedBox(height: 10.0),
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
