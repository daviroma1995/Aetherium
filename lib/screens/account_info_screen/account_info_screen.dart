import 'dart:developer';

import 'package:atherium_saloon_app/screens/account_info_screen/account_info_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/custom_drop_down_widget.dart';
import '../../widgets/custom_label_widget.dart';
import '../../widgets/form_field_widget.dart';

class AccountInfoScreen extends StatelessWidget {
  final controller = Get.put(AccountInfoController());
  AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  AppAssets.ACOUNTS_INFO_SCREEN_CURVE,
                  height: Get.size.height * 0.30,
                  fit: BoxFit.fitHeight,
                ),
                Positioned(
                  bottom: 0,
                  left: (Get.width / 2) - 55.5,
                  child: Stack(
                    children: [
                      Container(
                        width: 111.0,
                        height: 111.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 5.0, color: AppColors.BORDER_COLOR),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Image.asset(
                          AppAssets.PROFILE_PIC,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 5,
                        child: GestureDetector(
                          onTap: () {
                            // TODO IMPLEMENTATION REQUIRED
                            log('Open Camera icon');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35.0,
                            width: 35.0,
                            decoration: BoxDecoration(
                              color: AppColors.PRIMARY_COLOR,
                              border: Border.all(
                                color: AppColors.BORDER_COLOR,
                                width: 3.3,
                              ),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: SvgPicture.asset(AppAssets.CAMERA_ICON),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 21.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomLabelWidget(label: AppLanguages.NAME),
                  CustomInputFormField(
                    textEdigintController: TextEditingController(),
                    hintText: 'Name',
                    isValid: true,
                    onSubmit: () {},
                    autoFocus: false,
                  ),
                  const SizedBox(height: 12.0),
                  const CustomLabelWidget(label: AppLanguages.SURNAME),
                  CustomInputFormField(
                    textEdigintController: TextEditingController(),
                    hintText: AppLanguages.SURNAME,
                    isValid: true,
                    onSubmit: () {},
                    autoFocus: false,
                  ),
                  const SizedBox(height: 12.0),
                  const CustomLabelWidget(label: AppLanguages.EMAIL),
                  CustomInputFormField(
                    textEdigintController: TextEditingController(),
                    hintText: 'Email@Gmail.com',
                    isValid: true,
                    onSubmit: () {},
                    autoFocus: false,
                  ),
                  const SizedBox(height: 12.0),
                  const CustomLabelWidget(label: AppLanguages.PHONE_NUMBER),
                  CustomInputFormField(
                    textEdigintController: TextEditingController(),
                    hintText: '+956 424 2687',
                    isValid: true,
                    onSubmit: () {},
                    autoFocus: false,
                  ),
                  const SizedBox(height: 12.0),
                  const CustomLabelWidget(label: AppLanguages.GENDER),
                  Obx(
                    () => CustomDropDown(
                      height: 50.0,
                      label: 'Select Gender',
                      options: ['Male', 'Female'],
                      value: controller.genderValue.value,
                      onChange: (value) {
                        controller.changeValue(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  const CustomLabelWidget(label: AppLanguages.ADDRESS),
                  CustomInputFormField(
                    textEdigintController: TextEditingController(),
                    hintText: 'Address',
                    isValid: true,
                    onSubmit: () {},
                    autoFocus: false,
                  ),
                  const SizedBox(height: 12.0),
                  const CustomLabelWidget(label: AppLanguages.BIRTHDAY),
                  CustomInputFormField(
                    textEdigintController: TextEditingController(),
                    hintText: 'Birthday',
                    isValid: true,
                    onSubmit: () {},
                    autoFocus: false,
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    children: [
                      ButtonWidget(
                        width: Get.width / 2 - 28,
                        buttonText: 'Delete Account',
                        onTap: () {},
                        // color: Colors.black,
                        bordered: true,
                        borderColor: AppColors.PRIMARY_COLOR,
                        buttonTextColor: AppColors.PRIMARY_COLOR,
                      ),
                      const SizedBox(width: 12.0),
                      ButtonWidget(
                        width: Get.width / 2 - 28,
                        buttonText: 'Save',
                        onTap: () {},
                        color: AppColors.PRIMARY_COLOR,
                      )
                    ],
                  ),
                  const SizedBox(height: 30.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
