import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:atherium_saloon_app/models/appointment.dart';
import 'package:atherium_saloon_app/models/client.dart';
import 'package:atherium_saloon_app/models/employee.dart';
import 'package:atherium_saloon_app/models/shop_info.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/appointment_status.dart';
import '../../models/timeslot.dart';
import '../../models/treatment.dart';
import '../../utils/constants.dart';
import '../appointment_confirm_detail_screen/appointment_confirm_detail_screen.dart';

int monthIndex = DateTime.now().month;

class AppointMentBookingController extends GetxController {
  AppointMentBookingController({this.isEditing});
  var shopinfo = ShopInfo().obs;
  bool? isEditing = false;
  RxBool isLoading = false.obs;
  RxBool calenderState = true.obs;
  RxBool hideTodayController = true.obs;
  RxBool shouldReset = false.obs;
  RxBool isExpaned = false.obs;
  RxBool employeesLoaded = false.obs;
  var args = Get.arguments;
  var employees = <Employee>[].obs;
  var filteredEmployees = <Employee>[].obs;
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
          (DateTime.now().day), 0, 0, 0, 0, 0)
      .obs;
  String dateString = '';
  String timeString = '';
  Appointment appointment = Appointment();
  String previousStatus = '';
  String selectedStatus = '';
  DateTime selectedDateTime = DateTime.now();
  late String openingTime;
  late String closingTime;
  String closingHours = '';
  @override
  void onInit() async {
    var shopInfoQuery =
        await FirebaseFirestore.instance.collection('shop_info').get();
    var queryDoc = shopInfoQuery.docs.first;
    var shopInfoMap = queryDoc.data();
    shopinfo.value = ShopInfo.fromJson(shopInfoMap);
    isLoading.value = true;
    openingTime =
        shopinfo.value.openingHours?[DateTime.now().weekday - 1].openingTime ??
            '';
    closingTime =
        shopinfo.value.openingHours?[DateTime.now().weekday - 1].closingTime ??
            '';
    int index = closingTime.indexOf(':');

    if (index == 2) {
      closingHours = '${closingTime[0]}${closingTime[1]}';
    }
    if (initialDate.value.weekday == 7) {
      initialDate.value = DateTime(
          DateTime.now().year, DateTime.now().month, (DateTime.now().day + 1));
      calenderState.value = !calenderState.value;
    } else if (args.dateTimestamp != null) {
      DateTime date = args.dateTimestamp.toDate();
      if (date.day < DateTime.now().day ||
          date.month < DateTime.now().month ||
          date.year < DateTime.now().year) {
        initialDate.value = initialDate.value;
        selectedDate.value = selectedDate.value;
      } else {
        initialDate.value = date;
        selectedDate.value =
            DateFormat('MM/dd/yyyy').format(args.dateTimestamp.toDate());
      }
    } else {
      if (int.tryParse(closingHours)! < DateTime.now().hour) {
        initialDate.value = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
        calenderState.value = !calenderState.value;
        print('done');
      }
    }
    // initialDate.value = args.dateTimestamp != null
    //     ? args.dateTimestamp.toDate()
    //     : initialDate.value;
    // selectedDate.value = args.dateTimestamp != null
    //     ? DateFormat('MM/dd/yyyy').format(args.dateTimestamp.toDate())
    //     : selectedDate.value;
    args.notes = args.notes ?? '';
    notes.text = args.notes;
    args.isRegular = args.isRegular ?? true;
    treatments.bindStream(FirebaseServices.treatments());
    var selectedEmployeeQuery =
        await FirebaseFirestore.instance.collection('employees').get();
    for (var element in selectedEmployeeQuery.docs) {
      selectedEmloyees.add(element.id);
      var data = element.data();
      data['id'] = element.id;
      employees.add(Employee.fromJson(data));
    }
    args.employeeId = selectedEmloyees;
    var data = await FirebaseServices.getDataWhere(
        collection: 'clients', value: FirebaseServices.cuid, key: 'user_id');
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

    // if (args.dateTimestamp != null) {
    //   if (args.dateTimestamp.toDate().day >= DateTime.now().day &&
    //       args.dateTimestamp.toDate().month >= DateTime.now().month &&
    //       args.dateTimestamp.toDate().year >= DateTime.now().year) {
    //     await loadTimeslots(
    //         treatments: selectedTreatmentsMap,
    //         appointmentDate: selectedDate.value);
    //   }
    // } else {
    await loadTimeslots(
        treatments: selectedTreatmentsMap, appointmentDate: selectedDate.value);
    // }
    if (currentUser.value.isAdmin == true) {
      isAdmin.value = true;
    }
    await loadStatues();
    for (var status in appointmentStatusList) {
      statusLabels.add(status.label!.capitalize ?? '');
    }

    args.dateTimestamp = args.dateTimestamp ??
        Timestamp.fromDate(DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 0, 0, 0, 0, 0)
            .toLocal());
    args.time = args.time == null
        ? avaliableSlots.isNotEmpty
            ? avaliableSlots[0]
            : null
        : avaliableSlots.isNotEmpty
            ? avaliableSlots[0]
            : null;
    args.statusId = args.statusId ?? '88aa7cf3-c6b6-4cab-91eb-247aa6445a0a';
    args.date = selectedDate.value;
    isLoading.value = false;
    if (slotdata.isNotEmpty) {
      args.roomId = args.roomId ?? slotdata[0].roomIdList;
      args.startTime = args.startTime ?? slotdata[0].startTime;
      args.endTime = args.endTime ?? slotdata[0].endTime;
    } else {
      args.roomId = null;
      args.startTime = null;
      args.endTime = null;
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    treatments.close();
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
    print(args.time);
    args.startTime = slotdata[index].startTime;
    args.endTime = slotdata[index].endTime;
    args.roomId = slotdata[index].roomIdList;
  }

  void next() {
    if (args.dateTimestamp != null) {
      if (args.dateTimestamp.toDate().day < DateTime.now().day ||
          args.dateTimestamp.toDate().month < DateTime.now().month ||
          args.dateTimestamp.toDate().year < DateTime.now().year) {
        Fluttertoast.showToast(msg: tr('appointment_past'));
        return;
      }
    }
    selectedTreatements = <Treatment>[];
    if (selectedDateTime.day < DateTime.now().day ||
        selectedDateTime.month < DateTime.now().month ||
        selectedDateTime.year < DateTime.now().year) {
      Fluttertoast.showToast(msg: tr('appointment_past'));
      return;
    } else if (avaliableSlots.isEmpty) {
      Fluttertoast.showToast(
          msg: tr('no_timeslot_selected'),
          backgroundColor: AppColors.ERROR_COLOR);
    } else {
      DateTime time = DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 0, 0, 0, 0, 0)
          .toLocal();
      args.dateTimestamp ??= Timestamp.fromDate(time);
      print('${args.dateTimestamp.toDate()} : date');
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
        () => AppointmentConfirmDetailScreen(
          isDetail: false,
          isEditable: false,
          services: selectedTreatements,
          selectedStatus: selectedStatus,
          previousStatus: previousStatus,
        ),
        duration: const Duration(milliseconds: 600),
        transition: Platform.isIOS ? null : Transition.downToUp,
        arguments: args,
      );
    }
  }

  Future<void> loadTimeslots(
      {required List<Map<String, dynamic>> treatments,
      required String appointmentDate}) async {
    isLoading.value = true;
    // print(json.encode({"date": appointmentDate, "treatments": treatments}));
    print(isEditing);
    if (isEditing ?? false) {
      print(args.id);
    }
    slotdata = <Timeslot>[];
    avaliableSlots.value = <String>[];
    filteredEmployees.value = <Employee>[];
    var client = http.Client();
    var url = Uri.parse(
        "https://us-central1-aetherium-salon.cloudfunctions.net/timeslots");
    try {
      var response = await client.post(url,
          body: isEditing ?? false
              ? json.encode({
                  "date": appointmentDate,
                  "treatments": treatments,
                  "appointment_id": args.id
                })
              : json
                  .encode({"date": appointmentDate, "treatments": treatments}));
      var responseBody = response.body;
      // print(responseBody);
      var resList = json.decode(responseBody);

      for (var data in resList) {
        var startTime = data['start_time'];
        var date = DateTime.parse(startTime);
        var time = DateFormat("HH:mm").format(date);
        avaliableSlots.add(time);
        slotdata.add(Timeslot.fromJson(data));
      }

      var listOFEmployeeId = slotdata[0].employeeIdList;
      if (listOFEmployeeId!.isNotEmpty) {
        for (var id in listOFEmployeeId) {
          var data = await FirebaseFirestore.instance
              .collection('employees')
              .doc(id)
              .get();
          var snapshot = data.data();

          filteredEmployees.add(Employee.fromJson(snapshot!));
        }
      }
      args.employeeId = slotdata[0].employeeIdList;
      employeesLoaded.value = true;

      // for (var item in resList) {
      //   if (filteredEmployees.contains(item)) {
      //     continue;
      //   } else {
      //     filteredEmployees.add(employees
      //         .firstWhere((value) => value.id == item['employee_id_list']));
      //   }
      // }
      // args.employeId = resList[0]['employee_id_list'].isEmpty ?? [];
      if (avaliableSlots.isEmpty) {
        Fluttertoast.showToast(
            msg: tr('no_time_slots'), backgroundColor: AppColors.ERROR_COLOR);
      } else {
        args.time = avaliableSlots[0];
        args.startTime = slotdata[0].startTime;
        args.endTime = slotdata[0].endTime;
        args.roomId = slotdata[0].roomIdList;
      }
    } catch (ex) {
      log(ex.toString());

      Fluttertoast.showToast(
          msg: tr('no_time_slots'), backgroundColor: AppColors.ERROR_COLOR);
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

  void back() {
    // args.dateTimestamp = null;
    // initialDate.value = DateTime(DateTime.now().year, DateTime.now().month,
    // DateTime.now().day, 0, 0, 0, 0, 0);
    calenderState.value = !calenderState.value;
    Get.back(result: true);
  }

  String getStatusLabel() {
    return appointmentStatusList
            .where((status) => status.id == args.statusId)
            .toList()[0]
            .label
            .toString()
            .capitalize ??
        tr('select');
  }
}
