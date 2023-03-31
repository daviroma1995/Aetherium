// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/screens/appointment_confirm_detail_screen/appointment_confirm_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';

import 'package:atherium_saloon_app/data.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/custom_title_row_widget.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('March', style: Theme.of(context).textTheme.headlineLarge),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppAssets.CALANDER_ICON,
                    colorFilter: ColorFilter.mode(
                        isDark ? AppColors.GREY_COLOR : AppColors.PRIMARY_COLOR,
                        BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: HorizontalCalendar(
              date: DateTime.now(),
              textColor: isDark ? AppColors.WHITE_COLOR : Colors.black45,
              backgroundColor:
                  !isDark ? Colors.white : AppColors.BACKGROUND_DARK,
              selectedColor: AppColors.SECONDARY_COLOR,
              showMonth: false,
              onDateSelected: (date) {
                // TODO
              },
            ),
          ),
          const SizedBox(height: 13.0),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                width: Get.width,
                height: null,
                decoration: BoxDecoration(
                  color:
                      isDark ? AppColors.PRIMARY_DARK : AppColors.WHITE_COLOR,
                  border: isDark
                      ? const Border()
                      : Border.all(width: 1.0, color: AppColors.BORDER_COLOR),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      CustomTitle(
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                        title: 'Tuesday',
                        subTitle: '14/03/2023',
                        isUnderLined: false,
                      ),
                      const SizedBox(height: 17.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: agendas.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 23.0, bottom: 10.0),
                            child: GestureDetector(
                              onTap: () => Get.to(
                                AppointmentConfirmDetailScreen(
                                  isDetail: true,
                                  isEditable: false,
                                ),
                                duration: const Duration(
                                  milliseconds: 600,
                                ),
                                transition: Transition.downToUp,
                              ),
                              child: AgendaCustomCardWidget(
                                startTime: agendas[index].startTime,
                                endTime: agendas[index].endTime,
                                duration: agendas[index].duration,
                                userImageUrl: agendas[index].iamgeUrl,
                                userName: agendas[index].userName,
                                service: agendas[index].service,
                                agendaColor: isDark
                                    ? agendas[index].darkolor
                                    : agendas[index].color,
                                agendaBarsColor: agendas[index].color,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class AgendaCustomCardWidget extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String duration;
  final String userImageUrl;
  final String userName;
  final String service;
  final Color agendaColor;
  final Color agendaBarsColor;
  const AgendaCustomCardWidget({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.userImageUrl,
    required this.userName,
    required this.service,
    required this.agendaColor,
    required this.agendaBarsColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Container(
          width: 3.0,
          height: 82.0,
          color: agendaBarsColor,
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppAssets.CLOCK_ICON,
                  colorFilter: ColorFilter.mode(
                      isDark ? AppColors.WHITE_COLOR : AppColors.PRIMARY_COLOR,
                      BlendMode.srcIn),
                ),
                const SizedBox(width: 5.0),
                Column(
                  children: [
                    Text(
                      startTime,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                    Text(
                      endTime,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 7.0),
            Row(
              children: [
                Container(
                  height: 8.0,
                  width: 8.0,
                  decoration: BoxDecoration(
                    color: agendaBarsColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                const SizedBox(width: 12.0),
                Text(
                  duration,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 17.0),
        Expanded(
          child: Container(
            height: 82.0,
            decoration: BoxDecoration(
                color: agendaColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                )),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
              child: Row(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1.3, color: AppColors.WHITE_COLOR),
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(userImageUrl),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.WHITE_COLOR
                                : AppColors.PRIMARY_COLOR,
                          ),
                        ),
                        Text(
                          service,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.GREY_COLOR
                                : AppColors.PRIMARY_COLOR,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
