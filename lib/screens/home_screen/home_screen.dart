// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/data.dart';
import 'package:atherium_saloon_app/screens/event_details/event_details_screen.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen_controller.dart';
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
    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                        Text(
                          ' Jane C',
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
                      height: 25.0,
                      width: 55.0,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0.0,
                            child: Icon(
                              Icons.notifications_outlined,
                              size: 30.0,
                              color: isDark ? AppColors.GREY_COLOR : null,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: CustomInputFormField(
                  textEdigintController: controller.searchController,
                  iconUrl: AppAssets.SEARCH_ICON,
                  hintText: 'Search',
                  isValid: true,
                  autoFocus: false,
                  onSubmit: () {},
                ),
              ),
              const CustomTitle(
                title: 'Services',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 22.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: services.map(
                    (e) {
                      return Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                              border: !isDark
                                  ? Border.all(color: AppColors.BORDER_COLOR)
                                  : Border(),
                              borderRadius: BorderRadius.circular(130.0),
                              color: !isDark
                                  ? AppColors.WHITE_COLOR
                                  : AppColors.PRIMARY_DARK,
                            ),
                            child: !isDark
                                ? SvgPicture.asset(e['service_image'])
                                : SvgPicture.asset(e['dark_image']),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            e['service_title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              letterSpacing: .98,
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 31.0),
                color:
                    isDark ? AppColors.PRIMARY_DARK : const Color(0xFFFDF9F8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitle(
                      title: AppLanguages.UPCOMING_APPOINTMENTS,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
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
                            return CustomAppointmentCardWidget(
                              imageUrl: upcomingAppointments[index].imageUrl,
                              title: upcomingAppointments[index].userName,
                              subTitle: upcomingAppointments[index].subTitle,
                              date: upcomingAppointments[index].date,
                              time: upcomingAppointments[index].time,
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
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                borderColor:
                    isDark ? AppColors.SECONDARY_LIGHT : AppColors.GREY_COLOR,
              ),
              const SizedBox(height: 13.0),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: SizedBox(
                  height: 190.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Obx(
                          () => GestureDetector(
                            onTap: () {
                              Get.to(() => EventDetailsScreen(),
                                  arguments: events[index]);
                            },
                            child: CustomEventCardWidget(
                              index: index,
                              iamgeUrl: events[index].imageUrl,
                              title: events[index].title,
                              subTitle: events[index].subTitle,
                              time: events[index].date,
                              isFavorite: events[index].isFavorite.value,
                              onIconTap: controller.setFavorite,
                            ),
                          ),
                        ),
                      );
                    },
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
