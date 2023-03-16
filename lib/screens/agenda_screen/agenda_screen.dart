// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'March',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: .75,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.calendar_month_outlined),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: HorizontalCalendar(
                date: DateTime.now(),
                textColor: Colors.black45,
                backgroundColor: Colors.white,
                selectedColor: AppColors.SECONDARY_COLOR,
                showMonth: false,
                onDateSelected: (date) {
                  print(date.toString());
                },
              ),
            ),
            const SizedBox(height: 13.0),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                width: Get.width,
                // height: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: AppColors.BORDER_COLOR),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: [
                    const CustomTitle(
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
                          child: AgendaCustomCardWidget(
                            startTime: agendas[index].startTime,
                            endTime: agendas[index].endTime,
                            duration: agendas[index].duration,
                            userImageUrl: agendas[index].iamgeUrl,
                            userName: agendas[index].userName,
                            service: agendas[index].service,
                            agendaColor: agendas[index].color,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
  const AgendaCustomCardWidget({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.userImageUrl,
    required this.userName,
    required this.service,
    required this.agendaColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3.0,
          height: 82.0,
          color: agendaColor,
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(AppAssets.CLOCK_ICON),
                const SizedBox(width: 5.0),
                Column(
                  children: [
                    Text(
                      startTime,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      endTime,
                      style: const TextStyle(
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
                    color: agendaColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                const SizedBox(width: 12.0),
                Text(
                  duration,
                  style: const TextStyle(
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
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.PRIMARY_COLOR,
                          ),
                        ),
                        Text(
                          service,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.PRIMARY_COLOR,
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
