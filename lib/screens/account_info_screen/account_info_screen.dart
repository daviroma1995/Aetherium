import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:atherium_saloon_app/screens/account_info_screen/account_info_controller.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/utils/image_picker.dart';
import 'package:atherium_saloon_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custom_drop_down_widget.dart';
import '../../widgets/custom_label_widget.dart';
import '../../widgets/form_field_widget.dart';

class AccountInfoScreen extends StatelessWidget {
  final controller = Get.put(AccountInfoController());
  AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                  colorFilter: ColorFilter.mode(
                      isDark ? AppColors.PRIMARY_DARK : AppColors.PRIMARY_COLOR,
                      BlendMode.srcIn),
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Obx(
                              () => controller.imageFileString.isEmpty
                                  ? Image.asset(
                                      AppAssets.PROFILE_PIC,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(
                                        controller.imageFileString.value,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          )),
                      Positioned(
                        bottom: 0,
                        right: 5,
                        child: GestureDetector(
                          onTap: () async {
                            var image = await kImagePicker(context);
                            if (image == null) return;
                            controller.imageUrl.value = XFile(image.path);
                            controller.isUpdating.value = true;
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35.0,
                            width: 35.0,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.BACKGROUND_DARK
                                  : AppColors.PRIMARY_COLOR,
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
                    paddingSymetric: 16.0,
                  ),
                  const SizedBox(height: 12.0),
                  const CustomLabelWidget(label: AppLanguages.SURNAME),
                  CustomInputFormField(
                    textEdigintController: TextEditingController(),
                    hintText: AppLanguages.SURNAME,
                    isValid: true,
                    onSubmit: () {},
                    autoFocus: false,
                    paddingSymetric: 16.0,
                  ),
                  const SizedBox(height: 12.0),
                  const CustomLabelWidget(label: AppLanguages.EMAIL),
                  CustomInputFormField(
                    textEdigintController: TextEditingController(),
                    hintText: 'Email@Gmail.com',
                    isValid: true,
                    onSubmit: () {},
                    autoFocus: false,
                    paddingSymetric: 16.0,
                  ),
                  const SizedBox(height: 12.0),
                  const CustomLabelWidget(label: AppLanguages.PHONE_NUMBER),
                  CustomInputFormField(
                    textEdigintController: TextEditingController(),
                    hintText: '+956 424 2687',
                    isValid: true,
                    onSubmit: () {},
                    autoFocus: false,
                    paddingSymetric: 16.0,
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
                    paddingSymetric: 16.0,
                  ),
                  const SizedBox(height: 12.0),
                  const CustomLabelWidget(label: AppLanguages.BIRTHDAY),
                  // CustomInputFormField(
                  //   textEdigintController: TextEditingController(),
                  //   hintText: 'Birthday',
                  //   isValid: true,
                  //   onSubmit: () {},
                  //   autoFocus: false,
                  //   paddingSymetric: 16.0,
                  // ),
                  GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.utc(1949, DateTime.january, 1),
                        lastDate: DateTime.now(),
                        helpText: 'Select Date of Birth',
                      );
                      controller.dateOfBirth.value = DateTime.parse(
                        date.toString(),
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 18.0),
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.PRIMARY_DARK
                            : AppColors.WHITE_COLOR,
                        border: isDark
                            ? Border()
                            : Border.all(
                                width: 1.0,
                                color: AppColors.BORDER_COLOR,
                              ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Obx(
                        () => Text(controller.getDateOfBirth),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    children: [
                      ButtonWidget(
                        width: Get.width / 2 - 28,
                        buttonText: 'Delete Account',
                        onTap: () async {
                          var isconfirmed = await showOkCancelAlertDialog(
                            context: context,
                            title: 'Alert!',
                            message:
                                'Are you sure you want to delete your account?',
                            okLabel: 'Yes',
                            cancelLabel: 'No',
                            style: AdaptiveStyle.adaptive,
                          );
                          if (isconfirmed == OkCancelResult.ok) {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool('isLogedIn', false);
                            Get.offAll(LoginScreen());
                          }
                        },
                        // color: Colors.black,
                        bordered: true,
                        borderColor: isDark
                            ? AppColors.SECONDARY_LIGHT
                            : AppColors.PRIMARY_COLOR,
                        buttonTextColor: isDark
                            ? AppColors.SECONDARY_LIGHT
                            : AppColors.PRIMARY_COLOR,
                      ),
                      const SizedBox(width: 12.0),
                      ButtonWidget(
                        width: Get.width / 2 - 28,
                        buttonText: 'Save',
                        onTap: () {},
                        color: isDark
                            ? AppColors.SECONDARY_LIGHT
                            : AppColors.PRIMARY_COLOR,
                        buttonTextColor: isDark
                            ? AppColors.PRIMARY_DARK
                            : AppColors.WHITE_COLOR,
                      ),
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
