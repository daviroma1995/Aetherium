// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:atherium_saloon_app/screens/events_screen/events_screen.dart';

import 'package:atherium_saloon_app/screens/home_screen/home_screen_controller.dart';
import 'package:atherium_saloon_app/screens/notifications_screen/notifications_screen.dart';

import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/form_field_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/custom_appointment_widget.dart';
import '../../widgets/custom_event_card_widget.dart';
import '../../widgets/custom_title_row_widget.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeScreenController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    print('build called');
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 17.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        AppLanguages.WELCOME,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                      ),
                      Text(
                        ' Basit',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.WHITE_COLOR
                              : AppColors.SECONDARY_COLOR,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: .75,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => NotificationsScreen(),
                          duration: const Duration(milliseconds: 600),
                          transition: Transition.downToUp,
                        );
                      },
                      borderRadius: BorderRadius.circular(25.0),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 5.0,
                            right: 3.0,
                            child: SvgPicture.asset(
                              AppAssets.BELL_ICON,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                isDark
                                    ? AppColors.GREY_COLOR
                                    : AppColors.BLACK_COLOR,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0.0,
                            child: Container(
                              alignment: Alignment.center,
                              width: 17.0,
                              height: 17.0,
                              decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.SECONDARY_LIGHT
                                      : AppColors.SECONDARY_COLOR,
                                  borderRadius: BorderRadius.circular(110.0),
                                  border: isDark
                                      ? const Border()
                                      : Border.all(
                                          color: AppColors.WHITE_COLOR,
                                          width: 1.1,
                                        )),
                              child: FittedBox(
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: isDark
                                        ? AppColors.BACKGROUND_DARK
                                        : AppColors.WHITE_COLOR,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: CustomInputFormField(
                  textEdigintController: controller.searchController,
                  iconUrl: AppAssets.SEARCH_ICON,
                  hintText: 'Search',
                  isValid: true,
                  autoFocus: false,
                  onSubmit: () {},
                  onchange: (value) {
                    controller.onChange(value);
                  },
                  // onFocus: controller.onFocus,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0, right: 22.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Services',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.navigateToServices(),
                            child: Container(
                              padding: const EdgeInsets.only(
                                bottom: 5, // Space between underline and text
                              ),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.BORDER_COLOR,
                                    width: 1.0, // Underline thickness
                                  ),
                                ),
                              ),
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: .75,
                                  color: AppColors.GREY_COLOR,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        width: Get.width,
                        height: 138.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 20.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemExtent:
                                MediaQuery.of(context).size.width * .231,
                            itemCount: services
                                .where((element) => element['service_title']
                                    .toLowerCase()
                                    .contains(controller.searchedService.value
                                        .toLowerCase()))
                                .toList()
                                .length,
                            itemBuilder: (context, index) {
                              var filteredServices = services
                                  .where((element) => element['service_title']
                                      .toLowerCase()
                                      .contains(controller.searchedService.value
                                          .toLowerCase()))
                                  .toList()[index];
                              return GestureDetector(
                                onTap: () {
                                  controller.searchedService.value == ''
                                      ? controller.serviceNavigation(index)
                                      : controller.serviceNavigation(
                                          services.indexWhere((element) =>
                                              element['service_title'] ==
                                              filteredServices[
                                                  'service_title']));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 60.0,
                                      width: 60.0,
                                      decoration: BoxDecoration(
                                        border: !isDark
                                            ? Border.all(
                                                color: AppColors.BORDER_COLOR)
                                            : const Border(),
                                        borderRadius:
                                            BorderRadius.circular(130.0),
                                        color: !isDark
                                            ? AppColors.WHITE_COLOR
                                            : AppColors.PRIMARY_DARK,
                                      ),
                                      child: !isDark
                                          ? SvgPicture.asset(
                                              filteredServices['service_image'])
                                          : SvgPicture.asset(
                                              filteredServices['dark_image']),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      filteredServices['service_title'],
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.0,
                                        letterSpacing: .98,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 31.0),
                      color: isDark
                          ? AppColors.PRIMARY_DARK
                          : const Color(0xFFFDF9F8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTitle(
                            title: AppLanguages.UPCOMING_APPOINTMENTS,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                            onTap: controller.navigateToAppointments,
                          ),
                          const SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 22.0),
                            child: SizedBox(
                              height: 103.0,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: upcomingAppointments.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller
                                          .navigateToAppointmentDetail(index);
                                    },
                                    child: CustomAppointmentCardWidget(
                                      imageUrl:
                                          upcomingAppointments[index].imageUrl,
                                      title:
                                          upcomingAppointments[index].userName,
                                      subTitle:
                                          upcomingAppointments[index].subTitle,
                                      date: upcomingAppointments[index].date,
                                      time: upcomingAppointments[index].time,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomTitle(
                      title: 'Events',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                      borderColor: isDark
                          ? AppColors.SECONDARY_LIGHT
                          : AppColors.GREY_COLOR,
                      onTap: () async {
                        final result = await Get.to(
                          () => EventsScreen(),
                          duration: Duration(milliseconds: 600),
                          transition: Transition.rightToLeft,
                          arguments: controller.events,
                        );
                        if (result != null) {
                          if (controller.shoueldReload.value == true) {
                            controller.shoueldReload.value = false;
                          } else {
                            controller.shoueldReload.value = true;
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 13.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: SizedBox(
                        height: 190.0,
                        child: Obx(() => controller.isInitialized.value
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.events.value.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.eventNavigation(index);
                                      },
                                      child: Obx(
                                        () => controller.shoueldReload.value ==
                                                false
                                            ? CustomEventCardWidget(
                                                index: index,
                                                iamgeUrl: controller
                                                    .events[index].imageUrl!,
                                                title: controller
                                                    .events[index].title!,
                                                subTitle:
                                                    events[index].subTitle,
                                                time: controller
                                                    .events[index].date!,
                                                isFavorite: controller
                                                    .events[index].isFavorite!,
                                                onIconTap: () => controller
                                                    .setFavorite(index),
                                              )
                                            : CustomEventCardWidget(
                                                index: index,
                                                iamgeUrl: controller
                                                    .events[index].imageUrl!,
                                                title: controller
                                                    .events[index].title!,
                                                subTitle:
                                                    events[index].subTitle,
                                                time: controller
                                                    .events[index].date!,
                                                isFavorite: controller
                                                    .events[index].isFavorite!,
                                                onIconTap: () => controller
                                                    .setFavorite(index),
                                              ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                alignment: Alignment.center,
                                height: 190,
                                child: const CircularProgressIndicator(),
                              )),
                      ),
                    ),
                    const SizedBox(height: 82.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
