// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import '../appointment_booking_screen/appointment_booking_screen.dart';

class ServicesController extends GetxController {
  RxBool isExpanded = false.obs;
  void checkBoxController(int index) {
    fatFreezingServices[index].isSelected.value =
        !fatFreezingServices[index].isSelected.value;
  }

  void dropDownController() {
    isExpanded.value = !isExpanded.value;
  }

  void moveToAppointmentBookingScree() {
    Get.to(() => AppointmentBookingScreen());
  }
}

class SubService {
  final String title;
  final RxBool isSelected;
  SubService({
    required this.title,
    required this.isSelected,
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
    items: fatFreezingServices,
    isExtended: false.obs,
  ),
  Service(
    title: 'Lash Lift & Tint.',
    items: fatFreezingServices,
    isExtended: false.obs,
  ),
  Service(
    title: 'Chemical Peel',
    items: fatFreezingServices,
    isExtended: false.obs,
  ),
  Service(
    title: 'Lash Lift & Tint.wd',
    items: fatFreezingServices,
    isExtended: false.obs,
  ),
  Service(
    title: 'Fat Dissolving',
    items: fatFreezingServices,
    isExtended: false.obs,
  ),
  Service(
    title: 'Hair Removal',
    items: fatFreezingServices,
    isExtended: false.obs,
  ),
];
List<SubService> fatFreezingServices = [
  SubService(
    title: 'Treatment Products',
    isSelected: false.obs,
  ),
  SubService(
    title: 'Other Beauty & Care',
    isSelected: false.obs,
  ),
  SubService(
    title: 'Baby Care',
    isSelected: false.obs,
  ),
  SubService(
    title: 'Hair Care',
    isSelected: false.obs,
  ),
];
