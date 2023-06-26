import 'package:atherium_saloon_app/screens/forget_password_screen/forget_password_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/primary_button.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                secondItem: Text(AppLanguages.FORGET_PASSWORD,
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(height: 35.0),
              Form(
                key: controller.key,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLanguages.EMAIL,
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: 10.0),
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
                      const SizedBox(height: 10.0),
                      Obx(() {
                        if (!controller.isEmailValid.value) {
                          return Text(
                            controller.emailErrorMessage.value,
                            style:
                                const TextStyle(color: AppColors.ERROR_COLOR),
                          );
                        } else {
                          return const SizedBox(height: 0.0);
                        }
                      }),
                      const SizedBox(height: 34.0),
                      Obx(
                        () => Visibility(
                          visible: controller.isLoading.value,
                          child: Column(
                            children:  [
                              Center(
                                child: Padding(
                                  padding:const EdgeInsets.only(bottom: 35.0),
                                  child: CircularProgressIndicator(
                                              color: isDark? AppColors.SECONDARY_COLOR : AppColors.GREY_COLOR,

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PrimaryButton(
                        width: Get.width,
                        buttonText: AppLanguages.ACCEDI,
                        color: isDark
                            ? AppColors.SECONDARY_LIGHT
                            : AppColors.PRIMARY_COLOR,
                        onTap: () {
                          controller.sendResetEmail();
                        },
                        buttonTextColor: !isDark
                            ? AppColors.WHITE_COLOR
                            : AppColors.BLACK_COLOR,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
