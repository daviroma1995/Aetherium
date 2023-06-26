import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../models/appointment.dart';
import '../../models/appointment_status.dart';

class UpdateAppointmentStatusController extends GetxController {
  var statusLabels = <String>[].obs;
  var appointmentStatusList = <AppointmentStatus>[].obs;

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
  }

  void updateStatus(Appointment appointment)async{
    try{
    await FirebaseFirestore.instance.collection('appointments').doc(appointment.id).set(appointment.toJson());
    Fluttertoast.showToast(msg: 'Status Updated');
    Get.back();
    Get.back(result: true);
    }
    catch(ex){
      log(ex.toString());
    }
  }
}
