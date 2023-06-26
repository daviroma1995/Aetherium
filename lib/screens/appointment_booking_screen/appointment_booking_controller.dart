import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:atherium_saloon_app/models/client.dart';
import 'package:atherium_saloon_app/models/employee.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/appointment_status.dart';
import '../../models/timeslot.dart';
import '../../models/treatment.dart';
import '../../utils/constants.dart';
import '../appointment_confirm_detail_screen/appointment_confirm_detail_screen.dart';

int monthIndex = DateTime.now().month;

class AppointMentBookingController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool calenderState = true.obs;
  RxBool hideTodayController = true.obs;
  RxBool shouldReset = false.obs;
  var args = Get.arguments;
  var employees = <Employee>[].obs;
  var treatments = <Treatment>[].obs;
  var selectedTreatements = <Treatment>[];
  var currentUser = Client().obs;
  RxBool isAdmin = false.obs;
  TextEditingController notes = TextEditingController();
  var avaliableSlots = <String>[].obs;
  var slotdata = <Timeslot>[];
  var selectedTreatmentsMap = <Map<String, dynamic>>[];
  RxString selectedDate = DateFormat('MM/dd/yyyy').format(DateTime.now()).obs;
  var selectedEmloyees = <String>[].obs;
  var appointmentStatusList = <AppointmentStatus>[].obs;
  var statusLabels = <String>[].obs;
  var initialDate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 0, 0, 0, 0, 0)
      .obs;
  @override
  void onInit() async {
    isLoading.value = true;
    initialDate.value = args.dateTimestamp != null ? args.dateTimestamp.toDate() : initialDate.value;
    selectedDate.value = args.dateTimestamp != null? DateFormat('MM/dd/yyyy').format(args.dateTimestamp.toDate()) : selectedDate.value; 
    args.notes = args.notes ?? '';
    notes.text = args.notes;
    args.isRegular = args.isRegular ?? true;
    treatments.bindStream(FirebaseServices.treatments());
    var selectedEmployeeQuery = await FirebaseFirestore.instance
        .collection('employees')
        .where('treatment_id_list', arrayContainsAny: args.serviceId)
        .get();
    for (var element in selectedEmployeeQuery.docs) {
      selectedEmloyees.add(element.id);
      var data = element.data();
      data['id'] = element.id;
      employees.add(Employee.fromJson(data));
    }
    args.employeeId = selectedEmloyees;
    var data = await FirebaseServices.getDataWhere(
        collection: 'clients',
        value: LoginController.instance.user?.uid ?? '',
        key: 'user_id');
    currentUser.value = Client.fromJson(data!);
    for (int i = 0; i < args.serviceId.length; i++) {
      var data = await FirebaseFirestore.instance
          .collection('treatments')
          .doc(args.serviceId[i])
          .get();
      var map = data.data()!;
      map['id'] = data.id;
      selectedTreatmentsMap.add(map);
    }

    await loadTimeslots(
        treatments: selectedTreatmentsMap, appointmentDate: selectedDate.value);
    if (currentUser.value.isAdmin == true) {
      isAdmin.value = true;
    }
    await loadStatues();
    for (var status in appointmentStatusList) {
      statusLabels.add(status.label!.capitalize ?? '');
    }

    args.dateTimestamp = args.dateTimestamp ??
        Timestamp.fromDate(DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 0, 0, 0, 0, 0));
    args.time = args.time == null
        ? avaliableSlots.isNotEmpty
            ? avaliableSlots[0]
            : null
        : avaliableSlots.isNotEmpty ? avaliableSlots[0] :null ;
    args.statusId = '88aa7cf3-c6b6-4cab-91eb-247aa6445a0a';
    args.date = selectedDate.value;
    isLoading.value = false;
    args.roomId = args.roomId ?? slotdata[0].roomIdList;
    args.startTime = args.startTime ?? slotdata[0].startTime;
    args.endTime = args.endTime ?? slotdata[0].endTime;
    super.onInit();

  }

  double totalPrice = 0.0;
  Rx<DateTime> date = DateTime.now().obs;

  RxInt selectedSlot = 0.obs;
  void changeDate(DateTime newDate) {
    date.value = newDate;
    update();
  }

  void selectSlot(int index) {
    selectedSlot.value = index;
    args.time = avaliableSlots[index];
    args.startTime = slotdata[index].startTime;
    args.endTime = slotdata[index].endTime;
    args.roomId = slotdata[index].roomIdList;
  }

  void next() {
    selectedTreatements = <Treatment>[];
    if (avaliableSlots.isEmpty) {
      Fluttertoast.showToast(
          msg: 'No timeslot selected select a timeslot first');
    } else {
      DateTime time = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 0, 0, 0, 0, 0);
      args.dateTimestamp ??= Timestamp.fromDate(time);

      args.serviceId.forEach((service) {
        log('Called');
        for (int index = 0; index < treatments.length; index++) {
          if (treatments[index].name == service ||
              treatments[index].id == service) {
            selectedTreatements.add(treatments[index]);
          }
        }
      });
      Get.to(
        AppointmentConfirmDetailScreen(
          isDetail: false,
          isEditable: false,
          services: selectedTreatements,
        ),
        duration: const Duration(milliseconds: 600),
        transition: Transition.downToUp,
        arguments: args,
      );
    }
  }

  Future<void> loadTimeslots(
      {required List<Map<String, dynamic>> treatments,
      required String appointmentDate}) async {
    isLoading.value = true;
    // print(json.encode({"date": appointmentDate, "treatments": treatments}));

    slotdata = <Timeslot>[];
    avaliableSlots.value = <String>[];
    var client = http.Client();
    var url = Uri.parse(
        "https://us-central1-aetherium-salon.cloudfunctions.net/timeslots");
    try {
      var response = await client.post(url,
          body:
              json.encode({"date": appointmentDate, "treatments": treatments}));
      var responseBody = response.body;
      var resList = json.decode(responseBody);
      for (var data in resList) {
        var startTime = data['start_time'];
        var date = DateTime.parse(startTime);
        var time = DateFormat("HH:mm").format(date);
        avaliableSlots.add(time);
        slotdata.add(Timeslot.fromJson(data));
      }
      if (avaliableSlots.isEmpty) {
        Fluttertoast.showToast(
            msg: 'No slots availabel select another date',
            backgroundColor: AppColors.ERROR_COLOR);
      }
    } catch (ex) {
      log(ex.toString());
    }
    isLoading.value = false;
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

  void back(){            
      // args.dateTimestamp = null;
      // initialDate.value = DateTime(DateTime.now().year, DateTime.now().month,
      // DateTime.now().day, 0, 0, 0, 0, 0);
      calenderState.value = !calenderState.value;
      Get.back();
    
  }
}
