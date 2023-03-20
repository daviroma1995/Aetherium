// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/screens/event_details/event_details_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/text_row_widget.dart';

class EventDetailsScreen extends StatelessWidget {
  final controller = Get.put(EventDetailsControlelr());
  EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                    Text(
                      Get.arguments.title,
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
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
                      border: Border.all(color: AppColors.BORDER_COLOR)),
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 251.0,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: Get.arguments.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 9.0,
                              right: 11.0,
                              child: Obx(
                                () => GestureDetector(
                                  onTap: controller.setFavorite,
                                  child: Icon(
                                    Get.arguments.isFavorite.value
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: AppColors.WHITE_COLOR,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 19.0),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              border: Border.all(
                                  width: 1.3, color: AppColors.BORDER_COLOR),
                            ),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(AppAssets.USER_IMAGE),
                            ),
                          ),
                          title: Text(
                            'Ruth Okazaki',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.BLACK_COLOR),
                          ),
                          subtitle: Text(
                            'Fragrances & Perfumes',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.GREY_COLOR),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Image.asset(AppAssets.MAP_IMAGE),
                        const SizedBox(height: 16.0),
                        const TextRowWidget(
                          textOne: 'Date:',
                          textTwo: 'Location:',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextRowWidget(
                          textOne: Get.arguments.date,
                          textTwo: 'Online',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: AppColors.GREY_COLOR,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const TextRowWidget(
                          textOne: 'Start Time: ',
                          textTwo: 'End Time: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const TextRowWidget(
                          textOne: '6:00 AM',
                          textTwo: '6:30 AM',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: AppColors.GREY_COLOR,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const TextRowWidget(
                          textOne: 'Duration',
                          textTwo: '',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const TextRowWidget(
                          textOne: '30 Mints',
                          textTwo: '',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: AppColors.GREY_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Description: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: AppColors.BLACK_COLOR,
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
