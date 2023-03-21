// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/text_row_widget.dart';

class AgendaDetailScreen extends StatelessWidget {
  const AgendaDetailScreen({super.key});

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
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    border: isDark
                        ? const Border()
                        : Border.all(color: AppColors.BORDER_COLOR),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextRowWidget(
                          textOne: 'Date:',
                          textTwo: 'Time:',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: isDark
                                ? AppColors.WHITE_COLOR
                                : AppColors.BLACK_COLOR,
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
                          textOne: 'Duration: ',
                          textTwo: 'Location: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: isDark
                                ? AppColors.WHITE_COLOR
                                : AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const TextRowWidget(
                          textOne: '30 Mints',
                          textTwo: 'Online',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: AppColors.GREY_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Description: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: isDark
                                ? AppColors.WHITE_COLOR
                                : AppColors.BLACK_COLOR,
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
                        Container(
                          width: Get.width,
                          height: 183.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              AppAssets.MAKEUP_IMAGE,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
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
