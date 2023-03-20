// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../widgets/custom_list_tile.dart';
import 'contacts_controller.dart';

class ContactsScreen extends StatelessWidget {
  final controller = Get.put(ContactsController());
  ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 13.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(AppAssets.BACK_ARROW),
                    ),
                    const SizedBox(width: 12.0),
                    const Text(
                      AppLanguages.CONTACTS,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: AppColors.BLACK_COLOR,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .75,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 21.0),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.BORDER_COLOR, width: 1.3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 27.0, top: 37.0, right: 27.0, bottom: 37.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLanguages.EMAIL,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Email@example.com',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.GREY_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          AppLanguages.PHONE_NUMBER,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '+984 124 54967',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.GREY_COLOR,
                              ),
                            ),
                            Container(
                              width: 102.0,
                              height: 26.0,
                              decoration: BoxDecoration(
                                color: AppColors.GREEN_COLOR,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppAssets.WHATSAPP_ICON),
                                  const SizedBox(width: 12.0),
                                  Text(
                                    'WhatsApp',
                                    style: TextStyle(
                                      fontSize: 8.0,
                                      color: AppColors.WHITE_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          AppLanguages.TIME,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          '8:00 AM - 8:30 AM',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.GREY_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          AppLanguages.OPENING_HOURS_OF_THE_SHOP,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: timeTable.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                openingHours(
                                    day: timeTable[index].day,
                                    from: timeTable[index].startTime,
                                    to: timeTable[index].endTim!),
                                const SizedBox(height: 10.0),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          AppLanguages.DESCRIPTION,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.GREY_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          AppLanguages.BEAUTY_SPECIALIST,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: beautySpecialist.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                specialistCard(
                                  imageUrl: beautySpecialist[index].imageUrl,
                                  title: beautySpecialist[index].name,
                                  subtitle: beautySpecialist[index].designation,
                                ),
                                const SizedBox(height: 10.0),
                              ],
                            );
                          },
                        )
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

  Container specialistCard(
      {required String title,
      required String subtitle,
      required String imageUrl}) {
    return Container(
      height: 82.0,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: AppColors.BORDER_COLOR,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.3, color: AppColors.BORDER_COLOR),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage(imageUrl),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.BLACK_COLOR,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.GREY_COLOR,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Row openingHours({required String day, String? from, required String to}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: AppColors.SECONDARY_COLOR,
          ),
        ),
        Text(
          from == null ? '$to' : '$from - $to',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: AppColors.GREY_COLOR,
          ),
        ),
      ],
    );
  }
}
