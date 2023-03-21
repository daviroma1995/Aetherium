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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                    Text(AppLanguages.CONSULTATIONS,
                        style: Theme.of(context).textTheme.headlineLarge),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 22.0, vertical: 26.0),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: consultations.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.PRIMARY_DARK
                                : AppColors.WHITE_COLOR,
                            border: isDark
                                ? const Border()
                                : Border.all(color: AppColors.BORDER_COLOR),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          style: ListTileStyle.list,
                          leading: SvgPicture.asset(AppAssets.PDF_ICON),
                          title: Text(consultations[index].title),
                          subtitle: Text(consultations[index].title),
                          trailing: SvgPicture.asset(
                            AppAssets.RIGHT_ARROW,
                            colorFilter: const ColorFilter.mode(
                                AppColors.GREY_COLOR, BlendMode.srcIn),
                          ),
                          onTap: () {},
                          splashColor: Colors.transparent,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
