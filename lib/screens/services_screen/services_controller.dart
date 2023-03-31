// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/screens/service_detail_screen/service_detail_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appointment_booking_screen/appointment_booking_screen.dart';

class ServicesController extends GetxController {
  // On Init
  // late int args;
  var args;
  @override
  void onClose() {
    super.onClose();

    if (args != null && args != 0) {
      var current = services[0];
      var prev = services[args];
      var temp = current;
      services[0] = prev;
      services[args] = temp;
      for (int i = 0; i < services.length; i++) {
        services[i].isExtended.value = false;
      }
    }
  }

  RxBool isExpanded = false.obs;
  void reArrange() {
    if (args == null) {
      return;
    } else {
      if (args == 0) {
        services[0].isExtended.value = true;
        reset();
      }
      if (args != 0) {
        final prevService = services[0];
        final currentService = services[args!];
        final temp = prevService;
        services[0] = currentService;
        services[0].isExtended.value = true;
        services[args!] = temp;
        reset();
      }
    }
  }

  void reset() {
    for (int i = 1; i < services.length; i++) {
      services[i].isExtended.value = false;
    }
  }

  void checkBoxController(int index) {
    subServices[index][index].isSelected!.value =
        !subServices[index][index].isSelected!.value;
  }

  void dropDownController() {
    isExpanded.value = !isExpanded.value;
  }

  void moveToAppointmentBookingScreen() {
    Get.to(
      () => AppointmentBookingScreen(),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInQuad,
      transition: Transition.rightToLeft,
      arguments: selectedServices,
    );
  }

  void serviceDetailController(int serviceIndex, int subServiceIndex) {
    Get.to(
      () => const ServiceDetailScreen(),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInQuad,
      transition: Transition.downToUp,
      arguments: {
        'title': services[serviceIndex].title,
        'service_title': services[serviceIndex].items[subServiceIndex].title,
        'duration': '8:00 AM - 8:30 AM',
        'time': services[serviceIndex].items[subServiceIndex].time,
        'price': services[serviceIndex].items[subServiceIndex].price,
        'desc':
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
        'imageUrl': AppAssets.MAKEUP_IMAGE
      },
    );
  }

  void selectedServiceController(int serviceIndex, int subServiceIndex) {
    if (selectedServices
        .where((element) =>
            element.title ==
            (services[serviceIndex].items[subServiceIndex].title))
        .isEmpty) {
      selectedServices.add(services[serviceIndex].items[subServiceIndex]);
    } else {
      selectedServices.removeWhere((element) =>
          element.title == services[serviceIndex].items[subServiceIndex].title);
    }
  }

  void searchService(String value) {
    print(value);
  }
}

final selectedServices = <SubService>[];

class SubService {
  final String title;
  final RxBool? isSelected;
  final double price;
  final String time;
  SubService({
    required this.title,
    this.isSelected,
    required this.price,
    required this.time,
  });
}

class Service {
  final String title;
  final List<SubService> items;
  final RxBool isExtended;

  Service({
    required this.title,
    required this.items,
    required this.isExtended,
  });
}

List<Service> services = [
  Service(
    title: 'Fat Freezing.',
    items: subServices[0],
    isExtended: false.obs,
  ),
  Service(
    title: 'Lash Lift & Tint.',
    items: subServices[1],
    isExtended: false.obs,
  ),
  Service(
    title: 'Chemical Peel',
    items: subServices[2],
    isExtended: false.obs,
  ),
  Service(
    title: 'Lash Lift & Tint.wd',
    items: subServices[3],
    isExtended: false.obs,
  ),
  Service(
    title: 'Fat Dissolving',
    items: subServices[4],
    isExtended: false.obs,
  ),
  Service(
    title: 'Hair Removal',
    items: subServices[5],
    isExtended: false.obs,
  ),
];
List<List<SubService>> subServices = [
  [
    SubService(
        title: 'Treatment Products',
        isSelected: false.obs,
        price: 30.0,
        time: '30 min'),
    SubService(
        title: 'Other Beauty & Care',
        isSelected: false.obs,
        price: 50.0,
        time: '40 min'),
    SubService(
        title: 'Baby Care', isSelected: false.obs, price: 45.0, time: '30 min'),
    SubService(
        title: 'Hair Care', isSelected: false.obs, price: 60.0, time: '40 min'),
  ],
  [
    SubService(
        title: 'Treatment', isSelected: false.obs, price: 30.0, time: '30 min'),
    SubService(
        title: 'Other Beauty',
        isSelected: false.obs,
        price: 50.0,
        time: '40 min'),
    SubService(
        title: 'Baby Care Treatment',
        isSelected: false.obs,
        price: 45.0,
        time: '30 min'),
    SubService(
        title: 'Hair Care Treatment',
        isSelected: false.obs,
        price: 60.0,
        time: '40 min'),
  ],
  [
    SubService(
        title: 'Freeckle Treatment',
        isSelected: false.obs,
        price: 45.0,
        time: '30 min'),
    SubService(
        title: 'Hair removel',
        isSelected: false.obs,
        price: 60.0,
        time: '40 min'),
  ],
  [
    SubService(
        title: 'Treatment services',
        isSelected: false.obs,
        price: 30.0,
        time: '30 min'),
    SubService(
        title: 'Other Beauty & care services',
        isSelected: false.obs,
        price: 110.0,
        time: '50 min'),
    SubService(
        title: 'Baby Care Service',
        isSelected: false.obs,
        price: 45.0,
        time: '30 min'),
    SubService(
        title: 'Hair Care Service',
        isSelected: false.obs,
        price: 60.0,
        time: '40 min'),
  ],
  [
    SubService(
        title: 'Genearl Treatment',
        isSelected: false.obs,
        price: 100.0,
        time: '30 min'),
  ],
  [
    SubService(
        title: 'Other Beauty & Care Products',
        isSelected: false.obs,
        price: 100.0,
        time: '40 min'),
  ],
];
