// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/screens/service_detail_screen/service_detail_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../models/treatment.dart';
import '../../widgets/text_row_widget.dart';

ServiceDetailController controller = Get.put(ServiceDetailController());

class ServiceDetailScreen extends StatelessWidget {
  final Treatment treatmentData;
  const ServiceDetailScreen({
    Key? key,
    required this.treatmentData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
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
              onTap: () => Get.back(),
              child: Container(
                alignment: Alignment.center,
                width: 25.0,
                height: 25.0,
                child: SvgPicture.asset(AppAssets.BACK_ARROW,
                    height: 14.0, width: 14.0),
              ),
            ),
            const SizedBox(width: 12.0),
            Text(treatmentData.name!,
                style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
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
                          textOne: 'Duration: ',
                          textTwo: 'Prezzo: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: isDark
                                ? AppColors.WHITE_COLOR
                                : AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextRowWidget(
                          textOne: '${treatmentData.duration!} min',
                          textTwo: '${treatmentData.price}€',
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
                        Text(
                          '${treatmentData.desc ?? 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: AppColors.GREY_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
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
