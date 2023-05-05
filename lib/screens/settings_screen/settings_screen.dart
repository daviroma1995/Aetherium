// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../widgets/custom_list_tile.dart';
import '../../widgets/select_theme_dialog.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  final controller = Get.put(SettingsController());
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:
            isDark ? AppColors.BACKGROUND_DARK : AppColors.BACKGROUND_COLOR,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(25.0),
              onTap: () => controller.handleBack(),
              child: Container(
                alignment: Alignment.center,
                width: 25.0,
                height: 25.0,
                child: SvgPicture.asset(AppAssets.BACK_ARROW,
                    height: 14.0, width: 14.0),
              ),
            ),
            const SizedBox(width: 12.0),
            Text(AppLanguages.SETTINGS,
                style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 10.0),
                  child: Column(
                    children: settingsItems.map(
                      (e) {
                        int index = settingsItems.indexOf(e);
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom:
                                index != settingsItems.length - 1 ? 10.0 : 0.0,
                          ),
                          child: CustomListTIle(
                              index: index,
                              title: settingsItems[index].title,
                              onTap: controller.navigationHandle,
                              imageUrl: settingsItems[index].iconUrl),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: GestureDetector(
                  onTap: () async {
                    var themeMode = await AdaptiveTheme.getThemeMode();
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_context) {
                        return SelectThemeDialog(
                          themeMode: themeMode,
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: isDark
                          ? const Border()
                          : Border.all(
                              width: 1.0,
                              color: AppColors.BORDER_COLOR,
                            ),
                      borderRadius: BorderRadius.circular(8.0),
                      color: isDark
                          ? AppColors.PRIMARY_DARK
                          : AppColors.BACKGROUND_COLOR,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.SECONDARY_LIGHT
                                      : AppColors.SECONDARY_COLOR,
                                ),
                                child: SvgPicture.asset(
                                  AppAssets.THEME_MODE,
                                  width: 30.0,
                                  colorFilter: ColorFilter.mode(
                                      isDark
                                          ? AppColors.BLACK_COLOR
                                          : AppColors.WHITE_COLOR,
                                      BlendMode.srcIn),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Text(
                              AppLanguages.THEME,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        SvgPicture.asset(
                          AppAssets.RIGHT_ARROW,
                          colorFilter: const ColorFilter.mode(
                              AppColors.GREY_COLOR, BlendMode.srcIn),
                        )
                      ],
                    ),
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
