import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import 'notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  final controller = Get.put(NotificationsController());
  NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:
              isDark ? AppColors.BACKGROUND_DARK : AppColors.BACKGROUND_COLOR,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
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
              Container(
                height: 27.0,
                width: 32.0,
                alignment: Alignment.center,
                child: MaterialButton(
                  onPressed: () {},
                  padding: const EdgeInsets.all(0.0),
                  child: SvgPicture.asset(
                    AppAssets.LINES,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notifications[index].title,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .75,
                        color: isDark
                            ? AppColors.SECONDARY_LIGHT
                            : AppColors.SECONDARY_COLOR,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      notifications[index].message,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .75,
                        color: isDark
                            ? AppColors.WHITE_COLOR
                            : AppColors.BLACK_COLOR,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      '${notifications[index].date}, ${notifications[index].time}',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .75,
                        color: isDark
                            ? AppColors.GREY_COLOR
                            : AppColors.GREY_COLOR,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    index == notifications.length - 1
                        ? const SizedBox()
                        : const Divider(
                            color: AppColors.GREY_COLOR,
                          ),
                  ],
                ),
              );
            }));
  }
}
