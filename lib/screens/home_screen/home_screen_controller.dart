import 'package:atherium_saloon_app/network_utils/network_service.dart';
import 'package:atherium_saloon_app/screens/appointments_screen/appointments_screen.dart';
import 'package:atherium_saloon_app/screens/services_screen/services_controller.dart'
    as appointments;
import 'package:atherium_saloon_app/screens/services_screen/services_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/event.dart';
import '../../utils/constants.dart';
import '../appointment_confirm_detail_screen/appointment_confirm_detail_screen.dart';
import '../event_details/event_details_screen.dart';

class HomeScreenController extends GetxController {
  RxInt searchServicesLength = 0.obs;
  RxBool isVisible = true.obs;
  RxBool isInitialized = false.obs;
  RxBool shoueldReload = false.obs;
  var events = <Event>[].obs;
  var searchedService = "".obs;
  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var prefs = await SharedPreferences.getInstance();
      loadEvents();
      isInitialized.value = true;
      prefs.setBool('isLogedIn', true);
    });
  }

  void loadEvents() async {
    events.value = await NetworkService.getEventsList();
    print(events[0].isFavorite);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
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
    events[index].isFavorite = !events[index].isFavorite!;
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

  void eventNavigation(int index) async {
    final result = await Get.to(
      () => EventDetailsScreen(),
      arguments: events[index],
      transition: Transition.downToUp,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInCubic,
    );
    if (result != null) {
      events[index].isFavorite = result;
      if (shoueldReload.value == true) {
        shoueldReload.value = false;
      } else {
        shoueldReload.value = true;
      }
    }
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

// TODO  Fake data will me removed soon

List services = [
  {
    'service_title': 'Textured Skin',
    'service_image': AppAssets.MIRROR_ICON,
    'dark_image': AppAssets.DARK_MIRROR_ICON,
  },
  {
    'service_title': 'Hair',
    'service_image': AppAssets.HAIR_ICON,
    'dark_image': AppAssets.DARK_HAIR_ICON,
  },
  {
    'service_title': 'Porcelain',
    'service_image': AppAssets.PORCELAIN_ICON,
    'dark_image': AppAssets.DARK_PORCELAIN_ICON,
  },
  {
    'service_title': 'Emergent',
    'service_image': AppAssets.EMERGENT_ICON,
    'dark_image': AppAssets.DARK_EMERGENT_ICON,
  },
];

class Appointment {
  final String userName;
  final String subTitle;
  final String imageUrl;
  final String time;
  final String date;
  Appointment({
    required this.userName,
    required this.subTitle,
    required this.imageUrl,
    required this.time,
    required this.date,
  });
}

List upcomingAppointments = [
  Appointment(
    userName: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    imageUrl: AppAssets.PROFILE_IMAGE_ONE,
    time: '8:02 AM',
    date: '06/02/2022',
  ),
  Appointment(
    userName: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    imageUrl: AppAssets.PROFILE_IMAGE_TWO,
    time: '8:02 AM',
    date: '06/02/2022',
  ),
  Appointment(
    userName: 'Ruth Okazaki',
    subTitle: 'Fragrances & Perfumes',
    imageUrl: AppAssets.PROFILE_IMAGE_TWO,
    time: '8:02 AM',
    date: '06/02/2022',
  ),
];

class Events {
  final String imageUrl;
  final String title;
  final String subTitle;
  final String date;

  RxBool isFavorite;
  Events({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.isFavorite,
  });
}

List<Events> events = [
  Events(
    imageUrl: AppAssets.EVENT_IMAGE_ONE,
    title: 'Flourish Essentials',
    subTitle: 'Fragrances & Perfumes',
    date: '06/02/2022',
    isFavorite: false.obs,
  ),
  Events(
    imageUrl: AppAssets.EVENT_IMAGE_TWO,
    title: 'Embrace Skincare',
    subTitle: 'Fragrances & Perfumes',
    date: '06/02/2022',
    isFavorite: false.obs,
  ),
  Events(
    imageUrl: AppAssets.EVENT_IMAGE_THREE,
    title: 'Flourish Essentials',
    subTitle: 'Fragrances & Perfumes',
    date: '06/02/2022',
    isFavorite: false.obs,
  ),
];

enum Status {
  canceled,
  archived,
  noshow,
  confirmed,
}

class Agenda {
  final String startTime;
  final String endTime;
  final String duration;
  final String userName;
  final String service;
  final String iamgeUrl;
  final Status status;
  Agenda({
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.userName,
    required this.service,
    required this.iamgeUrl,
    required this.status,
  });

  Color get color {
    switch (status) {
      case (Status.archived):
        return AppColors.ARCHIVED_COLOR;
      case (Status.canceled):
        return AppColors.CANCELED_COLOR;
      case (Status.confirmed):
        return AppColors.CONFIRMED_COLOR;
      case (Status.noshow):
        return AppColors.NO_SHOW_COLOR;
    }
  }

  Color get darkolor {
    switch (status) {
      case (Status.archived):
        return AppColors.DARK_ARCHIVED_COLOR;
      case (Status.canceled):
        return AppColors.DARK_CANCELED_COLOR;
      case (Status.confirmed):
        return AppColors.DARK_CONFIRMED_COLOR;
      case (Status.noshow):
        return AppColors.DARK_NO_SHOW_COLOR;
    }
  }
}

List<Agenda> agendas = [
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Flair Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: Status.canceled,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Finesse Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: Status.confirmed,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Nourish Petals',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: Status.noshow,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Flair Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: Status.archived,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Flair Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: Status.confirmed,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Flair Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: Status.noshow,
  ),
  Agenda(
    startTime: '8:00 AM',
    endTime: '8:30 Am',
    duration: '30 Mints',
    userName: 'Savannah Nguyen',
    service: 'Flair Cosmetics',
    iamgeUrl: AppAssets.USER_IMAGE,
    status: Status.canceled,
  ),
];

class LoyalityCard {
  final double totalPoints;
  final double gainedPoints;
  LoyalityCard({
    required this.totalPoints,
    required this.gainedPoints,
  });

  double get percentage {
    return gainedPoints / totalPoints;
  }
}

final loyalityCard = LoyalityCard(totalPoints: 300, gainedPoints: 126);
