import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailsControlelr extends GetxController {
  RxBool isfavorite = false.obs;
  // ignore: prefer_typing_uninitialized_variables
  var args;
  late String uid;
  @override
  void onInit() async {
    args = Get.arguments;
    isfavorite.value = args.isfavorite;
    uid = await FirebaseServices.checkUserUid();
    super.onInit();
  }

  void handleBack(BuildContext context) {
    // Get.to( BottomNavigationScreen(),
    //     duration: const Duration(milliseconds: 600),
    //     transition: Transition.upToDown,
    //     curve: Curves.easeIn);
    // Navigator.pop(context);
    Get.back(result: args.isfavorite);
  }

  void setFavorite() async {
    if (args.isfavorite == true) {
      args.clientId!.removeWhere((element) => element == uid);
    } else {
      args.clientId!.add(uid);
    }
    FirebaseServices.toggleFavorite(eventId: args.eventId!, data: args);
    args.isfavorite = !args.isfavorite;

    isfavorite.value = !isfavorite.value;
  }

  String getTime(String time) {
    String formatedTime = '';
    for (int index = 0; index < 2; index++) {
      formatedTime += time[index];
    }
    if (int.parse(formatedTime) <= 12) {
      time = '$time AM';
    } else {
      // ignore: unnecessary_string_interpolations
      time = '$time';
    }
    return time;
  }
}
