// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/text_row_widget.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 27.0, vertical: 13.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(AppAssets.BACK_ARROW),
                    ),
                    const SizedBox(width: 12.0),
                    Text(AppLanguages.FRAGRANCES_PERFUMES,
                        style: Theme.of(context).textTheme.headlineLarge),
                  ],
                ),
              ),
              const SizedBox(height: 18.0),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.PRIMARY_DARK
                          : AppColors.WHITE_COLOR,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      border: isDark
                          ? const Border()
                          : Border.all(color: AppColors.BORDER_COLOR)),
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextRowWidget(
                          textOne: 'Date: ',
                          textTwo: 'Time: ',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                        ),
                        const SizedBox(height: 20.0),
                        const TextRowWidget(
                          textOne: '02/02/2023',
                          textTwo: '8:00 AM - 8:30 AM',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: AppColors.GREY_COLOR,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextRowWidget(
                          textOne: AppLanguages.SERVICE_TREATMENT_DURATION,
                          textTwo: AppLanguages.SERVICE_TREATMENT_CATEGORY,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                        ),
                        const SizedBox(height: 20.0),
                        const TextRowWidget(
                          textOne: '30 Mints',
                          textTwo: 'Heir',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: AppColors.GREY_COLOR,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextRowWidget(
                          textOne: AppLanguages.PRICE,
                          textTwo: AppLanguages.TOTAL_PRICE,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                        ),
                        const SizedBox(height: 20.0),
                        const TextRowWidget(
                          textOne: '\$30.00',
                          textTwo: '\$90.00',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: AppColors.GREY_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          AppLanguages.NOTES,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: AppColors.GREY_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: AppColors.GREY_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: AppColors.GREY_COLOR,
                          ),
                        ),
                        const SizedBox(height: 33.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonWidget(
                              width: (Get.width / 2) - 33.0,
                              buttonText: 'Cancel',
                              onTap: () {
                                Get.back();
                              },
                              bordered: true,
                              buttonTextColor: isDark
                                  ? AppColors.SECONDARY_LIGHT
                                  : AppColors.BLACK_COLOR,
                              borderColor: isDark
                                  ? AppColors.SECONDARY_LIGHT
                                  : AppColors.BLACK_COLOR,
                            ),
                            ButtonWidget(
                              width: (Get.width / 2) - 33.0,
                              buttonText: 'Edit',
                              onTap: () {},
                              color: isDark
                                  ? AppColors.SECONDARY_LIGHT
                                  : AppColors.PRIMARY_COLOR,
                              buttonTextColor: isDark
                                  ? AppColors.PRIMARY_DARK
                                  : AppColors.WHITE_COLOR,
                            )
                          ],
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
}
