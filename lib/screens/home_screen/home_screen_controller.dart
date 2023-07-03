
import 'package:atherium_saloon_app/models/treatment_category.dart';
import 'package:atherium_saloon_app/screens/appointment_details/appointment_details.dart';
import 'package:atherium_saloon_app/screens/appointments_screen/appointments_screen.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';

import 'package:atherium_saloon_app/screens/services_screen/services_screen.dart';
import 'package:atherium_saloon_app/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/appointment.dart';
import '../../models/client.dart';
import '../../models/employee.dart';
import '../../models/event.dart';
import '../../models/treatment.dart';
import '../../network_utils/firebase_services.dart';
import '../event_details/event_details_screen.dart';
import '../../models/notification.dart' as notification;
import '../select_client_screen/select_client_screen.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt searchServicesLength = 0.obs;
  RxBool isVisible = true.obs;
  RxBool isInitialized = false.obs;
  RxBool shoueldReload = false.obs;
  var currentUser = Client().obs;
  late String _uid;
  var events = <Event>[].obs;
  var appointments = <Appointment>[].obs;
  var appointmentsEmployee = <Employee>[].obs;
  var notifications = <notification.Notification>[].obs;
  var services = <Treatment>[].obs;
  var treatmentCategories = <TreatmentCategory>[].obs;
  var searchedService = "".obs;
  var appointmentsTreatmentCategoryList =  <TreatmentCategory>[].obs;
  @override
  void onInit() async {

    super.onInit();
    await loadHomeScreen();
    
  }

  Future<void> loadHomeScreen() async{
    
    isLoading.value = true;
    _uid = FirebaseServices.cuid;
    treatmentCategories.value = await FirebaseServices.getTreatmentCategories();
    // log(treatmentCategories.toString());
    var map = await FirebaseServices.getCurrentUser();
    currentUser.value = Client.fromJson(map);

    appointmentsEmployee.bindStream(FirebaseServices.employeeStrem());
    notifications.bindStream(FirebaseServices.getUnreadNotficationsStream());
    events.bindStream(FirebaseServices.eventStream());

    isInitialized.value = true;
    LocalData.setIsLogedIn(true);
    loadAppointments();
    
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) async {},
    // );
    isLoading.value = false;
    
  }

  @override
  void onClose() {
    super.onClose();
    appointmentsEmployee.close();
    notifications.close();
    events.close();
  }
  
  void navigateToAppointmentDetail(int index) async {
    var data = await Get.to(
      () => AppointmentDetailsScreen(
          appointment: appointments[index], isEditable: true),
      duration: const Duration(milliseconds: 600),
      transition: Transition.rightToLeft,
      arguments: appointments[index].clientId,
    );
    if (data == true) {
      await loadHomeScreen();
    }
  }
  Future<void> loadAppointments() async{
    appointmentsTreatmentCategoryList.clear();
    var treatments = await FirebaseServices.getData(collection: 'treatments');
    var data = await FirebaseServices.getAppointments(
        isAdmin: currentUser.value.isAdmin!);
    appointments.value = data;
    for (var appointment in appointments) {
      for (int i = 0; i < treatments!.length; i++) {
        if (appointment.serviceId![0] == treatments[i]['id']) {
          services.add(Treatment.fromJson(treatments[i]));
        }
      }
    }
    for(var service in services){
      int treatmentCategoryIndex = treatmentCategories.indexWhere((element) => service.treatmentCategoryId == element.id);
      appointmentsTreatmentCategoryList.add(treatmentCategories[treatmentCategoryIndex]);
    }
  }
  final searchController = TextEditingController();
  void onChange(String value) {
    searchedService.value = value;
  }

  void onFocus() {
    isVisible.value = false;
    searchServicesLength.value = services.length;
  }

  void setFavorite(int index) async {
    if (events[index].isfavorite == true) {
      events[index].clientId!.removeWhere((element) => element == _uid);
    } else {
      events[index].clientId!.add(_uid);
    }
    FirebaseServices.toggleFavorite(
        eventId: events[index].eventId!, data: events[index]);
    events[index].isfavorite = !events[index].isfavorite!;
  }
  // Get Employee name

  String getEmployeeName(String id) {
    for (var employee in appointmentsEmployee) {
      if (employee.id == id) {
        return employee.name!;
      }
    }
    return 'No Name!';
  }

  String getServices(String id) {
    for (var treatments in services) {
      if (treatments.id == id) {
        return treatments.name!;
      }
    }
    return '';
  }

  void navigateToServices() {
    if (!currentUser.value.isAdmin!) {
      Get.to(
        () => const ServicesScreen(),
        duration: const Duration(milliseconds: 600),
        curve: Curves.linear,
        transition: Transition.rightToLeft,
      );
      return;
    }
    Get.to(
      () => SelectClientScreen(),
      duration: const Duration(milliseconds: 600),
      curve: Curves.linear,
      transition: Transition.rightToLeft,
    );
  }

  void navigateToAppointments() {
    Get.to(
      () => const AppointmentsScreen(),
      duration: const Duration(milliseconds: 600),
      curve: Curves.linear,
      transition: Transition.rightToLeft,
    );
  }

  void serviceNavigation(int index) {
    if (!currentUser.value.isAdmin!) {
      Get.to(() => const ServicesScreen(),
          arguments: index,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInCubic,
          transition: Transition.downToUp);
    } else {
      Get.to(() => SelectClientScreen(),
          arguments: index,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInCubic,
          transition: Transition.downToUp);
    }
  }

  void eventNavigation(int index) async {
    final result = await Get.to(
      () => EventDetailsScreen(),
      arguments: events[index],
      transition: Transition.downToUp,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInCubic,
    );
    if (result != null) {
      events[index].isfavorite = result;
      if (shoueldReload.value == true) {
        shoueldReload.value = false;
      } else {
        shoueldReload.value = true;
      }
    }
  }

  Future<void> onRefresh() async {
    _uid = FirebaseServices.cuid;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        var map = await FirebaseServices.getCurrentUser();
        currentUser.value = Client.fromJson(map);

        appointmentsEmployee.bindStream(FirebaseServices.employeeStrem());
        notifications
            .bindStream(FirebaseServices.getUnreadNotficationsStream());
        events.bindStream(FirebaseServices.eventStream());

        isInitialized.value = true;
        LocalData.setIsLogedIn(true);
        var treatments =
            await FirebaseServices.getData(collection: 'treatments');

        var data = await FirebaseServices.getAppointments(
            isAdmin: currentUser.value.isAdmin!);
        appointments.value = data;

        for (var appointment in appointments) {
          for (int i = 0; i < treatments!.length; i++) {
            if (appointment.serviceId![0] == treatments[i]['id']) {
              services.add(Treatment.fromJson(treatments[i]));
            }
          }
        }
      },
    );
  }
}

List searchServices = [];
