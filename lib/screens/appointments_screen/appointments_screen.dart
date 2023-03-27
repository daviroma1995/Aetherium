// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/data.dart';
import 'package:atherium_saloon_app/screens/appointments_screen/appointments_controller.dart';
import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_screen.dart';
import 'package:atherium_saloon_app/screens/past_appointment_screen/past_appointment_screen.dart';
import 'package:atherium_saloon_app/screens/upcoming_appointments_screen/upcoming_appointments_screen.dart';

import '../../utils/constants.dart';

class AppointmentsScreen extends StatefulWidget {
  AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with TickerProviderStateMixin {
  final controller = Get.put(AppointmentsController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                onTap: () {
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 25.0,
                  height: 25.0,
                  child: SvgPicture.asset(AppAssets.BACK_ARROW,
                      height: 14.0, width: 14.0),
                ),
              ),
              const SizedBox(width: 12.0),
              Text(AppLanguages.APPOINTMENTS,
                  style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 50.0),
            child: TabBar(
              indicatorColor:
                  isDark ? AppColors.PRIMARY_DARK : AppColors.GREY_COLOR,
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              indicatorPadding: const EdgeInsets.all(0.0),
              labelColor:
                  isDark ? AppColors.WHITE_COLOR : AppColors.BLACK_COLOR,
              unselectedLabelColor: AppColors.GREY_COLOR,
              labelStyle: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w800,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                Tab(
                  text: 'Past',
                ),
                Tab(
                  text: 'Upcoming',
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  height: Get.height,
                  child: TabBarView(
                    children: [
                      PastAppointmentScreen(),
                      UpcomingAppointmentsScreen(),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () {
            controller.createAppointment();
          },
          child: Container(
            alignment: Alignment.center,
            height: 66,
            width: 66,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.BACKGROUND_DARK
                  : AppColors.SECONDARY_COLOR,
              border: Border.all(width: 6.0, color: AppColors.BORDER_COLOR),
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: const Icon(
              Icons.add,
              color: AppColors.WHITE_COLOR,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTabBar extends StatefulWidget {
  final bool isDark;
  final int index;
  final Function onTap;
  const CustomTabBar({
    Key? key,
    required this.isDark,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: TabBar(
        onTap: (value) => widget.onTap(value),
        tabs: [
          GestureDetector(
            onTap: () => widget.onTap(0),
            child: Tab(
              child: Text(
                'Past',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: true ? FontWeight.w800 : FontWeight.w500,
                  color: true
                      ? !widget.isDark
                          ? AppColors.PRIMARY_COLOR
                          : AppColors.GREY_COLOR
                      : AppColors.GREY_COLOR,
                  letterSpacing: .75,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => widget.onTap(1),
            child: Tab(
              child: Text(
                'Upcomming',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: true ? FontWeight.w800 : FontWeight.w500,
                  color: true
                      ? !widget.isDark
                          ? AppColors.PRIMARY_COLOR
                          : AppColors.GREY_COLOR
                      : AppColors.GREY_COLOR,
                  letterSpacing: .75,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
