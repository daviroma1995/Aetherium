// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/screens/event_details/event_details_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/text_row_widget.dart';

class EventDetailsScreen extends StatelessWidget {
  final controller = Get.put(EventDetailsControlelr());
  EventDetailsScreen({super.key});

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(25.0),
              onTap: () => controller.handleBack(context),
              child: Container(
                alignment: Alignment.center,
                width: 25.0,
                height: 25.0,
                child: SvgPicture.asset(AppAssets.BACK_ARROW,
                    height: 14.0, width: 14.0),
              ),
            ),
            const SizedBox(width: 12.0),
            Text(controller.args.title,
                style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: !isDark
                          ? AppColors.BACKGROUND_COLOR
                          : AppColors.PRIMARY_DARK,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      border: isDark
                          ? const Border()
                          : Border.all(color: AppColors.BORDER_COLOR)),
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 251.0,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: Get.arguments.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Positioned(
                            //   top: 9.0,
                            //   right: 11.0,
                            //   child: Obx(
                            //     () => GestureDetector(
                            //       onTap: controller.setFavorite,
                            //       child: Icon(
                            //         controller.isfavorite.value
                            //             ? Icons.favorite
                            //             : Icons.favorite_border,
                            //         color: AppColors.WHITE_COLOR,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        TextRowWidget(
                          textOne: 'Date:',
                          textTwo: 'Location:',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                  color: isDark
                                      ? AppColors.WHITE_COLOR
                                      : AppColors.SECONDARY_COLOR),
                        ),
                        const SizedBox(height: 10.0),
                        TextRowWidget(
                          textOne: Get.arguments.dateString,
                          textTwo: 'Online',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: isDark
                                ? AppColors.GREY_COLOR
                                : AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextRowWidget(
                          textOne: 'Start Time: ',
                          textTwo: 'End Time: ',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                color: isDark
                                    ? AppColors.WHITE_COLOR
                                    : AppColors.SECONDARY_COLOR,
                              ),
                        ),
                        const SizedBox(height: 10.0),
                        TextRowWidget(
                          textOne: Get.arguments.startTimeString,
                          textTwo: Get.arguments.endTimeString,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: isDark
                                ? AppColors.GREY_COLOR
                                : AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextRowWidget(
                          textOne: 'Duration',
                          textTwo: '',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                color: isDark
                                    ? AppColors.WHITE_COLOR
                                    : AppColors.SECONDARY_COLOR,
                              ),
                        ),
                        const SizedBox(height: 10.0),
                        TextRowWidget(
                          textOne: Get.arguments.durationString,
                          textTwo: '',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: isDark
                                ? AppColors.GREY_COLOR
                                : AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Description: ',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                color: isDark
                                    ? AppColors.WHITE_COLOR
                                    : AppColors.SECONDARY_COLOR,
                              ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          Get.arguments.desc,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: isDark
                                ? AppColors.GREY_COLOR
                                : AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Image.asset(AppAssets.MAP_IMAGE),
                      ],
                    ),
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
