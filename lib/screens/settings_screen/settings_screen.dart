// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../widgets/custom_list_tile.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  final controller = Get.put(SettingsController());
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 13.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () => Get.back(),
                        child: SvgPicture.asset(AppAssets.BACK_ARROW)),
                    const SizedBox(width: 12.0),
                    const Text(
                      AppLanguages.SETTINGS,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: AppColors.BLACK_COLOR,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .75,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 26.0),
                  child: Column(
                    children: settingsItems.map(
                      (e) {
                        int index = settingsItems.indexOf(e);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Custom_List_TIle(
                              index: index,
                              title: settingsItems[index].title,
                              onTap: () {},
                              imageUrl: settingsItems[index].iconUrl),
                        );
                      },
                    ).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
