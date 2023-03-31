import 'package:atherium_saloon_app/data.dart';
import 'package:atherium_saloon_app/screens/appointments_screen/appointments_screen.dart';
import 'package:atherium_saloon_app/screens/services_screen/services_controller.dart'
    as appointments;
import 'package:atherium_saloon_app/screens/services_screen/services_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../appointment_confirm_detail_screen/appointment_confirm_detail_screen.dart';
import '../event_details/event_details_screen.dart';

class HomeScreenController extends GetxController {
  RxInt searchServicesLength = 0.obs;
  RxBool isVisible = true.obs;
  var searchedService = "".obs;
  @override
  void onInit() async {
    super.onInit();
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogedIn', true);
  }

  void navigateToAppointmentDetail(int index) {
    Get.to(
      () => AppointmentConfirmDetailScreen(
        isDetail: true,
        isEditable: true,
      ),
      duration: const Duration(milliseconds: 600),
      transition: Transition.rightToLeft,
      arguments: <appointments.SubService>[
        appointments.SubService(title: 'Treatments', price: 30, time: '30 Min')
      ],
    );
  }

  final searchController = TextEditingController();
  void onChange(String value) {
    searchedService.value = value;
  }

  void onFocus() {
    isVisible.value = false;
    searchServicesLength.value = services.length;
  }

  void setFavorite(int index) {
    events[index].isFavorite.value = !events[index].isFavorite.value;
  }

  void navigateToServices() {
    Get.to(
      () => ServicesScreen(),
      duration: const Duration(milliseconds: 600),
      curve: Curves.linear,
      transition: Transition.rightToLeft,
    );
  }

  void navigateToAppointments() {
    Get.to(
      () => AppointmentsScreen(),
      duration: const Duration(milliseconds: 600),
      curve: Curves.linear,
      transition: Transition.rightToLeft,
    );
  }

  void serviceNavigation(int index) {
    Get.to(() => ServicesScreen(),
        arguments: index,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInCubic,
        transition: Transition.circularReveal);
  }

  void eventNavigation(int index) {
    Get.to(
      () => EventDetailsScreen(),
      arguments: events[index],
      transition: Transition.downToUp,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInCubic,
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List searchTerms;
  CustomSearchDelegate({
    required this.searchTerms,
  });
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List matchQuery = [];
    for (var services in searchTerms) {
      if (services['service_title']
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchQuery.add(services);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result['service_title'].toString()),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List matchQuery = [];
    for (var services in searchTerms) {
      if (services['service_title']
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchQuery.add(services);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result['service_title'].toString()),
        );
      },
    );
  }
}

List searchServices = [];
