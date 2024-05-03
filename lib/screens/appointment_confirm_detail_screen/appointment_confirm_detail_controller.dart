// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:atherium_saloon_app/models/notification_model.dart';
// import 'package:atherium_saloon_app/network_utils/firebase_messaging.dart';
// import 'package:atherium_saloon_app/screens/appointment_confirm_screen/appointment_confirm_screen.dart';
// import 'package:atherium_saloon_app/screens/home_screen/home_screen_controller.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart';
//
// import '../../models/treatment.dart';
// import '../../network_utils/firebase_services.dart';
// import '../agenda_screen/agenda_controller.dart';
//
// class AppointmentConfirmDetailController extends GetxController {
//   var args = Get.arguments;
//   var allTreatments = <Treatment>[].obs;
//   final appointmentServicesIds = Get.arguments;
//   var servicesList = <Treatment>[].obs;
//   RxInt price = 0.obs;
//   String selectedStatus = '';
//   String previousStatus = '';
//   RxBool isLoading = false.obs;
//
//   // String adminId = '';
//   List<String> adminIds = [];
//
//   @override
//   void onInit() async {
//     super.onInit();
//     allTreatments.bindStream(FirebaseServices.treatments());
//     var instance = await FirebaseFirestore.instance
//         .collection('clients')
//         .where('isAdmin', isEqualTo: true)
//         .get();
//     // adminId = instance.docs.first.id;
//     adminIds = instance.docs.map((doc) => doc.id).toList();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//     allTreatments.close();
//   }
//
//   String getName(String id) {
//     for (var treatment in allTreatments) {
//       if (treatment.id == id) {
//         return treatment.name!;
//       }
//     }
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       update();
//     });
//
//     return '';
//   }
//
//   String getTime(String id) {
//     for (var treatment in allTreatments) {
//       if (treatment.id == id) {
//         return treatment.duration!.toString();
//       }
//     }
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       update();
//     });
//     return '';
//   }
//
//   void getTreatment(String id) {
//     for (var treatment in allTreatments) {
//       if (treatment.id == id) {
//         servicesList.add(treatment);
//       }
//     }
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       update();
//     });
//   }
//
//   var prices = [];
//
//   String getToatlPrice() {
//     var totalprice = 0;
//     for (var price in prices) {
//       totalprice += int.parse(price);
//       price.value = totalprice.toString();
//       update();
//     }
//     return totalprice.toString();
//   }
//
//   String getPrice(String id) {
//     int tempPrice = 0;
//     for (var treatment in allTreatments) {
//       if (treatment.id == id) {
//         if (!prices.contains(treatment.price)) {
//           prices.add(treatment.price);
//           // ignore: avoid_function_literals_in_foreach_calls, unused_local_variable
//           var sum = prices.forEach((element) {
//             tempPrice += int.parse(element);
//           });
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             update();
//           });
//         }
//         price.value = tempPrice;
//         return treatment.price.toString();
//       }
//     }
//     return '';
//   }
//
//   String getTotalPrice(List<Treatment> services) {
//     double price = 0;
//     for (var service in services) {
//       price += double.parse(service.price!.toString());
//     }
//     return price.toString();
//   }
//
//   double totalprice = 0.0;
//
//   double get totalPrice {
//     if (args!.isNotEmpty && totalprice == 0.0) {
//       for (int i = 0; i < args!.length; i++) {
//         totalprice += args![i].price;
//       }
//     }
//     return totalprice;
//   }
//
//   void confirm() async {
//     isLoading.value = true;
//     HomeScreenController homeController = Get.find();
//     AgendaController agendaController = Get.find();
//
//     if (args.id == null) {
//       await FirebaseFirestore.instance
//           .collection('appointments')
//           .add(args.toJson())
//           .then((value) async {
//         var docSnapshot = await value.get();
//         var data = docSnapshot.data();
//         if (kDebugMode) {
//           print('Data:::::: $data');
//         }
//         try {
//           if (data != null) {
//             log('Calling__________');
//             var uri = Uri.parse(
//                 'https://us-central1-aetherium-salon.cloudfunctions.net/googleCalendarEvent');
//             var body = {
//               "operation": "CREATE",
//               "appointment_id": docSnapshot.id,
//               "appointment": {
//                 'client_id': data['client_id'],
//                 'date': data['date'],
//                 'date_timestamp': {
//                   "__time__":
//                       data['date_timestamp'].toDate().toUtc().toIso8601String()
//                 },
//                 'email': data['email'],
//                 'employee_id_list': data['employee_id_list'],
//                 'end_time': data['end_time'],
//                 'is_regular': data['is_regular'],
//                 'notes': data['noets'] ?? '',
//                 'number': data['number'],
//                 'room_id_list': data['room_id_list'],
//                 'start_time': data['start_time'],
//                 'status_id': data['status_id'],
//                 'time': data['time'],
//                 'total_duration': data['total_duration'],
//                 'treatment_id_list': data['treatment_id_list'],
//               },
//             };
//             log('Body :::::: ${json.encode(body)}');
//             var response = await post(
//               uri,
//               headers: {
//                 'Content-Type': 'application/json',
//               },
//               body: json.encode(body),
//             );
//             log('Client id::::>>. ${data['client_id']} ');
//             log('Response :: ${response.body}');
//           }
//         } catch (ex) {
//           log("Exception::: ${ex.toString()}");
//         }
//         if (!homeController.currentUser.value.isAdmin!) {
//           // sendNotification(tr('appointment_new_added_successfully'),
//           //     args.clientId, tr('new_appointment'),
//           //     appointmentId: value.id);
//
//           sendNotification(
//             '${homeController.currentUser.value.firstName} ${homeController.currentUser.value.lastName} ${tr('appointment_new_added')}',
//             'admin',
//             tr('new_appointment'),
//             appointmentId: value.id,
//           );
//         }
//         if (homeController.currentUser.value.isAdmin!) {
//           sendNotification(
//               tr('we_created_new_appointment'), args.clientId, 'Admin',
//               appointmentId: value.id);
//         }
//       });
//       isLoading.value = false;
//
//       Get.to(
//         () => const AppointmentConfirmScreen(),
//         duration: const Duration(milliseconds: 400),
//         transition: Platform.isIOS ? null : Transition.leftToRight,
//         curve: Curves.linear,
//       );
//       homeController.loadHomeScreen();
//       agendaController.loadData();
//     } else {
//       isLoading.value = true;
//       await FirebaseFirestore.instance
//           .collection('appointments')
//           .doc(args.id)
//           .set({
//         'date': args.date,
//         'time': args.time,
//         'date_timestamp': args.dateTimestamp,
//         'notes': args.notes,
//         'start_time': args.startTime,
//         'end_time': args.endTime,
//         'total_duration': args.duration,
//         'employee_id_list': args.employeeId,
//         'treatment_id_list': args.serviceId,
//         'status_id': args.statusId,
//       }, SetOptions(merge: true));
//       var appointmentDocs = await FirebaseFirestore.instance
//           .collection('appointments')
//           .doc(args.id)
//           .get();
//
//       await FirebaseFirestore.instance
//           .collection('appointments')
//           .doc(args.id)
//           .get()
//           .then((value) async {
//         var data = value.data();
//         if (data != null) {
//           try {
//             var uri = Uri.parse(
//                 'https://us-central1-aetherium-salon.cloudfunctions.net/googleCalendarEvent');
//             var body = json.encode(
//               {
//                 "operation": "UPDATE",
//                 "appointment_id": value.id,
//                 "appointment": {
//                   'client_id': data['client_id'],
//                   'date': data['date'],
//                   'date_timestamp': {
//                     "__time__": data['date_timestamp']
//                         .toDate()
//                         .toUtc()
//                         .toIso8601String()
//                   },
//                   'email': data['email'],
//                   'employee_id_list': data['employee_id_list'],
//                   'end_time': data['end_time'],
//                   'is_regular': data['is_regular'],
//                   'notes': data['noets'],
//                   'number': data['number'],
//                   'room_id_list': data['room_id_list'],
//                   'start_time': data['start_time'],
//                   'status_id': data['status_id'],
//                   'time': data['time'],
//                   'total_duration': data['total_duration'],
//                   'treatment_id_list': data['treatment_id_list'],
//                 },
//               },
//             );
//             log('Body ::::: $body');
//             var response = await post(
//               uri,
//               headers: {
//                 'Content-Type': 'application/json',
//               },
//               body: body,
//             );
//             log('Response :: ${response.body}');
//           } catch (ex) {
//             log("Exception::: ${ex.toString()}");
//           }
//         }
//       });
//       var docId = appointmentDocs.id;
//       var appointmentData = appointmentDocs.data();
//       appointmentData!['id'] = docId;
//       // var appointmentObject =
//       //     Appointment.fromJson(appointmentData).toJsonCloudCalendar();
//       // var appointmentJson = json.encode({"appointment": appointmentObject});
//       // print(appointmentJson);
//
//       homeController.loadHomeScreen();
//       agendaController.loadData();
//
//       var snapshot = await FirebaseFirestore.instance
//           .collection('client_memberships')
//           .doc(args.clientId)
//           .get();
//       var data = snapshot.data();
//       var points = data?['points'];
//       if (selectedStatus != '' &&
//           selectedStatus.toLowerCase() == 'archiviato' &&
//           previousStatus.toLowerCase() != 'archiviato' &&
//           points + 25 <= 300) {
//         await FirebaseFirestore.instance
//             .collection('client_memberships')
//             .doc(args.clientId)
//             .update(
//           {
//             "points": FieldValue.increment(25),
//           },
//         );
//         await homeController.loadHomeScreen();
//         await agendaController.loadData();
//       } else if (previousStatus.toLowerCase() == 'archiviato' &&
//           selectedStatus.toLowerCase() != 'archiviato' &&
//           points - 25 >= 0) {
//         await FirebaseFirestore.instance
//             .collection('client_memberships')
//             .doc(args.clientId)
//             .update(
//           {
//             "points": FieldValue.increment(-25),
//           },
//         );
//         await homeController.loadHomeScreen();
//         await agendaController.loadData();
//       } else {
//         await homeController.loadHomeScreen();
//         await agendaController.loadData();
//       }
//       await homeController.loadHomeScreen();
//       await agendaController.loadData();
//       homeController.refresh();
//       isLoading.value = false;
//       Get.to(
//         () => const AppointmentConfirmScreen(),
//         duration: const Duration(milliseconds: 400),
//         transition: Platform.isIOS ? null : Transition.leftToRight,
//         curve: Curves.linear,
//       );
//       // await homeController.loadHomeScreen();
//       // await agendaController.loadData();
//     }
//   }
//
//   String getEndTime(String startTime, num duration) {
//     String time = DateFormat('HH:mm').format(DateTime.parse(args.endTime));
//     return time;
//     // ! Fixes the time duration issue
//     // String hours;
//     // String minutes;
//     // if (startTime[1] != ':') {
//     //   hours = startTime[0] + startTime[1];
//     //   if (startTime.length == 5) {
//     //     minutes = startTime[3] + startTime[4];
//     //   } else {
//     //     minutes = startTime[3];
//     //   }
//     // } else {
//     //   hours = startTime[0];
//     //   if (startTime.length == 4) {
//     //     minutes = startTime[2] + startTime[3];
//     //   } else {
//     //     minutes = startTime[2];
//     //   }
//     // }
//     // String endHours = (duration ~/ 60).toString().replaceAll('-', '')[0];
//     // String endMinutes = (duration % 60).toString();
//
//     // var endTimeHours = int.parse(hours) + int.parse(endHours);
//     // var endTimeMinutes = int.parse(minutes) + int.parse(endMinutes);
//     // if (endTimeMinutes >= 60) {
//     //   endTimeHours += 1;
//     //   endTimeMinutes -= 60;
//     // }
//     // if (endTimeHours >= 24) {
//     //   endTimeHours = endTimeHours - 24;
//     // }
//     // String totalEndHours =
//     //     endTimeHours < 9 ? '0$endTimeHours' : endTimeHours.toString();
//     // String totalMinutes =
//     //     endTimeMinutes < 9 ? '0$endTimeMinutes' : endTimeMinutes.toString();
//
//     // return '$totalEndHours:$totalMinutes';
//   }
//
//   void sendAdminNotification(
//       String message, List<String> receiverIds, String title,
//       {required String appointmentId}) {
//     HomeScreenController controller = Get.find();
//     for (String receiverId in receiverIds) {
//       NotificationModel notification = NotificationModel(
//           id: '',
//           title: title,
//           body: message,
//           senderId: controller.currentUser.value.userId!,
//           receiverId: receiverId,
//           senderImage: controller.currentUser.value.photo ?? '',
//           senderName:
//               '${controller.currentUser.value.firstName!} ${controller.currentUser.value.lastName}',
//           createdAt: Timestamp.now(),
//           type: 'apointment',
//           desc: message,
//           status: 'unread',
//           appointmentId: appointmentId,
//           clientId: '');
//       NotificationsSubscription.createNotification(notification: notification);
//     }
//   }
//
//   void sendNotification(String message, String receiverId, String title,
//       {required String appointmentId}) async {
//     HomeScreenController controller = Get.find();
//     List<String> ids = [];
//     if (receiverId == 'admin' || receiverId == 'client') {
//       ids = await FirebaseServices().fetchUserIdz(receiverId);
//     } else {
//       ids.add(receiverId);
//     }
//
//     NotificationModel notification = NotificationModel(
//         id: '',
//         title: title,
//         body: message,
//         senderId: controller.currentUser.value.userId!,
//         receiverId: [receiverId],
//         senderImage: controller.currentUser.value.photo ?? '',
//         senderName:
//             '${controller.currentUser.value.firstName!} ${controller.currentUser.value.lastName}',
//         createdAt: Timestamp.now(),
//         type: 'apointment',
//         desc: message,
//         status: ids,
//         appointmentId: appointmentId,
//         clientId: '');
//     NotificationsSubscription.createNotification(notification: notification);
//   }
// }
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:atherium_saloon_app/models/notification_model.dart';
import 'package:atherium_saloon_app/network_utils/firebase_messaging.dart';
import 'package:atherium_saloon_app/screens/appointment_confirm_screen/appointment_confirm_screen.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../models/treatment.dart';
import '../../network_utils/firebase_services.dart';
import '../agenda_screen/agenda_controller.dart';

class AppointmentConfirmDetailController extends GetxController {
  var args = Get.arguments;
  var allTreatments = <Treatment>[].obs;
  final appointmentServicesIds = Get.arguments;
  var servicesList = <Treatment>[].obs;
  RxInt price = 0.obs;
  String selectedStatus = '';
  String previousStatus = '';
  RxBool isLoading = false.obs;
  String adminId = '';
  @override
  void onInit() async {
    super.onInit();
    allTreatments.bindStream(FirebaseServices.treatments());
    var instance = await FirebaseFirestore.instance
        .collection('clients')
        .where('isAdmin', isEqualTo: true)
        .get();
    adminId = instance.docs.first.id;
  }

  @override
  void onClose() {
    super.onClose();
    allTreatments.close();
  }

  String getName(String id) {
    for (var treatment in allTreatments) {
      if (treatment.id == id) {
        return treatment.name!;
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });

    return '';
  }

  String getTime(String id) {
    for (var treatment in allTreatments) {
      if (treatment.id == id) {
        return treatment.duration!.toString();
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
    return '';
  }

  void getTreatment(String id) {
    for (var treatment in allTreatments) {
      if (treatment.id == id) {
        servicesList.add(treatment);
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
  }

  var prices = [];
  String getToatlPrice() {
    var totalprice = 0;
    for (var price in prices) {
      totalprice += int.parse(price);
      price.value = totalprice.toString();
      update();
    }
    return totalprice.toString();
  }

  String getPrice(String id) {
    int tempPrice = 0;
    for (var treatment in allTreatments) {
      if (treatment.id == id) {
        if (!prices.contains(treatment.price)) {
          prices.add(treatment.price);
          // ignore: avoid_function_literals_in_foreach_calls, unused_local_variable
          var sum = prices.forEach((element) {
            tempPrice += int.parse(element);
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            update();
          });
        }
        price.value = tempPrice;
        return treatment.price.toString();
      }
    }
    return '';
  }

  String getTotalPrice(List<Treatment> services) {
    double price = 0;
    for (var service in services) {
      price += double.parse(service.price!.toString());
    }
    return price.toString();
  }

  double totalprice = 0.0;
  double get totalPrice {
    if (args!.isNotEmpty && totalprice == 0.0) {
      for (int i = 0; i < args!.length; i++) {
        totalprice += args![i].price;
      }
    }
    return totalprice;
  }

  void confirm() async {
    isLoading.value = true;
    HomeScreenController homeController = Get.find();
    AgendaController agendaController = Get.find();

    if (args.id == null) {
      await FirebaseFirestore.instance
          .collection('appointments')
          .add(args.toJson())
          .then((value) async {
        var docSnapshot = await value.get();
        var data = docSnapshot.data();
        if (kDebugMode) {
          print('Data:::::: $data');
        }
        try {
          if (data != null) {
            log('Calling__________');
            var uri = Uri.parse(
                'https://us-central1-aetherium-salon.cloudfunctions.net/googleCalendarEvent');
            var body = {
              "operation": "CREATE",
              "appointment_id": docSnapshot.id,
              "appointment": {
                'client_id': data['client_id'],
                'date': data['date'],
                'date_timestamp': {
                  "__time__":
                  data['date_timestamp'].toDate().toUtc().toIso8601String()
                },
                'email': data['email'],
                'employee_id_list': data['employee_id_list'],
                'end_time': data['end_time'],
                'is_regular': data['is_regular'],
                'notes': data['noets'] ?? '',
                'number': data['number'],
                'room_id_list': data['room_id_list'],
                'start_time': data['start_time'],
                'status_id': data['status_id'],
                'time': data['time'],
                'total_duration': data['total_duration'],
                'treatment_id_list': data['treatment_id_list'],
              },
            };
            log('Body :::::: ${json.encode(body)}');
            var response = await post(
              uri,
              headers: {
                'Content-Type': 'application/json',
              },
              body: json.encode(body),
            );
            log('Client id::::>>. ${data['client_id']} ');
            log('Response :: ${response.body}');
          }
        } catch (ex) {
          log("Exception::: ${ex.toString()}");
        }
        if (!homeController.currentUser.value.isAdmin!) {
          sendNotification(
            '${homeController.currentUser.value.firstName} ${homeController.currentUser.value.lastName} ${tr('appointment_new_added')}',
            'admin',
            tr('new_appointment'),
            appointmentId: value.id,
          );
        }
        if (homeController.currentUser.value.isAdmin!) {
          sendNotification(
              tr('we_created_new_appointment'), args.clientId, 'Admin',
              appointmentId: value.id);
        }
      });
      isLoading.value = false;

      Get.to(
            () => const AppointmentConfirmScreen(),
        duration: const Duration(milliseconds: 400),
        transition: Platform.isIOS ? null : Transition.leftToRight,
        curve: Curves.linear,
      );
      homeController.loadHomeScreen();
      agendaController.loadData();
    } else {
      isLoading.value = true;
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(args.id)
          .set({
        'date': args.date,
        'time': args.time,
        'date_timestamp': args.dateTimestamp,
        'notes': args.notes,
        'start_time': args.startTime,
        'end_time': args.endTime,
        'total_duration': args.duration,
        'employee_id_list': args.employeeId,
        'treatment_id_list': args.serviceId,
        'status_id': args.statusId,
      }, SetOptions(merge: true));
      var appointmentDocs = await FirebaseFirestore.instance
          .collection('appointments')
          .doc(args.id)
          .get();
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(args.id)
          .get()
          .then((value) async {
        var data = value.data();
        if (data != null) {
          try {
            var uri = Uri.parse(
                'https://us-central1-aetherium-salon.cloudfunctions.net/googleCalendarEvent');
            var body = json.encode(
              {
                "operation": "UPDATE",
                "appointment_id": value.id,
                "appointment": {
                  'client_id': data['client_id'],
                  'date': data['date'],
                  'date_timestamp': {
                    "__time__": data['date_timestamp']
                        .toDate()
                        .toUtc()
                        .toIso8601String()
                  },
                  'email': data['email'],
                  'employee_id_list': data['employee_id_list'],
                  'end_time': data['end_time'],
                  'is_regular': data['is_regular'],
                  'notes': data['noets'],
                  'number': data['number'],
                  'room_id_list': data['room_id_list'],
                  'start_time': data['start_time'],
                  'status_id': data['status_id'],
                  'time': data['time'],
                  'total_duration': data['total_duration'],
                  'treatment_id_list': data['treatment_id_list'],
                },
              },
            );
            log('Body ::::: $body');
            var response = await post(
              uri,
              headers: {
                'Content-Type': 'application/json',
              },
              body: body,
            );
            log('Response :: ${response.body}');
          } catch (ex) {
            log("Exception::: ${ex.toString()}");
          }
        }
      });
      var docId = appointmentDocs.id;
      var appointmentData = appointmentDocs.data();
      appointmentData!['id'] = docId;
      // var appointmentObject =
      //     Appointment.fromJson(appointmentData).toJsonCloudCalendar();
      // var appointmentJson = json.encode({"appointment": appointmentObject});
      // print(appointmentJson);

      homeController.loadHomeScreen();
      agendaController.loadData();

      var snapshot = await FirebaseFirestore.instance
          .collection('client_memberships')
          .doc(args.clientId)
          .get();
      var data = snapshot.data();
      var points = data?['points'];
      if (selectedStatus != '' &&
          selectedStatus.toLowerCase() == 'archiviato' &&
          previousStatus.toLowerCase() != 'archiviato' &&
          points + 25 <= 300) {
        await FirebaseFirestore.instance
            .collection('client_memberships')
            .doc(args.clientId)
            .update(
          {
            "points": FieldValue.increment(25),
          },
        );
        await homeController.loadHomeScreen();
        await agendaController.loadData();
      } else if (previousStatus.toLowerCase() == 'archiviato' &&
          selectedStatus.toLowerCase() != 'archiviato' &&
          points - 25 >= 0) {
        await FirebaseFirestore.instance
            .collection('client_memberships')
            .doc(args.clientId)
            .update(
          {
            "points": FieldValue.increment(-25),
          },
        );
        await homeController.loadHomeScreen();
        await agendaController.loadData();
      } else {
        await homeController.loadHomeScreen();
        await agendaController.loadData();
      }
      await homeController.loadHomeScreen();
      await agendaController.loadData();
      homeController.refresh();
      isLoading.value = false;
      Get.to(
            () => const AppointmentConfirmScreen(),
        duration: const Duration(milliseconds: 400),
        transition: Platform.isIOS ? null : Transition.leftToRight,
        curve: Curves.linear,
      );
      // await homeController.loadHomeScreen();
      // await agendaController.loadData();
    }
  }

  String getEndTime(String startTime, num duration) {
    String time = DateFormat('HH:mm').format(DateTime.parse(args.endTime));
    return time;
    // ! Fixes the time duration issue
    // String hours;
    // String minutes;
    // if (startTime[1] != ':') {
    //   hours = startTime[0] + startTime[1];
    //   if (startTime.length == 5) {
    //     minutes = startTime[3] + startTime[4];
    //   } else {
    //     minutes = startTime[3];
    //   }
    // } else {
    //   hours = startTime[0];
    //   if (startTime.length == 4) {
    //     minutes = startTime[2] + startTime[3];
    //   } else {
    //     minutes = startTime[2];
    //   }
    // }
    // String endHours = (duration ~/ 60).toString().replaceAll('-', '')[0];
    // String endMinutes = (duration % 60).toString();

    // var endTimeHours = int.parse(hours) + int.parse(endHours);
    // var endTimeMinutes = int.parse(minutes) + int.parse(endMinutes);
    // if (endTimeMinutes >= 60) {
    //   endTimeHours += 1;
    //   endTimeMinutes -= 60;
    // }
    // if (endTimeHours >= 24) {
    //   endTimeHours = endTimeHours - 24;
    // }
    // String totalEndHours =
    //     endTimeHours < 9 ? '0$endTimeHours' : endTimeHours.toString();
    // String totalMinutes =
    //     endTimeMinutes < 9 ? '0$endTimeMinutes' : endTimeMinutes.toString();

    // return '$totalEndHours:$totalMinutes';
  }

  void sendNotification(String message, String receiverId, String title,
      {required String appointmentId}) async {
    HomeScreenController controller = Get.find();
    List<String> ids = [];
    if (receiverId == 'admin' || receiverId == 'client') {
      ids = await FirebaseServices().fetchUserIdz(receiverId);
    } else {
      ids.add(receiverId);
    }
    NotificationModel notification = NotificationModel(
        id: '',
        title: title,
        body: message,
        senderId: controller.currentUser.value.userId!,
        receiverId: [receiverId],
        senderImage: controller.currentUser.value.photo ?? '',
        senderName:
        '${controller.currentUser.value.firstName!} ${controller.currentUser.value.lastName}',
        createdAt: Timestamp.now(),
        type: 'apointment',
        desc: message,
        status: ids,
        appointmentId: appointmentId,
        clientId: '');
    NotificationsSubscription.createNotification(notification: notification);
  }
}
