// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:atherium_saloon_app/screens/full_screen_image/full_screen_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

import 'consultations_controller.dart';

class ConsultationsScreen extends StatelessWidget {
  final controller = Get.put(ConsultationsController());
  ConsultationsScreen({super.key});

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
              onTap: () => controller.handleBack(),
              child: Container(
                alignment: Alignment.center,
                width: 25.0,
                height: 25.0,
                child: SvgPicture.asset(AppAssets.BACK_ARROW,
                    height: 14.0, width: 14.0),
              ),
            ),
            const SizedBox(width: 12.0),
            Text(AppLanguages.CONSULTATIONS,
                style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 13.0),
              Obx(
                () => Visibility(
                    visible: controller.urls.isEmpty,
                    child: SizedBox(
                      height: 150.0,
                      width: Get.width,
                      child: const Center(child: CircularProgressIndicator()),
                    )),
              ),
              Obx(
                () => Visibility(
                  visible: controller.urls.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.urls.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Get.to(() => FullScreenImage(
                                  imageUrl: controller.urls[index]));
                            },
                            child: AbsorbPointer(
                              child: Container(
                                // clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    color: isDark
                                        ? AppColors.PRIMARY_DARK
                                        : AppColors.WHITE_COLOR,
                                    border: isDark
                                        ? const Border()
                                        : Border.all(
                                            color: AppColors.BORDER_COLOR),
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  // style: ListTileStyle.list,
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: SizedBox(
                                      height: 50.0,
                                      width: 50.0,
                                      child: CachedNetworkImage(
                                        width: 50.0,
                                        height: 50.0,
                                        fit: BoxFit.cover,
                                        imageUrl: controller.urls[index],
                                        errorWidget: (context, url, error) {
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Container(
                                              width: 40.0,
                                              height: 40.0,
                                              color: Colors.grey,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  title: Text('Consultation $index'),
                                  // subtitle: Text(consultations[index].title),
                                  trailing: SvgPicture.asset(
                                    AppAssets.RIGHT_ARROW,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.GREY_COLOR, BlendMode.srcIn),
                                  ),
                                  onTap: () {},
                                  splashColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Visibility(
                    visible: controller.isLoading.isFalse &&
                        controller.consultations.isEmpty,
                    child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: null,
                        child: const Text(
                          'No Consultations',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
