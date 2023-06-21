// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'dart:async';

import 'package:atherium_saloon_app/utils/map_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/constants.dart';

import 'contacts_controller.dart';

// ignore: must_be_immutable
class ContactsScreen extends StatelessWidget {
  final controller = Get.put(ContactsController());
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(45.52307386080499, 10.2587832779112),
    zoom: 20.0,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(45.52307386080499, 10.2587832779112),
      tilt: 29.440717697143555,
      zoom: 20.151926040649414);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  // ignore: prefer_final_fields, unused_field
  LatLng _center = LatLng(45.52307386080499, 10.2587832779112);
  // ignore: unused_element
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  ContactsScreen({super.key});

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
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                width: 25.0,
                height: 25.0,
                child: SvgPicture.asset(AppAssets.BACK_ARROW,
                    height: 14.0, width: 14.0),
              ),
            ),
            const SizedBox(width: 12.0),
            Text(AppLanguages.CONTACTS,
                style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
      body: Obx(
        () => SafeArea(
          child: controller.shopinfo.value.email == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.PRIMARY_DARK
                              : AppColors.WHITE_COLOR,
                          border: isDark
                              ? const Border()
                              : Border.all(
                                  color: AppColors.BORDER_COLOR, width: 1.3),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 27.0,
                                top: 37.0,
                                right: 27.0,
                                bottom: 37.0),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLanguages.EMAIL,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: isDark
                                              ? AppColors.WHITE_COLOR
                                              : AppColors.SECONDARY_COLOR,
                                        ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Obx(
                                    () => Text(
                                      controller.isInitialized.value == true
                                          ? controller.shopinfo.value.email!
                                          : '',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? AppColors.GREY_COLOR
                                            : AppColors.BLACK_COLOR,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30.0),
                                  Text(
                                    AppLanguages.PHONE_NUMBER,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: isDark
                                              ? AppColors.WHITE_COLOR
                                              : AppColors.SECONDARY_COLOR,
                                        ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.shopinfo.value.phoneNumber!,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: isDark
                                              ? AppColors.GREY_COLOR
                                              : AppColors.BLACK_COLOR,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.launchWhatsApp();
                                        },
                                        child: Container(
                                          width: 102.0,
                                          height: 26.0,
                                          decoration: BoxDecoration(
                                            color: AppColors.GREEN_COLOR,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  AppAssets.WHATSAPP_ICON),
                                              const SizedBox(width: 12.0),
                                              const Text(
                                                'WhatsApp',
                                                style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: AppColors.WHITE_COLOR,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30.0),
                                  Text(
                                    AppLanguages.OPENING_HOURS_OF_THE_SHOP,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: isDark
                                              ? AppColors.WHITE_COLOR
                                              : AppColors.SECONDARY_COLOR,
                                        ),
                                  ),
                                  const SizedBox(height: 30.0),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller
                                        .shopinfo.value.openingHours!.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          openingHours(
                                              isDark: isDark,
                                              day: controller.shopinfo.value
                                                  .openingHours![index].day!,
                                              from: controller
                                                  .shopinfo
                                                  .value
                                                  .openingHours![index]
                                                  .openingTime,
                                              to: controller
                                                  .shopinfo
                                                  .value
                                                  .openingHours![index]
                                                  .closingTime!),
                                          const SizedBox(height: 10.0),
                                        ],
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20.0),
                                  Text(
                                    AppLanguages.DESCRIPTION,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: isDark
                                              ? AppColors.WHITE_COLOR
                                              : AppColors.SECONDARY_COLOR,
                                        ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Text(
                                    'Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                      color: isDark
                                          ? AppColors.GREY_COLOR
                                          : AppColors.BLACK_COLOR,
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  GestureDetector(
                                    onTap: () {
                                      // ignore: avoid_print
                                      print('hello');
                                    },
                                    child: SizedBox(
                                      height: 250.0,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: GoogleMap(
                                          onTap: (argument) {
                                            MapUtils.openMap(argument.latitude,
                                                argument.longitude);
                                          },
                                          initialCameraPosition: _kGooglePlex,
                                          mapType: MapType.hybrid,
                                          onMapCreated:
                                              (GoogleMapController controller) {
                                            _controller.complete(controller);
                                          },
                                          markers: markers.values.toSet(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Text(
                                    AppLanguages.BEAUTY_SPECIALIST,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: isDark
                                              ? AppColors.WHITE_COLOR
                                              : AppColors.SECONDARY_COLOR,
                                        ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.beautySpecialists.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          specialistCard(
                                              imageUrl: beautySpecialist[index]
                                                  .imageUrl,
                                              title: controller
                                                  .beautySpecialists[index]
                                                  .name!,
                                              subtitle: beautySpecialist[index]
                                                  .designation,
                                              isDark: isDark),
                                          const SizedBox(height: 10.0),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
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

  Container specialistCard({
    required String title,
    required String subtitle,
    required String imageUrl,
    required bool isDark,
  }) {
    return Container(
      height: 82.0,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.BACKGROUND_DARK : AppColors.BACKGROUND_COLOR,
        border: isDark
            ? const Border()
            : Border.all(
                width: 1.0,
                color: AppColors.BORDER_COLOR,
              ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.3, color: AppColors.BORDER_COLOR),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage(imageUrl),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.WHITE_COLOR : AppColors.BLACK_COLOR,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.GREY_COLOR : AppColors.GREY_COLOR,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Row openingHours(
      {required String day,
      String? from,
      required String to,
      required bool isDark}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.SECONDARY_COLOR : AppColors.BLACK_COLOR,
          ),
        ),
        Text(
          // ignore: unnecessary_string_interpolations
          from == null ? '$to' : '$from - $to',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.GREY_COLOR : AppColors.BLACK_COLOR,
          ),
        ),
      ],
    );
  }
}
