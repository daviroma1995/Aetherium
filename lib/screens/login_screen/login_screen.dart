// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';

import '../../widgets/primary_button.dart';
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
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(
                firstItem: Text(
                  'welcome_to',
                  style: Theme.of(context).textTheme.headlineMedium,
                ).tr(),
                secondItem: Text(
                  'aetherium',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ).tr(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Text('login',
                        style: Theme.of(context).textTheme.headlineLarge)
                    .tr(),
              ),
              const SizedBox(height: 27.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomLabelWidget(label: 'email'),
                    const SizedBox(height: 5.0),
                    Obx(
                      () => CustomInputFormField(
                        hintText: 'Email@gmail.com ',
                        iconUrl: AppAssets.MESSAGE_ICON,
                        textEdigintController: controller.emailController,
                        isValid: controller.isEmailValid.value,
                        onSubmit: controller.validateEmail,
                        autoFocus: false,
                        onchange: (value) {},
                      ),
                    ),
                    Obx(() {
                      if (!controller.isEmailValid.value) {
                        return Text(
                          controller.emailErrorMessage.value,
                          style: const TextStyle(color: AppColors.ERROR_COLOR),
                        );
                      } else {
                        return const SizedBox(height: 0.0);
                      }
                    }),
                    const SizedBox(height: 17.0),
                    const CustomLabelWidget(label: 'password'),
                    const SizedBox(height: 5.0),
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
                        autoFocus: false,
                        onchange: (value) {},
                      ),
                    ),
                    Obx(() {
                      if (!controller.isPasswordValid.value) {
                        return Text(
                          controller.passwordErrorMessage.value,
                          style: const TextStyle(color: AppColors.ERROR_COLOR),
                        );
                      } else {
                        return const SizedBox(height: 0.0);
                      }
                    }),
                    const SizedBox(height: 17.0),
                    GestureDetector(
                      onTap: controller.navigateToForgetPassword,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'forget_password',
                          style: TextStyle(color: AppColors.GREY_DARK),
                        ).tr(),
                      ),
                    ),
                    const SizedBox(height: 17.0),
                    Obx(() {
                      if (controller.isLoading.value == true) {
                        return Column(
                          children: [
                            Center(
                              child: CircularProgressIndicator(
                                color: isDark
                                    ? AppColors.SECONDARY_COLOR
                                    : AppColors.GREY_COLOR,
                              ),
                            ),
                            const SizedBox(height: 17.0)
                          ],
                        );
                      } else {
                        return const SizedBox(height: 17.0);
                      }
                    }),
                    PrimaryButton(
                      width: Get.width,
                      buttonText: 'sign_in',
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
