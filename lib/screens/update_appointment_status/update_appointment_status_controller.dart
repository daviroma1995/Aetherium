import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../models/appointment.dart';
import '../../models/appointment_status.dart';

class UpdateAppointmentStatusController extends GetxController {
  RxBool isLoading = true.obs;
  var statusLabels = <String>[].obs;
  var appointmentStatusList = <AppointmentStatus>[].obs;
  String status = '';
  String previousStatus = '';

  TextEditingController notes = TextEditingController();
  @override
  void onInit() async {
    super.onInit();
    await loadStatues();
    for (var status in appointmentStatusList) {
      statusLabels.add(status.label!.capitalize ?? '');
    }
  }

  Future<void> loadStatues() async {
    var statusQuery =
        await FirebaseFirestore.instance.collection('appointment_status').get();
    var docs = statusQuery.docs;
    for (var doc in docs) {
      var data = doc.data();
      appointmentStatusList.add(AppointmentStatus.fromJson(data));
    }
    isLoading.value = false;
  }

  void updateStatus(Appointment appointment) async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointment.id)
          .set(appointment.toJson())
          .then((value) async {
        var snapshot = await FirebaseFirestore.instance
            .collection('client_memberships')
            .doc(appointment.clientId)
            .get();
        var data = snapshot.data();
        var points = data?['points'];
        if (status != '' &&
            status.toLowerCase() == 'archiviato' &&
            previousStatus.toLowerCase() != 'archiviato' &&
            points + 25 <= 300) {
          await FirebaseFirestore.instance
              .collection('client_memberships')
              .doc(appointment.clientId)
              .update(
            {
              "points": FieldValue.increment(25),
            },
          );
        } else if (previousStatus.toLowerCase() == 'archiviato' &&
            status.toLowerCase() != 'archiviato' &&
            points - 25 >= 0) {
          await FirebaseFirestore.instance
              .collection('client_memberships')
              .doc(appointment.clientId)
              .update(
            {
              "points": FieldValue.increment(-25),
            },
          );
        }
      });
      Fluttertoast.showToast(msg: 'Status Updated');
      Get.back();
      Get.back(result: true);
    } catch (ex) {
      log(ex.toString());
    }
  }

  String getStatus(Appointment appointment) {
    return appointmentStatusList
        .where((element) => element.id == appointment.statusId)
        .toList()[0]
        .label!;
  }
}
