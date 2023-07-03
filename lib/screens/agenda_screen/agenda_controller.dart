// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:atherium_saloon_app/models/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';

import '../../models/appointment.dart';
import '../../models/client.dart';
import '../../models/treatment.dart';
import '../../models/treatment_category.dart';

class Event {
  Timestamp? timestamp;
  int counter;
  Event({
    this.timestamp,
    required this.counter,
  });
}

class AgendaController extends GetxController {
  static AgendaController instance = Get.find();
  var appointments = <Appointment>[].obs;
  var allAppointments = <Appointment>[].obs;
  var appointmentsCounter = <Event>[
    Event(
      counter: 0,
      timestamp: Timestamp.fromDate(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
            0, 0, 0, 0, 0),
      ),
    )
  ].obs;
  var treatmentsData = <Treatment>[].obs;
  var allTreatments = <Treatment>[].obs;
  var employees = <Employee>[].obs;
  var currentUser = Client().obs;
  var events = <DateTime, List<Map<String, dynamic>>>{};
  var selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;
  var treatmentCategories = <TreatmentCategory>[].obs;
var appointmentsTreatmentCategoryList =  <TreatmentCategory>[].obs;
  RxBool reload = false.obs;

  @override
  void onClose() {
    super.onClose();
    print('Closed');
  }

  @override
  void onInit() async {
    treatmentCategories.value = await FirebaseServices.getTreatmentCategories();
    await loadData();

    // BottomNavigationController controller = Get.find();
    // controller.toggle.value = false;

    super.onInit();
  }

  Future<void> loadData() async {
    // Get.reload();
    reload.value = true;
    day = DateFormat('EEEE').format(DateTime.now()).obs;
    date = DateFormat('dd/MM/yyyy').format(DateTime.now()).obs;
    onDateChange(DateTime.now());
    selectedDate.value =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    // print(selectedDate.value);
    // RxBool isMonthView = false.obs;
    appointments.value = [];
    allAppointments.value = [];
    treatmentsData.value = [];
    allTreatments.value = [];
    employees.value = [];
    appointmentsTreatmentCategoryList.value = [];
    events = {};
    appointmentsCounter.value = <Event>[
      Event(
          counter: 0,
          timestamp: Timestamp.fromDate(
            DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 0, 0, 0, 0, 0),
          )),
    ];
    

    var user = await FirebaseServices.getDataWhere(
        collection: 'clients',
        key: 'user_id',
        value: FirebaseServices.cuid);
    currentUser.value = Client.fromJson(user ?? {});
    var employeesData = await FirebaseServices.getData(collection: 'employees');
    var treatments = await FirebaseServices.getData(collection: 'treatments');
    treatments?.forEach((element) {
      allTreatments.add(Treatment.fromJson(element));
    });
    var allAppoints = await FirebaseServices.getAgendasAll(
        currentUser.value.isAdmin ?? false);
    allAppointments.value = allAppoints;
    var data = await FirebaseServices.getAgendas(
        Timestamp.fromDate(selectedDate.value),
        currentUser.value.isAdmin ?? false);
    appointments.value = data;
    for (var agenda in data) {
      if (agenda.employeeId != null) {
        if (agenda.employeeId!.isNotEmpty) {
          for (int i = 0; i < employeesData!.length; i++) {
            if (agenda.employeeId![0] == employeesData[i]['id']) {
              employees.add(Employee.fromJson(employeesData[i]));
            }
          }
        }
      }
    }
    for (var agenda in data) {
      if (agenda.serviceId != null) {
        if (agenda.serviceId!.isNotEmpty) {
          for (int i = 0; i < treatments!.length; i++) {
            if (agenda.serviceId![0] == treatments[i]['id']) {
              treatmentsData.add(Treatment.fromJson(treatments[i]));
            }
          }
        }
      }
    }
    
    for (int i = 0; i < allAppointments.length; i++) {
      for (int j = 0; j < appointmentsCounter.length; j++) {
        if (i == 0) {
          appointmentsCounter.value = [
            Event(counter: 1, timestamp: allAppointments[0].dateTimestamp)
          ];
        } else if (appointmentsCounter[j].timestamp ==
            allAppointments[i].dateTimestamp) {
          appointmentsCounter[j].counter += 1;
          break;
        } else if (j == appointmentsCounter.length - 1) {
          appointmentsCounter.add(
              Event(counter: 1, timestamp: allAppointments[i].dateTimestamp));
          break;
        }
      }
    }
    for (var element in appointmentsCounter) {
      events.addAll({
        element.timestamp!.toDate(): List.generate(element.counter, (index) {
          return {'isDone': true};
        })
      });
    }
    print(treatmentsData);
    for(var service in treatmentsData){
      log('Called');
      int treatmentCategoryIndex = treatmentCategories.indexWhere((element) => service.treatmentCategoryId == element.id);
      appointmentsTreatmentCategoryList.add(treatmentCategories[treatmentCategoryIndex]);
    }
    reload.value = false;
  }

  RxString day = DateFormat('EEEE').format(DateTime.now()).obs;
  RxString date = DateFormat('dd/MM/yyyy').format(DateTime.now()).obs;
  RxBool isMonthView = false.obs;

  void onDateChange(DateTime selectedDate) async {
    day.value = DateFormat('EEEE').format(selectedDate);
    date.value = DateFormat('dd/MM/yyyy').format(selectedDate);

    var employeesData = await FirebaseServices.getData(collection: 'employees');
    var treatments = await FirebaseServices.getData(collection: 'treatments');
    // var currentDate =
    //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var data = await FirebaseServices.getAgendas(
        Timestamp.fromDate(DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, 0, 0, 0, 0, 0)),
        currentUser.value.isAdmin!);
    appointments.value = data;
    employees.value = [];
    treatmentsData.value = [];
    appointmentsTreatmentCategoryList.value = [];
    for (var agenda in data) {
      if (agenda.employeeId != null) {
        if (agenda.employeeId!.isNotEmpty) {
          for (int i = 0; i < employeesData!.length; i++) {
            if (agenda.employeeId![0] == employeesData[i]['id']) {
              employees.add(Employee.fromJson(employeesData[i]));
            }
          }
        }
      }
    }
    for (var agenda in data) {
      if (agenda.serviceId != null) {
        if (agenda.serviceId!.isNotEmpty) {
          for (int i = 0; i < treatments!.length; i++) {
            if (agenda.serviceId![0] == treatments[i]['id']) {
              treatmentsData.add(Treatment.fromJson(treatments[i]));
            }
          }
        }
      }
    }
    print(treatmentsData);
    for(var service in treatmentsData){
      log('Called');
      int treatmentCategoryIndex = treatmentCategories.indexWhere((element) => service.treatmentCategoryId == element.id);
      appointmentsTreatmentCategoryList.add(treatmentCategories[treatmentCategoryIndex]);
    }
  }

  String getTime(String time) {
    if (time[1] != ':') {
      var tempTime = time[0] + time[1];
      if (int.parse(tempTime.trim()) <= 11) {
        time = time;
      }
    } else {
      time = time;
    }
    return time;
  }

  List getDuration(List services, String startTime) {
    String time = '';

    int duration = 0;
    for (var element in services) {
      for (var treatment in allTreatments) {
        if (treatment.id == element) {
          duration += int.parse(treatment.duration!);
        }
      }
    }
    String startHours = '';
    String startMints = '';
    String endTime = '';
    if (startTime[1] != ':') {
      startHours = '${startTime[0]}${startTime[1]}';
      startMints = '${startTime[3]}${startTime[4]}';
    } else {
      startHours = startTime[0];
      startMints = '${startTime[2]}${startTime[3]}';
    }
    int starthour = int.parse(startHours);
    int startMint = int.parse(startMints);
    int hours = (duration / 60).floor();
    int minutes = duration % 60;
    starthour = starthour + hours;
    startMint = startMint + minutes;
    if (startMint > 60 && starthour < 24) {
      hours = (startMint / 60).floor();
      minutes = startMint % 60;
      starthour += hours;
      endTime = '$starthour:${startMint == 0 ? '00' : startMint}';
    } else if (starthour == 24) {
      starthour = 1;
      endTime = '$starthour:00';
    } else {
      endTime = '$starthour:${startMint == 0 ? '00' : startMint}';
    }
    time = '$duration Min';

    // time = '$hours: Hours $minutes Mints';
    return [time, endTime];
  }
}
