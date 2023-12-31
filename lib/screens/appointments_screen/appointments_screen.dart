// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/screens/appointments_screen/appointments_controller.dart';
import 'package:atherium_saloon_app/screens/past_appointment_screen/past_appointment_screen.dart';
import 'package:atherium_saloon_app/screens/upcoming_appointments_screen/upcoming_appointments_screen.dart';

import '../../utils/constants.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> with TickerProviderStateMixin {
  final controller = Get.put(AppointmentsController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: isDark ? AppColors.BACKGROUND_DARK : AppColors.BACKGROUND_COLOR,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(40.0),
                onTap: () => controller.handleBack(context),
                child: Container(
                  alignment: Alignment.center,
                  width: 40.0,
                  height: 40.0,
                  child: SvgPicture.asset(AppAssets.BACK_ARROW, height: 14.0, width: 14.0),
                ),
              ),
              const SizedBox(width: 12.0),
              Text('appointments', style: Theme.of(context).textTheme.headlineLarge).tr(),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 50.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 22.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDark ? AppColors.BACKGROUND_DARK : AppColors.WHITE_COLOR,
                border: Border(
                  bottom: BorderSide(color: isDark ? AppColors.PRIMARY_DARK : AppColors.GREY_COLOR),
                ),
              ),
              child: TabBar(
                dragStartBehavior: DragStartBehavior.start,
                indicatorColor: isDark ? AppColors.WHITE_COLOR : AppColors.BLACK_COLOR,
                padding: EdgeInsets.zero,
                indicatorWeight: 1.0,
                labelColor: isDark ? AppColors.WHITE_COLOR : AppColors.BLACK_COLOR,
                unselectedLabelColor: AppColors.GREY_COLOR,
                labelStyle: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                ),
                onTap: (value) {
                  controller.selectedTab.value = value;
                },
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                tabs: [
                  Tab(
                    text: tr('past'),
                  ),
                  Tab(
                    text: tr('upcomming'),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: SizedBox(
                  child: TabBarView(
                    children: [
                      PastAppointmentScreen(),
                      UpcomingAppointmentsScreen(),
                    ],
                  ),
                ),
              ),
            ],
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
              color: isDark ? AppColors.BACKGROUND_DARK : AppColors.SECONDARY_COLOR,
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

// class CustomTabBar extends StatefulWidget {
//   final bool isDark;
//   final int index;
//   final Function onTap;
//   const CustomTabBar({
//     Key? key,
//     required this.isDark,
//     required this.index,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   State<CustomTabBar> createState() => _CustomTabBarState();
// }

// class _CustomTabBarState extends State<CustomTabBar>
//     with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: TabBar(
//         onTap: (value) => widget.onTap(value),
//         tabs: [
//           GestureDetector(
//             onTap: () => widget.onTap(0),
//             child: Tab(
//               child: Text(
//                 'Past',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   // ignore: dead_code
//                   fontWeight: true ? FontWeight.w800 : FontWeight.w500,
//                   color: true
//                       ? !widget.isDark
//                           ? AppColors.PRIMARY_COLOR
//                           : AppColors.GREY_COLOR
//                       // ignore: dead_code
//                       : AppColors.GREY_COLOR,
//                   letterSpacing: .75,
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () => widget.onTap(1),
//             child: Tab(
//               child: Text(
//                 'Upcomming',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   // ignore: dead_code
//                   fontWeight: true ? FontWeight.w800 : FontWeight.w500,
//                   color: true
//                       ? !widget.isDark
//                           ? AppColors.PRIMARY_COLOR
//                           : AppColors.GREY_COLOR
//                       // ignore: dead_code
//                       : AppColors.GREY_COLOR,
//                   letterSpacing: .75,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
