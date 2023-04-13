import 'package:atherium_saloon_app/data.dart';
import 'package:atherium_saloon_app/screens/event_details/event_details_screen.dart';
import 'package:atherium_saloon_app/screens/events_screen/events_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class EventsScreen extends StatelessWidget {
  final controller = Get.put(EventsController());
  EventsScreen({super.key});

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
            Text('Events', style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.events.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => controller.goToDetails(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SizedBox(
                      width: Get.width,
                      height: 188.0,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              width: Get.width - 44.0,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.PRIMARY_DARK
                                    : AppColors.BACKGROUND_COLOR,
                                border: isDark
                                    ? const Border()
                                    : Border.all(
                                        width: 1.0,
                                        color: AppColors.GREY_COLOR),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.events[index].title!,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: .75,
                                        color: isDark
                                            ? AppColors.WHITE_COLOR
                                            : AppColors.BLACK_COLOR),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Text(
                                    'Fragrances & Perfumes',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: .75,
                                      color: AppColors.GREY_COLOR,
                                    ),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.CALANDER_ICON,
                                        colorFilter: ColorFilter.mode(
                                            isDark
                                                ? AppColors.SECONDARY_LIGHT
                                                : AppColors.BLACK_COLOR,
                                            BlendMode.srcIn),
                                      ),
                                      const SizedBox(width: 6.0),
                                      Text(
                                        controller.events[index].date!,
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: .75,
                                          color: isDark
                                              ? AppColors.SECONDARY_LIGHT
                                              : AppColors.BLACK_COLOR,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 80.0,
                            left: 0,
                            right: 0,
                            child: CachedNetworkImage(
                              imageUrl: controller.events[index].imageUrl!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          Obx(
                            () => controller.shouldUpdate.value == true
                                ? Positioned(
                                    top: 10,
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.events[index].isfavorite =
                                            !controller
                                                .events[index].isfavorite!;
                                        controller.shouldUpdate.value =
                                            !controller.shouldUpdate.value;
                                      },
                                      child: Icon(
                                        controller.events[index].isfavorite ==
                                                true
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: AppColors.WHITE_COLOR,
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    top: 10,
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.events[index].isfavorite =
                                            !controller
                                                .events[index].isfavorite!;
                                        controller.shouldUpdate.value =
                                            !controller.shouldUpdate.value;
                                      },
                                      child: Icon(
                                        controller.events[index].isfavorite ==
                                                true
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: AppColors.WHITE_COLOR,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
