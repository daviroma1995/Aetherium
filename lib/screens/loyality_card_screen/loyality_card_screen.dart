// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/screens/loyality_card_screen/loyality_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:atherium_saloon_app/data.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/text_row_widget.dart';

import '../../widgets/primo_details_widget.dart';

class LoyalityCardScreen extends StatelessWidget {
  final LoyalityCardController controller = Get.put(LoyalityCardController());
  LoyalityCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 13.0),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        AppLanguages.LOYALITY_CARD,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: .75,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Row(
                  children: [
                    const Text(
                      AppLanguages.POINTS_COLLECTED,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(width: 10.0),
                    Container(
                      alignment: Alignment.center,
                      width: 70.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: AppColors.GREY_COLOR,
                      ),
                      child: const Text(
                        AppLanguages.PRIMO,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.BLACK_COLOR,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              CircularPercentIndicator(
                radius: 69.0,
                lineWidth: 16.0,
                percent: loyalityCard.percentage,
                center: Container(
                  height: 110.0,
                  width: 110.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: AppColors.WHITE_COLOR,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(-1, 1.0),
                        color: AppColors.SHADOW_COLOR,
                        blurRadius: 4.0,
                      ),
                      BoxShadow(
                        offset: Offset(1, 1.0),
                        color: AppColors.SHADOW_COLOR,
                        blurRadius: 4.0,
                      ),
                      BoxShadow(
                        offset: Offset(2, 1.0),
                        color: AppColors.SHADOW_COLOR,
                        blurRadius: 4.0,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        loyalityCard.gainedPoints.toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w800,
                          color: AppColors.PROGRESS_COLOR,
                        ),
                      ),
                      Text(
                        'Of ${loyalityCard.totalPoints.toStringAsFixed(0)} Pts',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                progressColor: AppColors.PROGRESS_COLOR,
                backgroundColor: AppColors.BORDER_COLOR,
                // backgroundWidth: 14,
              ),

              // ====================== Primo Card ===================== //
              const SizedBox(height: 18.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border:
                        Border.all(width: 1.0, color: AppColors.BORDER_COLOR),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 20.0, top: 16.0, bottom: 16.0),
                        child: Primo_Details_Widget(
                          percent: loyalityCard.gainedPoints /
                              loyalityCard.totalPoints,
                          primoTitle: AppLanguages.ACTIVE_PRIMO,
                          date: '22 March 2023',
                          pointsGained:
                              loyalityCard.gainedPoints.toStringAsFixed(0),
                          totalPoints:
                              loyalityCard.totalPoints.toStringAsFixed(0),
                          progressColor: AppColors.PROGRESS_COLOR,
                          imageUrl: AppAssets.CUP_ICON,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 30.0, right: 30.0, bottom: 10.0),
                        child: TextRowWidget(
                          textOne: AppLanguages.NAME,
                          textTwo: AppLanguages.SURNAME,
                          style: TextStyle(
                            color: AppColors.BLACK_COLOR,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 30.0, right: 30.0, bottom: 10.0),
                        child: TextRowWidget(
                          textOne: 'Smith',
                          textTwo: 'Arvind',
                          style: TextStyle(
                            color: AppColors.GREY_COLOR,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 30.0, right: 30.0, bottom: 10.0),
                        child: TextRowWidget(
                          textOne: AppLanguages.LEVEL,
                          textTwo: AppLanguages.EXPIRY_DATE,
                          style: TextStyle(
                            color: AppColors.BLACK_COLOR,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 30.0, right: 30.0, bottom: 16.0),
                        child: TextRowWidget(
                          textOne: AppLanguages.PRIMO,
                          textTwo: '12/08/2023',
                          style: TextStyle(
                            color: AppColors.GREY_COLOR,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border:
                        Border.all(width: 1.0, color: AppColors.BORDER_COLOR),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 20.0, top: 16.0, bottom: 16.0),
                        child: Primo_Details_Widget(
                          percent: 1.0,
                          primoTitle: 'Basic',
                          date: '14 March 2023',
                          pointsGained: 300.toString(),
                          totalPoints: 300.toString(),
                          progressColor: AppColors.CONFIRMED_COLOR,
                          imageUrl: AppAssets.PRIMO_SUCCESS_ICON,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Row(
                  children: [
                    const Text(AppLanguages.INVITE_FRIENDS,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: AppColors.SECONDARY_LIGHT,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: AppColors.BACKGROUND_COLOR,
                          border: Border.all(
                              color: AppColors.GREY_COLOR, width: 1.3),
                        ),
                        child: SvgPicture.asset(AppAssets.INVITE_FRIENDS_ICON),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              AppLanguages.INVITATION_DESCRIPTION,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.BLACK_COLOR,
                              ),
                            ),
                            const SizedBox(width: 15.0),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.RIGHT_ARROW),
                          const SizedBox(width: 15.0),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
    );
  }
}
