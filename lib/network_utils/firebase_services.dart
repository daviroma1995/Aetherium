import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/event.dart';
import '../screens/login_screen/login_screen.dart';

class FirebaseSerivces {
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
        list.add(queryDocumentSnapshot.data());
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
    return FirebaseFirestore.instance
        .collection('events')
        .snapshots()
        .map((event) {
      List<Event> listEvents = [];
      event.docs.forEach((element) {
        var data = element.data();
        data['event_id'] = element.id;
        listEvents.add(Event.fromJson(data));
      });
      return listEvents;
    });
  }
}
