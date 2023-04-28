import 'dart:developer';

import 'package:atherium_saloon_app/models/appointment.dart';
import 'package:atherium_saloon_app/models/employee.dart';
import 'package:atherium_saloon_app/models/shop_info.dart';
import 'package:atherium_saloon_app/models/treatment_category.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen_controller.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/client.dart';
import '../models/event.dart';
import '../models/treatment.dart';
import '../screens/login_screen/login_screen.dart';

class FirebaseServices {
  static String uid = LoginController.instance.user.uid;
  static Future<String> checkUserUid() async {
    late String uid;
    await FirebaseAuth.instance.authStateChanges().listen(
      (user) {
        if (user == null) {
          Get.offAll(() => LoginScreen());
          return;
        }
        uid = user.uid;
      },
    );
    return uid;
  }

  static Future<Map<String, dynamic>?> getDataWhere({
    required String collection,
    required String key,
    required String value,
  }) async {
    try {
      final snapShot = await FirebaseFirestore.instance
          .collection(collection)
          .where(key, isEqualTo: value)
          .get();
      for (var queryDocumentSnapshot in snapShot.docs) {
        return queryDocumentSnapshot.data();
      }
    } on Exception catch (ex) {
      log(ex.toString());
    }
  }

  static Future<List<Map<String, dynamic>>?> getData({
    required String collection,
  }) async {
    var list = <Map<String, dynamic>>[];
    try {
      final snapShot =
          await FirebaseFirestore.instance.collection(collection).get();
      for (var queryDocumentSnapshot in snapShot.docs) {
        var data = queryDocumentSnapshot.data();
        data['id'] = queryDocumentSnapshot.id;
        list.add(data);
      }
      return list;
    } on Exception catch (ex) {
      log(ex.toString());
    }
  }

  static Future<List<Map<String, dynamic>>?> getLimitedData({
    required String collection,
    required int limit,
  }) async {
    var list = <Map<String, dynamic>>[];
    try {
      final snapShot = await FirebaseFirestore.instance
          .collection(collection)
          .limit(limit)
          .get();
      for (var queryDocumentSnapshot in snapShot.docs) {
        var id = queryDocumentSnapshot.id;
        var data = queryDocumentSnapshot.data();
        data['collection_id'] = id;
        list.add(data);
      }
      return list;
    } on Exception catch (ex) {
      log(ex.toString());
    }
  }

  static Future<void> toggleFavorite(
      {required String eventId, required dynamic data}) async {
    await FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .update(data.toJson());
  }

  static Stream<List<Event>> eventStream() {
    var uid = LoginController.instance.user.uid;
    return FirebaseFirestore.instance
        .collection('events')
        .limit(4)
        .snapshots()
        .map(
      (event) {
        List<Event> listEvents = [];
        event.docs.forEach(
          (element) {
            var document = element.data();

            document['event_id'] = element.id;
            Timestamp timestamp = document['end_timestamp'];
            if (timestamp.seconds >=
                Timestamp.fromDate(DateTime.now()).seconds) {
              var data = Event.fromJson(document);
              data.isfavorite =
                  data.clientId!.where((id) => id == uid).toList().isNotEmpty;
              listEvents.add(data);
            }
          },
        );
        return listEvents;
      },
    );
  }

  static Stream<Client> currentUserStream() {
    var uid = LoginController.instance.user.uid;
    return FirebaseFirestore.instance
        .collection('clients')
        .where('user_id', isEqualTo: uid)
        .snapshots()
        .map(
      (event) {
        late Client currentClient;
        event.docs.forEach(
          (element) {
            var document = element.data();
            document['id'] = element.id;
            currentClient = Client.fromJson(document);
          },
        );
        return currentClient;
      },
    );
  }

  // Get all the appointments of current use

  static Stream<List<Appointment>> currentUserAppointmentsLimited() {
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('client_id', isEqualTo: uid)
        .limit(3)
        .snapshots()
        .map((appointmentQuerySnapShot) {
      List<Appointment> appointmentsList = [];
      appointmentQuerySnapShot.docs.forEach(
        (queryDocumentSnapshot) {
          var document = queryDocumentSnapshot.data();
          document['id'] = queryDocumentSnapshot.id;
          appointmentsList.add(Appointment.fromJson(document));
        },
      );
      return appointmentsList;
    });
  }

  static Stream<List<Appointment>> currentUserAppointments() {
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('client_id', isEqualTo: uid)
        .snapshots()
        .map((appointmentQuerySnapShot) {
      List<Appointment> appointmentsList = [];
      appointmentQuerySnapShot.docs.forEach(
        (queryDocumentSnapshot) {
          var document = queryDocumentSnapshot.data();
          document['id'] = queryDocumentSnapshot.id;
          appointmentsList.add(Appointment.fromJson(document));
        },
      );
      return appointmentsList;
    });
  }

  static Stream<List<Employee>> employeeStrem() {
    return FirebaseFirestore.instance
        .collection('employees')
        .snapshots()
        .map((employeeQuerySnapshot) {
      List<Employee> emp = [];
      employeeQuerySnapshot.docs.forEach((queryDocumentSnapshot) {
        var data = queryDocumentSnapshot.data();
        data['id'] = queryDocumentSnapshot.id;
        emp.add(Employee.fromJson(data));
      });
      return emp;
    });
  }

  // Shop info stream

  static Stream<ShopInfo> shopInfoStream() {
    return FirebaseFirestore.instance
        .collection('shop_info')
        .snapshots()
        .map((shopInfoQuerySnapshot) {
      late ShopInfo shopInfo;
      shopInfoQuerySnapshot.docs.forEach((documentSnapShot) {
        var data = documentSnapShot.data();
        shopInfo = ShopInfo.fromJson(data);
        print(data);
      });
      return shopInfo;
    });
  }

  static Stream<List<TreatmentCategory>> treatmentsCategory() {
    return FirebaseFirestore.instance
        .collection('treatment_categories')
        .snapshots()
        .map((treatmentSnapshot) {
      List<TreatmentCategory> treatmentCategory = [];
      treatmentSnapshot.docs.forEach((queryDocumentSnapshot) {
        var data = queryDocumentSnapshot.data();
        data['id'] = queryDocumentSnapshot.id;
        treatmentCategory.add(TreatmentCategory.fromJson(data));
      });
      return treatmentCategory;
    });
  }

  static Future<List<Map<String, dynamic>>> getTreatmentsCategories() async {
    var treatments = <Map<String, dynamic>>[];
    try {
      var data = await FirebaseFirestore.instance
          .collection('treatment_categories')
          .get();
      for (var documentSnapShotp in data.docs) {
        print(documentSnapShotp.data());
        var data = documentSnapShotp.data();
        data['id'] = documentSnapShotp.id;
        treatments.add(data);
      }
      // data.docs.map((queryDocumentSnapshot) {
      //   var data = queryDocumentSnapshot.data();
      //   data['id'] = queryDocumentSnapshot.id;
      //   treatments.add(TreatmentCategory.fromJson(data));
      // });
    } catch (ex) {
      print(ex);
    }
    print(treatments);
    return treatments;
  }

  static Future<List<Treatment>> getTreatments() async {
    var treatments = <Treatment>[];
    try {
      var data =
          await FirebaseFirestore.instance.collection('treatments').get();
      data.docs.map((queryDocumentSnapshot) {
        var data = queryDocumentSnapshot.data();
        data['id'] = queryDocumentSnapshot.id;
        treatments.add(Treatment.fromJson(data));
      });
    } catch (ex) {
      print(ex);
    }
    return treatments;
  }

  static Stream<List<Treatment>> treatments() {
    return FirebaseFirestore.instance
        .collection('treatments')
        .snapshots()
        .map((querySnapshot) {
      List<Treatment> treatments = [];
      querySnapshot.docs.forEach((documentQuery) {
        var data = documentQuery.data();
        data['id'] = documentQuery.id;
        treatments.add(Treatment.fromJson(data));
      });
      return treatments;
    });
  }
}
