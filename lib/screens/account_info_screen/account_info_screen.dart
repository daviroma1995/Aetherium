import 'dart:developer';

import 'package:atherium_saloon_app/screens/login_screen/login_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/custom_label_widget.dart';
import '../../widgets/form_field_widget.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

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
                    iconUrl: '',
                    isValid: true,
                    onSubmit: () {},
                    autoFocus: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
