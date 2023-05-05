// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';

import '../../models/appointment.dart';
import '../../models/client.dart';

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
  var appointmentsCounter = <Event>[].obs;
  var currentUser = Client().obs;
  var events = <DateTime, List<Map<String, dynamic>>>{};
  var selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  @override
  void onInit() async {
    var user = await FirebaseServices.getDataWhere(
        collection: 'clients',
        key: 'user_id',
        value: LoginController.instance.user.uid);
    currentUser.value = Client.fromJson(user!);
    var allAppoints =
        await FirebaseServices.getAgendasAll(currentUser.value.isAdmin!);
    allAppointments.value = allAppoints;
    var data = await FirebaseServices.getAgendas(
        Timestamp.fromDate(selectedDate), currentUser.value.isAdmin!);
    appointments.value = data;
    for (int i = 0; i < allAppointments.length; i++) {
      if (appointmentsCounter.isEmpty) {
        appointmentsCounter.add(
            Event(timestamp: allAppointments[i].dateTimestamp, counter: 1));
      } else {
        // for (var event in appointmentsCounter) {
        //   if (event.timestamp == allAppointments[i].dateTimestamp) {
        //     event.counter += 1;
        //   } else {
        //     appointmentsCounter.add(
        //         Event(counter: 1, timestamp: allAppointments[i].dateTimestamp));
        //   }
        // }
        for (int j = 0; j < appointmentsCounter.length; j++) {
          if (appointmentsCounter[j].timestamp ==
              allAppointments[i].dateTimestamp) {
            appointmentsCounter[j].counter += 1;
          } else if (j == appointmentsCounter.length - 1) {
            appointmentsCounter.add(
                Event(counter: 1, timestamp: allAppointments[i].dateTimestamp));
            break;
          }
        }
      }
      appointmentsCounter.forEach((element) {
        events.addAll({
          element.timestamp!.toDate(): List.generate(element.counter, (index) {
            return {'isDone': true};
          })
        });
      });
    }
    super.onInit();
  }

  RxString day = DateFormat('EEEE').format(DateTime.now()).obs;
  RxString date = DateFormat('dd/MM/yyyy').format(DateTime.now()).obs;
  RxBool isMonthView = false.obs;

  void onDateChange(DateTime selectedDate) async {
    day.value = DateFormat('EEEE').format(selectedDate);
    date.value = DateFormat('dd/MM/yyyy').format(selectedDate);
    // var currentDate =
    //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var data = await FirebaseServices.getAgendas(
        Timestamp.fromDate(selectedDate), currentUser.value.isAdmin!);
    appointments.value = data;
    appointmentsCounter.forEach((element) {
      print('${element.counter}: ${element.timestamp}');
    });
  }

  String getTime(String time) {
    var tempTime = time[0] + time[1];
    if (int.parse(tempTime) <= 11) {
      time = '$time Am';
    }
    return time;
  }
}
