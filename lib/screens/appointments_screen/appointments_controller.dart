import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_screen.dart';
import 'package:atherium_saloon_app/screens/upcoming_appointments_screen/upcoming_appointments_screen.dart';

import 'package:get/get.dart';

import '../past_appointment_screen/past_appointment_screen.dart';
import '../services_screen/services_screen.dart';

class AppointmentsController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var myargs = Get.arguments;
  }

  void handleBack() {
    Get.back();
  }

  // TODO IMPLEMENT CONTROLLER
  RxBool isCurrentPast = true.obs;
  RxBool isCurrentUpcomming = false.obs;
  RxList screens = [
    PastAppointmentScreen(),
    UpcomingAppointmentsScreen(),
  ].obs;
  RxInt currentIndex = 0.obs;
  void onTap(int index) {
    if (index == 0) {
      isCurrentPast.value = true;
      isCurrentUpcomming.value = false;
      currentIndex.value = index;
    } else {
      isCurrentPast.value = false;
      isCurrentUpcomming.value = true;
      currentIndex.value = index;
    }
  }

  void createAppointment() {
    Get.to(() => ServicesScreen());
  }
}
