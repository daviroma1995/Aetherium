import 'dart:developer';

import 'package:atherium_saloon_app/models/appointment.dart';
import 'package:atherium_saloon_app/models/client.dart';
import 'package:atherium_saloon_app/models/treatment_category.dart';
import 'package:atherium_saloon_app/network_utils/firebase_messaging.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/agenda_screen/agenda_controller.dart';
import 'package:atherium_saloon_app/screens/appointment_details/appointment_details.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../agenda_screen/agenda_screen.dart';
import '../loyality_card_screen/loyality_card_screen.dart';
import '../profile_screen/profile_screen.dart';

class BottomNavigationController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxString buttonText = '+'.obs;
  var client = Client().obs;
  RxBool toggle = false.obs;
  RxInt bottom = 25.obs;
  RxDouble leftRight = (Get.width / 2 - 25).obs;
  late final AnimationController rightButtonController;
  late final AnimationController leftButtonController;
  var treatmentCategories = <TreatmentCategory>[].obs;
  @override
  void onInit() async {
    super.onInit();
    await FirebaseMessaging.instance.requestPermission(
      badge: true,
      alert: true,
      provisional: true,
      sound: true,
      criticalAlert: true,
      announcement: true,
    );
    if (FirebaseAuth.instance.currentUser != null) {
      var data = await FirebaseServices.getDataWhere(
          collection: 'clients', key: 'user_id', value: FirebaseServices.cuid);
      client.value = Client.fromJson(data ?? {});
    }

    await NotificationsSubscription.fcmSubscribe(topicId: client.value.userId!);
<<<<<<< HEAD
=======
    if (client.value.isAdmin == false) {
      await NotificationsSubscription.fcmSubscribe(topicId: 'client');
    }
    if (client.value.isAdmin == true) {
      await NotificationsSubscription.fcmSubscribe(topicId: 'admin');
    }
>>>>>>> a7b79b91bb16a5abae7fea901dc01f535a0ebb5e

    await initMessaging();
  }

  @override
  void onClose() {
    super.onClose();
    rightButtonController.dispose();
    leftButtonController.dispose();
  }

  final screens = [
    // HomeScreen(),
    AgendaScreen(),
    LoyalityCardScreen(),
    ProfileScreen(),
  ];
  final PageController pageController = PageController(initialPage: 0);
  void changeTab(int index) {
    // if (index == 1) {

    // }
    if (index == 3) {
      currentIndex.value = 2;
      pageController.animateToPage(2,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else if (index == 4) {
      pageController.animateToPage(3,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      currentIndex.value = index;
    }
  }

  void reverse() {
    rightButtonController.reverse();
    leftButtonController.reverse();
    toggle.value = false;
  }

  void forward() {
    rightButtonController.forward();
    leftButtonController.forward();
    toggle.value = true;
  }

  Future<void> initMessaging() async {
    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    HomeScreenController controller = Get.find();
    AgendaController agendaController = Get.find();
    await controller.loadAppointments();
    agendaController.loadData();
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        log(message.data.toString());
        var appointmentId = message.data['appointmentId'];
        log(appointmentId);
        Appointment appointment;
        var instance = FirebaseFirestore.instance;
        var documentSnapshot =
            await instance.collection('appointments').doc(appointmentId).get();
        var data = documentSnapshot.data();
        appointment = Appointment.fromJson(data!);
        Get.to(
          () => AppointmentDetailsScreen(
            appointment: appointment,
            isAdmin: controller.currentUser.value.isAdmin!,
            isDetail: true,
          ),
        );
      }
    });

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('Notification message::: ${message.toString()}');
      HomeScreenController controller = Get.find();
      AgendaController agendaController = Get.find();
      agendaController.loadData();
      controller.loadHomeScreen();
      // var data = NotificationModel.fromMap(message.data);
      // log(data.toString());
      var appointmentId = message.data['appointmentId'];
      log(appointmentId);

      NotificationsSubscription.showDefualtLocalNotification(message);
    });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
        HomeScreenController controller = Get.find();
        AgendaController agendaController = Get.find();
        await controller.loadHomeScreen();
        await agendaController.loadData().then(
          (value) async {
            var appointmentId = message.data['appointmentId'];
            Appointment appointment;
            var instance = FirebaseFirestore.instance;
            var documentSnapshot = await instance
                .collection('appointments')
                .doc(appointmentId)
                .get();
            var data = documentSnapshot.data();
            appointment = Appointment.fromJson(data!);
            Get.to(
              () => AppointmentDetailsScreen(
                appointment: appointment,
                isAdmin: controller.currentUser.value.isAdmin!,
                isDetail: true,
              ),
            );
          },
        );
      },
    );
  }
}
