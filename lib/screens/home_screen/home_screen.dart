// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_controller.dart';
import 'package:atherium_saloon_app/screens/events_screen/events_screen.dart';

import 'package:atherium_saloon_app/screens/home_screen/home_screen_controller.dart';
import 'package:atherium_saloon_app/screens/notifications_screen/notifications_screen.dart';

import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/form_field_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../widgets/custom_appointment_widget.dart';
import '../../widgets/custom_event_card_widget.dart';
import '../../widgets/custom_title_row_widget.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeScreenController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        BottomNavigationController ctrl = Get.find();
        ctrl.reverse();
      },
      child: SafeArea(
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
                      Obx(
                        () => controller.currentUser.value.firstName != null
                            ? Text(
                                controller.currentUser.value.isAdmin!
                                    ? ' Admin'
                                    : ' ${controller.currentUser.value.firstName}',
                                style: TextStyle(
                                  color: isDark
                                      ? AppColors.WHITE_COLOR
                                      : AppColors.SECONDARY_COLOR,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: .75,
                                ),
                              )
                            : Text(''),
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
                          Obx(
                            () => Visibility(
                              visible: controller.notifications.isNotEmpty,
                              child: Positioned(
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
                                      borderRadius:
                                          BorderRadius.circular(110.0),
                                      border: isDark
                                          ? const Border()
                                          : Border.all(
                                              color: AppColors.WHITE_COLOR,
                                              width: 1.1,
                                            )),
                                  child: Obx(
                                    () => FittedBox(
                                      child: Text(
                                        controller.notifications.length
                                            .toString(),
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
                  iconColor: AppColors.GREY_COLOR,
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
              child: LiquidPullToRefresh(
                onRefresh: controller.onRefresh,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
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
                      () => Visibility(
                        visible: controller.treatmentCategories.isEmpty,
                        child: SizedBox(
                          height: 150.0,
                          width: Get.width,
                          child:
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.treatmentCategories.isNotEmpty,
                        child: SizedBox(
                          width: Get.width,
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 20.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemExtent:
                                  MediaQuery.of(context).size.width * .231,
                              itemCount: controller.treatmentCategories
                                  .where((element) => element.name!
                                      .toLowerCase()
                                      .contains(controller.searchedService.value
                                          .toLowerCase()))
                                  .toList()
                                  .length,
                              itemBuilder: (context, index) {
                                var filteredServices = controller
                                    .treatmentCategories
                                    .where((element) => element.name!
                                        .toLowerCase()
                                        .contains(controller
                                            .searchedService.value
                                            .toLowerCase()))
                                    .toList()[index];
                                return GestureDetector(
                                  onTap: () {
                                    controller.searchedService.value == ''
                                        ? controller.serviceNavigation(index)
                                        : controller.serviceNavigation(
                                            controller.treatmentCategories
                                                .indexWhere((element) =>
                                                    element.name ==
                                                    filteredServices.name));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      filteredServices.iconUrl!,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              )
                                            : SvgPicture.asset(
                                                filteredServices.iconUrl!),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Expanded(
                                        child: Text(
                                          filteredServices.name!,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12.0,
                                            letterSpacing: .98,
                                          ),
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
                          Obx(
                            () => Visibility(
                              visible: controller.isLoading.value == true,
                              child: SizedBox(
                                height: 103,
                                width: Get.width,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: controller.isLoading.value == false,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 22.0),
                                child: Obx(
                                  () => controller.appointments.isNotEmpty &&
                                          controller.services.isNotEmpty
                                      ? SizedBox(
                                          height: 103.0,
                                          child: ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                controller.appointments.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .navigateToAppointmentDetail(
                                                          index);
                                                },
                                                child:
                                                    CustomAppointmentCardWidget(
                                                  imageUrl:
                                                      AppAssets.USER_IMAGE,
                                                  title: controller
                                                      .getEmployeeName(
                                                          controller
                                                              .appointments[
                                                                  index]
                                                              .employeeId![0]),
                                                  subTitle: controller
                                                      .getServices(controller
                                                          .appointments[index]
                                                          .serviceId![0]),
                                                  date: controller
                                                      .appointments[index]
                                                      .dateString,
                                                  time: controller
                                                          .appointments[index]
                                                          .time ??
                                                      '',
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          height: 100.0,
                                          // alignment: Alignment.center,
                                          child: const Text(
                                            'No appointments',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black),
                                          ),
                                        ),
                                ),
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
                      borderColor:
                          isDark ? AppColors.GREY_COLOR : AppColors.GREY_COLOR,
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        final result = await Get.to(
                          () => EventsScreen(),
                          duration: const Duration(milliseconds: 400),
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
                        child: Obx(
                          () => controller.isInitialized.value &&
                                  controller.events.isNotEmpty
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: controller.events.value.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.eventNavigation(index);
                                        },
                                        child: Obx(
                                          () => controller
                                                      .shoueldReload.value ==
                                                  false
                                              ? CustomEventCardWidget(
                                                  index: index,
                                                  iamgeUrl: controller
                                                      .events[index].imageUrl!,
                                                  title: controller
                                                      .events[index].title!,
                                                  subTitle: controller
                                                      .events[index].subtitle!,
                                                  time: controller
                                                      .events[index].dateString,
                                                  subtitleColor: isDark
                                                      ? AppColors.GREY_COLOR
                                                      : AppColors.BLACK_COLOR,
                                                  isFavorite: controller
                                                          .events[index]
                                                          .isfavorite ??
                                                      false,
                                                  onIconTap: () => controller
                                                      .setFavorite(index),
                                                )
                                              : CustomEventCardWidget(
                                                  index: index,
                                                  iamgeUrl: controller
                                                      .events[index].imageUrl!,
                                                  subtitleColor: isDark
                                                      ? AppColors.GREY_COLOR
                                                      : AppColors.BLACK_COLOR,
                                                  title: controller
                                                      .events[index].title!,
                                                  subTitle: controller
                                                      .events[index].subtitle!,
                                                  time: controller
                                                      .events[index].dateString,
                                                  isFavorite: controller
                                                      .events[index]
                                                      .isfavorite!,
                                                  onIconTap: () => controller
                                                      .setFavorite(index),
                                                ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : controller.events.isEmpty
                                  ? Container(
                                      height: 150,
                                      alignment: Alignment.center,
                                      width: Get.width,
                                      child: Text(
                                        'No Events Found',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ),
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      height: 190,
                                      child: const CircularProgressIndicator(),
                                    ),
                        ),
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
