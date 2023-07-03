// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/full_screen_image/full_screen_image.dart';
import 'package:atherium_saloon_app/screens/loyality_card_screen/loyality_card_controller.dart';
import 'package:atherium_saloon_app/screens/qr_code_screen/qr_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor:
            isDark ? AppColors.BACKGROUND_DARK : AppColors.BACKGROUND_COLOR,
        title: Row(
          children: [
            const SizedBox(width: 5),
            Text(AppLanguages.LOYALITY_CARD,
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(width: 13.0),
            GestureDetector(
              onTap: () async {
                var image = await FirebaseServices.getDownloadUrl(
                    'images/bring_friend.png');
                Get.to(() => FullScreenImage(imageUrl: image));
              },
              child: SvgPicture.asset(
                AppAssets.INFO_ICON,
                colorFilter: ColorFilter.mode(
                    isDark ? AppColors.WHITE_COLOR : AppColors.BLACK_COLOR,
                    BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? SizedBox(
                  height: Get.height - 100,
                  width: Get.width,
                  child:  Center(
                    child: CircularProgressIndicator(
                                              color: isDark? AppColors.SECONDARY_COLOR : AppColors.GREY_COLOR,

                    ),
                  ),
                )
              : Visibility(
                  visible: controller.isLoading.isFalse,
                  child: LiquidPullToRefresh(
                    backgroundColor: isDark ? AppColors.SECONDARY_LIGHT : AppColors.WHITE_COLOR,
                    onRefresh: () async => await controller.loadData(),
                    child: ListView(
                      shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.BACKGROUND_DARK
                                : AppColors.CARD_COLOR,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 26.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLanguages.POINTS_COLLECTED,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 70.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          color: isDark
                                              ? AppColors.BACKGROUND_DARK
                                              : AppColors.BORDER_COLOR,
                                        ),
                                        child: Text(
                                          controller.membershipType!.name!
                                              .capitalize!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 25.0),
                                CircularPercentIndicator(
                                  radius: 69.0,
                                  lineWidth: 12.7,
                                  percent:
                                      controller.clientMembership!.percentage,
                                  center: Container(
                                    height: 113.0,
                                    width: 113.0,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: isDark
                                          ? AppColors.BACKGROUND_DARK
                                          : AppColors.WHITE_COLOR,
                                      boxShadow: isDark
                                          ? List.empty()
                                          : const [
                                              BoxShadow(
                                                offset: Offset(-1, 1.0),
                                                color: AppColors.SHADOW_COLOR,
                                                blurRadius: 5.0,
                                              ),
                                              BoxShadow(
                                                offset: Offset(1, 1.0),
                                                color: AppColors.SHADOW_COLOR,
                                                blurRadius: 5.0,
                                              ),
                                              BoxShadow(
                                                offset: Offset(2, 1.0),
                                                color: AppColors.SHADOW_COLOR,
                                                blurRadius: 5.0,
                                              )
                                            ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller.clientMembership!.points!
                                              .toStringAsFixed(0),
                                          style: const TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.SECONDARY_COLOR,
                                          ),
                                        ),
                                        Text(
                                          'Of ${loyalityCard.totalPoints.toStringAsFixed(0)} Pts',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1.28,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  progressColor: AppColors.PROGRESS_COLOR,
                                  backgroundColor: isDark
                                      ? AppColors.PRIMARY_DARK
                                      : AppColors.BORDER_COLOR,
                                  // backgroundWidth: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // ====================== Primo Card ===================== //

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: isDark
                                  ? AppColors.PRIMARY_DARK
                                  : AppColors.WHITE_COLOR,
                              border: isDark
                                  ? const Border()
                                  : Border.all(
                                      width: 1.0,
                                      color: AppColors.BORDER_COLOR),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 20.0,
                                      top: 16.0,
                                      bottom: 16.0),
                                  child: PrimoDetailsWidget(
                                    percent: loyalityCard.gainedPoints /
                                        loyalityCard.totalPoints,
                                    primoTitle:
                                        'Active ${controller.membershipType!.name!.capitalize}',
                                    date:
                                        '${controller.clientMembership!.startDate}',
                                    progressColor: AppColors.PROGRESS_COLOR,
                                    imageUrl: AppAssets.CUP_ICON,
                                    onPressed: () {
                                      Get.to(
                                        () => QrCodeScreen(),
                                        duration:
                                            const Duration(milliseconds: 600),
                                        transition: Transition.downToUp,
                                        curve: Curves.linear,
                                        arguments: controller.uid,
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30.0, bottom: 10.0),
                                  child: TextRowWidget(
                                    textOne: AppLanguages.NAME,
                                    textTwo: AppLanguages.SURNAME,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30.0, bottom: 10.0),
                                  child: TextRowWidget(
                                    textOne:
                                        '${controller.client.firstName!.capitalize}',
                                    textTwo:
                                        '${controller.client.lastName!.capitalize}',
                                    style: const TextStyle(
                                      color: AppColors.GREY_COLOR,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30.0, bottom: 10.0),
                                  child: TextRowWidget(
                                    textOne: AppLanguages.LEVEL,
                                    textTwo: AppLanguages.EXPIRY_DATE,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30.0, bottom: 16.0),
                                  child: TextRowWidget(
                                    textOne:
                                        '${controller.membershipType!.name!.capitalize}',
                                    textTwo: '12/08/2023',
                                    style: const TextStyle(
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
                              color: isDark
                                  ? AppColors.PRIMARY_DARK
                                  : AppColors.WHITE_COLOR,
                              borderRadius: BorderRadius.circular(8.0),
                              border: isDark
                                  ? const Border()
                                  : Border.all(
                                      width: 1.0,
                                      color: AppColors.BORDER_COLOR),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 20.0,
                                      top: 16.0,
                                      bottom: 16.0),
                                  child: PrimoDetailsWidget(
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
                              Text(
                                AppLanguages.INVITE_FRIENDS,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: () async {
                            var imageUrl =
                                await FirebaseServices.getDownloadUrl(
                                    'images/bring_friend.png');
                            Get.to(() => FullScreenImage(imageUrl: imageUrl));
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.PRIMARY_DARK
                                    : AppColors.SECONDARY_LIGHT,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: isDark
                                          ? AppColors.BACKGROUND_DARK
                                          : AppColors.BACKGROUND_COLOR,
                                      border: Border.all(
                                          color: AppColors.GREY_COLOR,
                                          width: 1.3),
                                    ),
                                    child: SvgPicture.asset(
                                      AppAssets.INVITE_FRIENDS_ICON,
                                      colorFilter: ColorFilter.mode(
                                          !isDark
                                              ? AppColors.PRIMARY_COLOR
                                              : AppColors.WHITE_COLOR,
                                          BlendMode.srcIn),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          AppLanguages.INVITATION_DESCRIPTION,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        const SizedBox(width: 15.0),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.RIGHT_ARROW,
                                        colorFilter: ColorFilter.mode(
                                            isDark
                                                ? AppColors.GREY_COLOR
                                                : AppColors.WHITE_COLOR,
                                            BlendMode.srcIn),
                                      ),
                                      const SizedBox(width: 15.0),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 82.0),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
