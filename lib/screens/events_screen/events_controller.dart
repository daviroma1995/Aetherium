import 'dart:io';

import 'package:atherium_saloon_app/models/client.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/utils/image_picker.dart';
import 'package:atherium_saloon_app/utils/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import '../../models/event.dart';
import '../../network_utils/firebase_services.dart';
import '../event_details/event_details_screen.dart';

import 'package:flutter/material.dart';

class EventsController extends GetxController {
  RxList<Event> events = <Event>[].obs;
  RxBool shouldUpdate = false.obs;
  List<String> inviteIds = [];
  Rx<DateTime> startTime = DateTime.now().obs;
  Rx<DateTime> endTime = DateTime.now().obs;
  Rx<String> eventImage = ''.obs;
  Rx<String> imageFileString = ''.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  final eventDate = DateTime.now().obs;
  RxBool isUpdating = false.obs;
  RxBool isLoading = false.obs;
  RxList<Client> selectedClients = <Client>[].obs;

  @override
  void onInit() async {
    super.onInit();
    events.value = await Get.arguments;
  }

  RxBool titleControllerHasError = false.obs;
  RxBool subTitleControllerHasError = false.obs;
  RxBool descriptionControllerHasError = false.obs;
  RxBool placeControllerHasError = false.obs;
  RxBool latitudeControllerHasError = false.obs;
  RxBool longitudeControllerHasError = false.obs;
  RxBool startTimeHasError = false.obs;
  RxBool endTimeHasError = false.obs;

  RxString titleControllerErrorMessage = ''.obs;
  RxString subTitleControllerErrorMessage = ''.obs;
  RxString descriptionControllerErrorMessage = ''.obs;
  RxString placeControllerErrorMessage = ''.obs;
  RxString latitudeControllerErrorMessage = ''.obs;
  RxString longitudeControllerErrorMessage = ''.obs;
  RxString startTimeErrorMessage = ''.obs;
  RxString endTimeErrorMessage = ''.obs;

  void validateTitle() {
    if (titleController.text.isEmpty) {
      titleControllerHasError.value = true;
      titleControllerErrorMessage.value = tr('title_is_required');
    } else {
      titleControllerHasError.value = false;
      titleControllerErrorMessage.value = '';
    }
  }

  void validateSubtitle() {
    if (subTitleController.text.isEmpty) {
      subTitleControllerHasError.value = true;
      subTitleControllerErrorMessage.value = tr('subtitle_is_required');
    } else {
      subTitleControllerHasError.value = false;
      subTitleControllerErrorMessage.value = '';
    }
  }

  void validateDescription() {
    if (descriptionController.text.isEmpty) {
      descriptionControllerHasError.value = true;
      descriptionControllerErrorMessage.value = tr('description_is_required');
    } else {
      descriptionControllerHasError.value = false;
      descriptionControllerErrorMessage.value = '';
    }
  }

  void validatePlace() {
    if (placeController.text.isEmpty) {
      placeControllerHasError.value = true;
      placeControllerErrorMessage.value = tr('place_is_required');
    } else {
      placeControllerHasError.value = false;
      placeControllerErrorMessage.value = '';
    }
  }

  void validateStartTime() {
    if (startTime.value == DateTime.now()) {
      startTimeHasError.value = true;
      startTimeErrorMessage.value = tr('start_time_is_required');
    } else {
      startTimeHasError.value = false;
      startTimeErrorMessage.value = '';
    }
  }

  void validateEndTime() {
    if (isEndTimeSmallerThanStartTime(startTime.value, endTime.value)) {
      print("arived at end time");
      endTimeHasError.value = true;
      endTimeErrorMessage.value =
          tr('end_date_cannot_be_smaller_than_start_date');
    } else {

      endTimeHasError.value = false;
      endTimeErrorMessage.value = '';
    }
  }

  void handleBack() {
    Get.back(result: 'update');
  }

  void setFavorite(int index) async {
    final uid = FirebaseServices.cuid;
    if (events[index].isfavorite == true) {
      events[index].clientId!.removeWhere((element) => element == uid);
    } else {
      events[index].clientId!.add(uid);
    }
    FirebaseServices.toggleFavorite(
        eventId: events[index].eventId!, data: events[index]);
    events[index].isfavorite = !events[index].isfavorite!;
  }

  void goToDetails(int index) async {
    final result = await Get.to(
      () => EventDetailsScreen(),
      duration: const Duration(milliseconds: 600),
      transition: Platform.isIOS ? null : Transition.downToUp,
      arguments: events[index],
    );
    if (result != null) {
      if (shouldUpdate.value == true) {
        shouldUpdate.value = false;
      } else {
        shouldUpdate.value = true;
      }
    }
  }

  void addEvent() async {
    isLoading.value = true;
    try {
      List<String> clientIds = [];
      for (var client in selectedClients) {
        clientIds.add(client.id!);
      }
      final Reference ref =
          FirebaseStorage.instance.ref().child('events/${DateTime.now()}.png');
      final UploadTask uploadTask = ref.putFile(File(imageFileString.value));
      final TaskSnapshot snapshot = await uploadTask;
      eventImage.value = await snapshot.ref.getDownloadURL();
      FirebaseFirestore.instance.collection('testEvents').doc().set({
        'title': titleController.text,
        'subtitle': subTitleController.text,
        'desc': descriptionController.text,
        'latitude': latitudeController.text,
        'longitude': longitudeController.text,
        'address': placeController.text,
        'image_url': eventImage.value,
        'date': startTime.value,
        'date_timestamp': startTime.value,
        'start_timestamp': startTime.value,
        'end_timestamp': endTime.value,
        'startTime':
            '${startTime.value.hour.toString().padLeft(2, '0')}:${startTime.value.minute.toString().padLeft(2, '0')}',
        'endTime':
            '${endTime.value.hour.toString().padLeft(2, '0')}:${endTime.value.minute.toString().padLeft(2, '0')}',
        'clientId': clientIds,
      }).then((value) {
        Fluttertoast.showToast(
            msg: tr('event_successfully_added'),
            backgroundColor: AppColors.GREEN_COLOR);
        Get.back();
        _clearFields();
      });
    } catch (e) {
      print("error is:${e.toString()}");
      isLoading.value = false;
    }
  }

  void pickImageFromMobile(context) async {
    var image = await kImagePicker(context);
    if (image == null) {
      return;
    } else {
      imageFileString.value = image.path;
      LocalData.setImageUrlString(image.path);
      isUpdating.value = !isUpdating.value;
    }
  }

  String get getEventDate {
    final day = eventDate.value.day < 10
        ? '0${eventDate.value.day}'
        : eventDate.value.day.toString();
    final month = eventDate.value.month < 10
        ? '0${eventDate.value.month}'
        : eventDate.value.month.toString();
    return '$day/$month/${eventDate.value.year}';
  }

  DateTime selectedDateTime = DateTime.now();

  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    // final TimeOfDay? pickedTime = await showTimePicker(
    //   context: context,
    //   initialTime: TimeOfDay.now(),
    // );
    //
    // if (pickedTime != null) {
    //   if (isStartTime) {
    //     startTime.value = formatTimeOfDay(pickedTime);
    //   } else {
    //     endTime.value = formatTimeOfDay(pickedTime);
    //   }
    // }
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        if (isStartTime) {
          startTime.value = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        } else {
          endTime.value = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        }
      }
    }
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  bool isEndTimeSmallerThanStartTime(
      DateTime startDateTime, DateTime endDateTime) {
    return
      endDateTime.isBefore(startDateTime);
  }

  _clearFields() {
    titleController.clear();
    latitudeController.clear();
    longitudeController.clear();
    placeController.clear();
    selectedClients.value = [];
    update();
  }
}
