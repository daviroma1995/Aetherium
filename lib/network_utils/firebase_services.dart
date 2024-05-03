import 'dart:developer';

import 'package:atherium_saloon_app/models/appointment.dart';
import 'package:atherium_saloon_app/models/consultation.dart';
import 'package:atherium_saloon_app/models/employee.dart';
import 'package:atherium_saloon_app/models/shop_info.dart';
import 'package:atherium_saloon_app/models/treatment_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/client.dart';
import '../models/event.dart';
import '../models/notification.dart';
import '../models/treatment.dart';

class FirebaseServices {
  static String cuid = FirebaseAuth.instance.currentUser?.uid ?? '';
  static Future<String> checkUserUid() async {
    late String uid;
    FirebaseAuth.instance.authStateChanges().listen(
      (user) {
        if (user == null) {
          // Get.offAll(() => LoginScreen());
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
    return null;
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
    return null;
  }

  static Future<List<Map<String, dynamic>>?> getFilteredAppointments({
    required String collection,
  }) async {
    var list = <Map<String, dynamic>>[];
    try {
      final snapShot = await FirebaseFirestore.instance
          .collection(collection)
          .orderBy('date_timestamp', descending: false)
          .orderBy('start_time', descending: false)
          .get();
      for (var queryDocumentSnapshot in snapShot.docs) {
        var data = queryDocumentSnapshot.data();
        data['id'] = queryDocumentSnapshot.id;
        list.add(data);
      }
      return list;
    } on Exception catch (ex) {
      log(ex.toString());
    }
    return null;
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
    return null;
  }

  static Future<void> toggleFavorite(
      {required String eventId, required dynamic data}) async {
    await FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .update(data.toJson());
  }

  static Stream<List<Event>> eventStream() {
    var uid = cuid;
    return FirebaseFirestore.instance
        .collection('events')
        .orderBy('end_timestamp', descending: true)
        .limit(3)
        .snapshots()
        .map(
      (event) {
        List<Event> listEvents = [];
        for (var element in event.docs) {
          var document = element.data();

          document['event_id'] = element.id;
          Timestamp timestamp = document['end_timestamp'];
          if (timestamp.seconds >= Timestamp.fromDate(DateTime.now()).seconds) {
            var data = Event.fromJson(document);
            data.isfavorite =
                data.clientId!.where((id) => id == uid).toList().isNotEmpty;
            listEvents.add(data);
          }
        }
        return listEvents;
      },
    );
  }

  static Stream<Client> currentUserStream() {
    var uid = cuid;
    return FirebaseFirestore.instance
        .collection('clients')
        .where('user_id', isEqualTo: uid)
        .snapshots()
        .map(
      (event) {
        late Client currentClient;
        for (var element in event.docs) {
          var document = element.data();
          document['id'] = element.id;
          currentClient = Client.fromJson(document);
        }
        return currentClient;
      },
    );
  }
  // Get current user

  static Future<Map<String, dynamic>> getCurrentUser() async {
    var uid = cuid;
    var data =
        await FirebaseFirestore.instance.collection('clients').doc(uid).get();
    return data.data()!;
  }

  // Get all the appointments of current use

  static Stream<List<Appointment>> currentUserAppointmentsLimited() {
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('client_id', isEqualTo: cuid)
        .orderBy('date_timestamp', descending: true)
        .limit(3)
        .snapshots()
        .map((appointmentQuerySnapShot) {
      List<Appointment> appointmentsList = [];
      for (var queryDocumentSnapshot in appointmentQuerySnapShot.docs) {
        var document = queryDocumentSnapshot.data();
        document['id'] = queryDocumentSnapshot.id;
        Timestamp timestamp = document['date_timestamp'];
        if (timestamp.seconds >= Timestamp.now().seconds) {
          appointmentsList.add(Appointment.fromJson(document));
        }
      }
      return appointmentsList;
    });
  }

  static Future<List<Appointment>> getAppointments(
      {required bool isAdmin}) async {
    if (isAdmin == false) {
      List<Appointment> appointmentsList = [];
      var data = await FirebaseFirestore.instance
          .collection('appointments')
          .where('client_id', isEqualTo: cuid)
          .where('is_regular', isEqualTo: true)
          .orderBy('date_timestamp', descending: true)
          .limit(3)
          .get();
      for (var querySnapshot in data.docs) {
        var data = querySnapshot.data();
        data['id'] = querySnapshot.id;
        Timestamp timestamp = data['date_timestamp'];
        if (timestamp.seconds + 86400 >= Timestamp.now().seconds) {
          appointmentsList.add(Appointment.fromJson(data));
        }
      }
      return appointmentsList;
    } else {
      List<Appointment> appointmentsList = [];
      var data = await FirebaseFirestore.instance
          .collection('appointments')
          .orderBy('date_timestamp', descending: true)
          .limit(3)
          .get();
      for (var querySnapshot in data.docs) {
        var data = querySnapshot.data();
        data['id'] = querySnapshot.id;
        Timestamp timestamp = data['date_timestamp'];
        if (timestamp.seconds + 86400 >= Timestamp.now().seconds) {
          appointmentsList.add(Appointment.fromJson(data));
        }
      }
      return appointmentsList;
    }
  }

  static Stream<List<Appointment>> currentUserAppointments() {
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('client_id', isEqualTo: cuid)
        .snapshots()
        .map((appointmentQuerySnapShot) {
      List<Appointment> appointmentsList = [];
      for (var queryDocumentSnapshot in appointmentQuerySnapShot.docs) {
        var document = queryDocumentSnapshot.data();
        document['id'] = queryDocumentSnapshot.id;
        appointmentsList.add(Appointment.fromJson(document));
      }
      return appointmentsList;
    });
  }

  static Stream<List<Employee>> employeeStrem() {
    try {
      return FirebaseFirestore.instance
          .collection('employees')
          .snapshots()
          .map((employeeQuerySnapshot) {
        List<Employee> emp = [];
        for (var queryDocumentSnapshot in employeeQuerySnapshot.docs) {
          var data = queryDocumentSnapshot.data();
          data['id'] = queryDocumentSnapshot.id;
          emp.add(Employee.fromJson(data));
        }
        return emp;
      });
    } catch (ex) {
      return const Stream.empty();
    }
  }

  // static Stream<List<Treatment>> treatmentsStream(){

  // }
  // Shop info stream

  static Stream<ShopInfo> shopInfoStream() {
    return FirebaseFirestore.instance
        .collection('shop_info')
        .snapshots()
        .map((shopInfoQuerySnapshot) {
      late ShopInfo shopInfo;
      for (var documentSnapShot in shopInfoQuerySnapshot.docs) {
        var data = documentSnapShot.data();
        shopInfo = ShopInfo.fromJson(data);
      }
      return shopInfo;
    });
  }

  static Stream<List<TreatmentCategory>> treatmentsCategory() {
    return FirebaseFirestore.instance
        .collection('treatment_categories')
        .snapshots()
        .map((treatmentSnapshot) {
      List<TreatmentCategory> treatmentCategory = [];
      var docs = treatmentSnapshot.docs;
      for (var queryDocumentSnapshot in docs) {
        var data = queryDocumentSnapshot.data();
        data['id'] = queryDocumentSnapshot.id;
        treatmentCategory.add(TreatmentCategory.fromJson(data));
      }
      void loadIamges() async {
        for (int i = 0; i < treatmentCategory.length; i++) {
          var iconUrl = await getDownloadUrl(treatmentCategory[i].iconUrl!);
          treatmentCategory[i].iconUrl = iconUrl;
        }
      }

      loadIamges();

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
      log(ex.toString());
    }
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
      log(ex.toString());
    }
    return treatments;
  }

  static Stream<List<Treatment>> treatments() {
    return FirebaseFirestore.instance
        .collection('treatments')
        .snapshots()
        .map((querySnapshot) {
      List<Treatment> treatments = [];
      for (var documentQuery in querySnapshot.docs) {
        var data = documentQuery.data();
        data['id'] = documentQuery.id;
        treatments.add(Treatment.fromJson(data));
      }
      return treatments;
    });
  }

  static Future<List<Appointment>> getAgendas(
      Timestamp timestamp, bool isAdmin) async {
    // ignore: unused_local_variable
    var secondTimestamp = Timestamp.fromDate(DateTime(DateTime.now().year,
        DateTime.now().month, DateTime.now().day, 24, 00, 00, 0, 0));
    List<Appointment> agendas = [];
    if (!isAdmin) {
      try {
        var data = await FirebaseFirestore.instance
            .collection('appointments')
            .where('date_timestamp', isEqualTo: timestamp)
            .where('client_id', isEqualTo: cuid)
            .get();
        for (var querySnapShot in data.docs) {
          var data = querySnapShot.data();
          data['id'] = querySnapShot.id;
          agendas.add(Appointment.fromJson(data));
        }
      } catch (ex) {
        log('Error: $ex');
      }
    } else {
      log('else called');
      try {
        var data = await FirebaseFirestore.instance
            .collection('appointments')
            .where('date_timestamp', isEqualTo: timestamp)
            .get();
        for (var querySnapShot in data.docs) {
          var data = querySnapShot.data();
          data['id'] = querySnapShot.id;
          agendas.add(Appointment.fromJson(data));
        }
      } catch (ex) {
        log('Error: $ex');
      }
    }
    return agendas;
  }

  static Future<List<Appointment>> getAgendasAll(bool isAdmin) async {
    List<Appointment> agendas = [];
    if (!isAdmin) {
      try {
        var data = await FirebaseFirestore.instance
            .collection('appointments')
            .where('client_id', isEqualTo: cuid)
            .where('is_regular', isEqualTo: true)
            .get();
        for (var querySnapShot in data.docs) {
          var data = querySnapShot.data();
          data['id'] = querySnapShot.id;
          agendas.add(Appointment.fromJson(data));
        }
      } catch (ex) {
        log('Error: $ex');
      }
    } else {
      log('else called');
      try {
        var data =
            await FirebaseFirestore.instance.collection('appointments').get();
        for (var querySnapShot in data.docs) {
          var data = querySnapShot.data();
          data['id'] = querySnapShot.id;
          agendas.add(Appointment.fromJson(data));
        }
      } catch (ex) {
        log('Error: $ex');
      }
    }
    return agendas;
  }

  static Future<List<Map<String, dynamic>>?> getAllAppointments({
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
    return null;
  }

  static Future<List<Notification>> getUnreadNotifications() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    List<Notification> unreadNotifications = [];

    await firestore
        .collection('new_notification')
        .where('status', arrayContains: cuid)
        .orderBy('createdAt', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        unreadNotifications.add(Notification.fromFirestore(doc));
      }
    }).catchError((error) {
      log('Error getting documents: $error');
    });

    return unreadNotifications;
  }

  static Stream<List<Notification>> getUnreadNotficationsStream() {
    return FirebaseFirestore.instance
        .collection('new_notification')
        .where('status', arrayContains: cuid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((notification) {
      var notifications = <Notification>[];
      var data = notification.docs;
      for (var notification in data) {
        notifications.add(Notification.fromFirestore(notification));
      }
      return notifications;
    });
  }

  static void markNotificationAsRead(Notification notification) {
    try {
      var status = notification.status;
      status.removeWhere((element) => element == cuid);
      DocumentReference notificationRef = FirebaseFirestore.instance
          .collection('new_notification')
          .doc(notification.id);
      notificationRef.update({
        'status': status,
      });
    } catch (ex) {
      log(ex.toString());
    }
  }

  static Future<List<Treatment>> getServicesBasedOnMembershipType(
      String uid) async {
    List<Treatment> services = <Treatment>[];
    var clientDocSnapshot = await FirebaseFirestore.instance
        .collection('client_memberships')
        .doc(uid)
        .get();
    if (clientDocSnapshot.data() == null) {
      var treatmentsQuerySnaps =
          await FirebaseFirestore.instance.collection('treatments').get();
      var treatmentsDocs = treatmentsQuerySnaps.docs;
      for (var treatmentQuery in treatmentsDocs) {
        Treatment treatment = Treatment.fromJson(treatmentQuery.data());
        services.add(treatment);
      }
    } else {
      var membershipDoc = clientDocSnapshot.data();
      var membershipId = membershipDoc!['membership_type_id'];
      var treatmentsQuerySnaps = await FirebaseFirestore.instance
          .collection('treatments')
          .where('membership_type_id', isEqualTo: membershipId)
          .get();
      var treatmentsDocs = treatmentsQuerySnaps.docs;
      for (var treatmentQuery in treatmentsDocs) {
        var data = treatmentQuery.data();
        data['id'] = treatmentQuery.id;
        Treatment treatment = Treatment.fromJson(data);
        services.add(treatment);
      }
    }
    return services;
  }

  static Future<List<TreatmentCategory>> getTreatmentCategories() async {
    List<TreatmentCategory> treatmentCategories = <TreatmentCategory>[];
    var query = await FirebaseFirestore.instance
        .collection('treatment_categories')
        .get();
    var listDocs = query.docs;
    for (var doc in listDocs) {
      var docData = doc.data();
      docData['id'] = doc.id;
      treatmentCategories.add(TreatmentCategory.fromJson(docData));
    }

    return treatmentCategories;
  }

  static Future<Stream<List<Treatment>>> getTreatmentsFiltered(
      String uid) async {
    // ignore: unused_local_variable
    List<Treatment> services = <Treatment>[];
    var clientDocSnapshot = await FirebaseFirestore.instance
        .collection('client_memberships')
        .doc(uid)
        .get();

    var membershipDoc = clientDocSnapshot.data();
    var membershipId = membershipDoc!['membership_type_id'];

    return FirebaseFirestore.instance
        .collection('treatments')
        .where('membership_type_id', isEqualTo: membershipId)
        .snapshots()
        .map((querySnapshot) {
      List<Treatment> treatments = [];
      for (var documentQuery in querySnapshot.docs) {
        var data = documentQuery.data();
        data['id'] = documentQuery.id;
        treatments.add(Treatment.fromJson(data));
      }
      return treatments;
    });
  }

  static Future<String> getDownloadUrl(String reference) async {
    var ref = FirebaseStorage.instance.ref().child(reference);
    return await ref.getDownloadURL();
  }

  static Future<List<Consultation>> getConsultations(String id) async {
    List<Consultation> consultations = [];
    var userQuery =
        await FirebaseFirestore.instance.collection('clients').doc(id).get();
    var user = userQuery.data();
    if (user?['isAdmin']) {
      var query =
          await FirebaseFirestore.instance.collection('consultations').get();
      var docs = query.docs;
      for (var doc in docs) {
        var data = doc.data();
        consultations.add(Consultation.fromJson(data));
      }
      return consultations;
    }
    var query = await FirebaseFirestore.instance
        .collection('consultations')
        .where('client_id', isEqualTo: id)
        .get();
    var docs = query.docs;
    for (var doc in docs) {
      var data = doc.data();
      consultations.add(Consultation.fromJson(data));
    }
    return consultations;
  }

  Future<List<String>> fetchUserIdz(String conditionString) async {
    final List<String> clientIds = [];
    var query = FirebaseFirestore.instance
        .collection('clients')
        .where('isAdmin', isEqualTo: conditionString == 'admin');
    var snapshot = await query.get();
    for (var element in snapshot.docs) {
      clientIds.add(element.id);
    }
    return clientIds;
  }
}
