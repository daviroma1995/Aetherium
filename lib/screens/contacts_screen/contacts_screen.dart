// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:atherium_saloon_app/utils/map_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/constants.dart';

import 'contacts_controller.dart';

class ContactsScreen extends StatelessWidget {
  final controller = Get.put(ContactsController());
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng _center = LatLng(37.43296265331129, -122.08832357078792);
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color:
                      isDark ? AppColors.PRIMARY_DARK : AppColors.WHITE_COLOR,
                  border: isDark
                      ? const Border()
                      : Border.all(color: AppColors.BORDER_COLOR, width: 1.3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 27.0, top: 37.0, right: 27.0, bottom: 37.0),
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
                                ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Email@example.com',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: AppColors.GREY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            AppLanguages.PHONE_NUMBER,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                '+984 124 54967',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.GREY_COLOR,
                                ),
                              ),
                              Container(
                                width: 102.0,
                                height: 26.0,
                                decoration: BoxDecoration(
                                  color: AppColors.GREEN_COLOR,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AppAssets.WHATSAPP_ICON),
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
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            AppLanguages.TIME,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            '8:00 AM - 8:30 AM',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: AppColors.GREY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            AppLanguages.OPENING_HOURS_OF_THE_SHOP,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 10.0),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: timeTable.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  openingHours(
                                      day: timeTable[index].day,
                                      from: timeTable[index].startTime,
                                      to: timeTable[index].endTim!),
                                  const SizedBox(height: 10.0),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            AppLanguages.DESCRIPTION,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            'Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.GREY_COLOR,
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
                                ),
                          ),
                          const SizedBox(height: 20.0),
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
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: beautySpecialist.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  specialistCard(
                                      imageUrl:
                                          beautySpecialist[index].imageUrl,
                                      title: beautySpecialist[index].name,
                                      subtitle:
                                          beautySpecialist[index].designation,
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
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.GREY_COLOR,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Row openingHours({required String day, String? from, required String to}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: AppColors.SECONDARY_COLOR,
          ),
        ),
        Text(
          from == null ? '$to' : '$from - $to',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: AppColors.GREY_COLOR,
          ),
        ),
      ],
    );
  }
}
