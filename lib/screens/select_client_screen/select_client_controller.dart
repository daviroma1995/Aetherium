import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/client_details_screen/client_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/client.dart';

class SelectClientController extends GetxController {
  var clients = <Client>[].obs;
  var selectedClients = <String>[];
  var searchedClients = <Client>[].obs;
  RxString searchText = ''.obs;
  RxBool isLoaded = false.obs;
  TextEditingController search = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    var data = await FirebaseServices.getData(collection: 'clients');
    for (var client in data!) {
      if (client['isAdmin'] != true) {
        clients.add(Client.fromJson(client));
      }
    }
    isLoaded.value = !isLoaded.value;
  }

  void onTap(int index) {
    selectedClients = [];
    selectedClients.add(clients[index].firstName!);
    isLoaded.value = !isLoaded.value;
    print(index);
  }

  void getClientDetails(int index) {
    Get.to(
      () => ClientDetailsScreen(
        client: clients[index],
      ),
      duration: const Duration(milliseconds: 300),
      transition: Transition.downToUp,
      arguments: clients[index].id,
    );
  }
}
