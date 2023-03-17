import 'package:atherium_saloon_app/screens/services_screen/services_screen.dart';
import 'package:get/get.dart';

class UpcomingAppointmentsController extends GetxController {
  // TODO
  void createAppointment() {
    Get.to(() => ServicesScreen());
  }
}

List upcomingAppointments = [];
