// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  // TODO
  void handleBack() {
    Get.back();
  }
}

class Notification {
  final String title;
  final String message;
  final String date;
  final String time;
  Notification({
    required this.title,
    required this.message,
    required this.date,
    required this.time,
  });
}

List<Notification> notifications = [
  Notification(
    date: '19 May 2022',
    title: 'Notification Title',
    message:
        'This is a new notification explaining new shop timetable and new servicesa and treatment ',
    time: '10:16',
  ),
  Notification(
    date: '19 May 2022',
    title: 'Notification Title',
    message:
        'This is a new notification explaining new shop timetable and new servicesa and treatment ',
    time: '10:16',
  ),
];
