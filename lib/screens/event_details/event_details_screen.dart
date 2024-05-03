// ignore_for_file: public_member_api_docs, sort_constructors_first, no_leading_underscores_for_local_identifiers, unused_element, avoid_print
import 'dart:async';

import 'package:atherium_saloon_app/screens/event_details/event_details_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/utils/date_utils.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/map_utils.dart';
import '../../widgets/text_row_widget.dart';

class EventDetailsScreen extends StatelessWidget {
  final controller = Get.put(EventDetailsControlelr());

  EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("start time:${Get.arguments.startTimeStamp}:endTime:${Get.arguments.endTimeStamp}");

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Completer<GoogleMapController> controller0 =
        Completer<GoogleMapController>();

    CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(controller.args.latitude, controller.args.longitude),
      zoom: 20.0,
    );

    CameraPosition kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(controller.args.latitude, controller.args.longitude),
        tilt: 29.440717697143555,
        zoom: 20.151926040649414);
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
    // ignore: unused_local_variable, prefer_const_constructors
    LatLng center = LatLng(45.52307386080499, 10.2587832779112);
    Future<void> _goToTheLake() async {
      final GoogleMapController controller = await controller0.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(kLake));
    }

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
              onTap: () => controller.handleBack(context),
              child: Container(
                alignment: Alignment.center,
                width: 25.0,
                height: 25.0,
                child: SvgPicture.asset(AppAssets.BACK_ARROW,
                    height: 14.0, width: 14.0),
              ),
            ),
            const SizedBox(width: 12.0),
            Text(controller.args.title,
                style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: !isDark
                          ? AppColors.BACKGROUND_COLOR
                          : AppColors.PRIMARY_DARK,
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
                        Stack(
                          children: [
                            SizedBox(
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
                            // Positioned(
                            //   top: 9.0,
                            //   right: 11.0,
                            //   child: Obx(
                            //     () => GestureDetector(
                            //       onTap: controller.setFavorite,
                            //       child: Icon(
                            //         controller.isfavorite.value
                            //             ? Icons.favorite
                            //             : Icons.favorite_border,
                            //         color: AppColors.WHITE_COLOR,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        TextRowWidget(
                          textOne: '${tr('date')}:',
                          textTwo: '${tr('location')}:',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                  color: isDark
                                      ? AppColors.WHITE_COLOR
                                      : AppColors.SECONDARY_COLOR),
                        ),
                        const SizedBox(height: 10.0),
                        TextRowWidget(
                          textOne: Get.arguments.dateString,
                          textTwo: Get.arguments.address,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: isDark
                                ? AppColors.GREY_COLOR
                                : AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextRowWidget(
                          textOne: '${tr('start_time')}:',
                          textTwo: '${tr('end_time')}:',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                color: isDark
                                    ? AppColors.WHITE_COLOR
                                    : AppColors.SECONDARY_COLOR,
                              ),
                        ),
                        const SizedBox(height: 10.0),
                        TextRowWidget(
                          textOne: Utils().formatTimestamp(Get.arguments.startTimeStamp),
                          textTwo: Utils().formatTimestamp(Get.arguments.endTimeStamp),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: isDark
                                ? AppColors.GREY_COLOR
                                : AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextRowWidget(
                          textOne: '${tr('duration')}:',
                          textTwo: '',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                color: isDark
                                    ? AppColors.WHITE_COLOR
                                    : AppColors.SECONDARY_COLOR,
                              ),
                        ),
                        const SizedBox(height: 10.0),
                        TextRowWidget(
                          textOne: Utils().getTimeDifference(
                              Get.arguments.startTimeStamp,
                              Get.arguments.endTimeStamp),
                          // Get.arguments.durationString,
                          textTwo: '',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: isDark
                                ? AppColors.GREY_COLOR
                                : AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          '${tr('description')}:',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                color: isDark
                                    ? AppColors.WHITE_COLOR
                                    : AppColors.SECONDARY_COLOR,
                              ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          Get.arguments.desc,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: isDark
                                ? AppColors.GREY_COLOR
                                : AppColors.BLACK_COLOR,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () {
                            print('hello');
                          },
                          child: SizedBox(
                            height: 250.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: GoogleMap(
                                onTap: (argument) {
                                  MapUtils.openMap(
                                      argument.latitude, argument.longitude);
                                },
                                initialCameraPosition: kGooglePlex,
                                mapType: MapType.hybrid,
                                onMapCreated: (GoogleMapController controller) {
                                  controller0.complete(controller);
                                },
                                markers: markers.values.toSet(),
                              ),
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
