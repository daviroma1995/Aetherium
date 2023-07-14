// ignore_for_file: avoid_print, unused_local_variable

import 'dart:developer';

import 'package:atherium_saloon_app/models/membership.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/client_details_screen/client_details_screen.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:atherium_saloon_app/screens/services_screen/services_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/client.dart';
import '../../models/membership_type.dart';

class SelectClientController extends GetxController {
  var args = Get.arguments;
  var clients = <Client>[].obs;
  var selectedClients = <String>[];
  var searchedClients = <Client>[].obs;
  var tier = <MembershipType>[].obs;
  RxString searchText = ''.obs;
  RxBool isLoaded = false.obs;
  TextEditingController search = TextEditingController();
  RxString email = ''.obs;
  RxString phone = ''.obs;
  @override
  void onInit() async {
    super.onInit();
    // var data = await FirebaseServices.getData(collection: 'clients');
    // for (var client in data!) {
    //   if (client['isAdmin'] != true) {
    //     clients.add(Client.fromJson(client));
    //   }
    // }
    /*  var tempClients = <Client>[].obs;
    var tiers = <MembershipType>[].obs;
    await FirebaseFirestore.instance
        .collection('clients')
        .get()
        .then((value) async {
      var clientData = value.docs;
      for (var client in clientData) {
        var clientData = client.data();
        if (clientData['isAdmin'] != true) {
          var clientData = client.data();
          clientData['id'] = clientData['user_id'];
          tempClients.add(Client.fromJson(clientData));
          var data = await FirebaseFirestore.instance
              .collection('client_memberships')
              .doc(client.id)
              .get()
              .then((value) {
            var map = value.data();
            var membershipTypeId = map!['membership_type_id'];
            return FirebaseFirestore.instance
                .collection('membership_type')
                .doc(membershipTypeId)
                .get();
          });
          var map = data.data();
          tiers.add(MembershipType.fromJson(map!));
        }
      }
    });
 */
    // for (var client in clients) {
    // var data = await FirebaseFirestore.instance
    //     .collection('client_memberships')
    //     .doc(client.id!)
    //     .get()
    //     .then((value) {
    //   var map = value.data();
    //   var membershipTypeId = map!['membership_type_id'];
    //   return FirebaseFirestore.instance
    //       .collection('membership_type')
    //       .doc(membershipTypeId)
    //       .get();
    // });
    // var map = data.data();
    // tiers.add(MembershipType.fromJson(map!));
    // }
    // tier.value = tiers;
/*     clients.value = tempClients;
    tier.value = tiers;
    isLoaded.value = !isLoaded.value;
 */

    loadUsers();
  }

  void loadUsers() async {
    try {
      var apis = ["clients", "client_memberships", "membership_type"];
      var collections =
          apis.map((e) => FirebaseFirestore.instance.collection(e).get());
      var results = await Future.wait(collections);
      var firebaseClients =
          results[0].docs.map((e) => Client.fromJson(e.data())).toList();
      for (var client in firebaseClients) {
        if (client.isAdmin == false) {
          clients.add(client);
        }
      }
      var data =
          results[1].docs.map((e) => Membership.fromJson(e.data())).toList();
      var tiers = results[2]
          .docs
          .map((e) => MembershipType.fromJson(e.data()))
          .toList();
      for (var membership in data) {
        for (var membershipType in tiers) {
          if (membership.membershipTypeId == membershipType.id &&
              membership.clientId != FirebaseServices.cuid) {
            tier.add(membershipType);
          }
        }
      }
      isLoaded.value = !isLoaded.value;
    } on Exception catch (e) {
      print(e);
    }
  }

  void onTap(int index) {
    selectedClients = [];
    selectedClients.add(clients[index].userId!);
    isLoaded.value = !isLoaded.value;
    email.value = clients[index].email!;
    phone.value = clients[index].phoneNumber!;

    print(selectedClients);
  }

  void getClientDetails(int index) {
    Get.to(
      () => ClientDetailsScreen(
        client: clients[index],
      ),
      duration: const Duration(milliseconds: 300),
      transition: Transition.downToUp,
      arguments: clients[index].userId,
    );
  }

  void goToServicesScreen() {
    if (selectedClients.isNotEmpty) {
      Get.to(
        () => ServicesScreen(
          uid: selectedClients[0],
          clientEmail: email.value,
          number: phone.value,
        ),
        arguments: args,
      );
    } else {
      Fluttertoast.showToast(msg: 'Please select a client to continiue');
    }
  }

  Future<void> longPress(int id) async {
    var uid = clients[id].userId;
    var email = clients[id].email;
    await FirebaseFirestore.instance
        .collection('appointments')
        .where('client_id', isEqualTo: uid)
        .get()
        .then((event) async {
      for (var element in event.docs) {
        await FirebaseFirestore.instance
            .collection('appointments')
            .doc(element.id)
            .delete();
      }
    });
    await FirebaseFirestore.instance.collection('clients').doc(uid).delete();
    await FirebaseFirestore.instance
        .collection('client_memberships')
        .doc(uid)
        .delete();
    var client = http.Client();
    var response = await client.post(
        Uri.parse(
            'https://us-central1-aetherium-salon.cloudfunctions.net/deleteUser'),
        body: {"uid": uid});
    var data = response.body;
    log(data.toString());
  }
}
