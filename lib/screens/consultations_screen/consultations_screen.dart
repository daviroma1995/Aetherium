// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../widgets/custom_list_tile.dart';
import 'consultations_controller.dart';

class ConsultationsScreen extends StatelessWidget {
  final controller = Get.put(ConsultationsController());
  ConsultationsScreen({super.key});

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
                        child: SvgPicture.asset(AppAssets.BACK_ARROW)),
                    const SizedBox(width: 12.0),
                    const Text(
                      AppLanguages.CONSULTATIONS,
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
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 26.0),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: consultations.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.BORDER_COLOR),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListTile(
                              leading: SvgPicture.asset(AppAssets.PDF_ICON),
                              title: Text(consultations[index].title),
                              subtitle: Text(consultations[index].title),
                              trailing: SvgPicture.asset(
                                AppAssets.RIGHT_ARROW,
                                colorFilter: ColorFilter.mode(
                                    AppColors.GREY_COLOR, BlendMode.srcIn),
                              ),
                              onTap: () {},
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
