import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Notification {
  final String id;
  final String desc;
  final String status;
  final String title;
  final Timestamp date;

  Notification(
      {required this.id,
      required this.desc,
      required this.status,
      required this.title,
      required this.date});

  factory Notification.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Notification(
      id: doc.id,
      desc: data['desc'] ?? '',
      status: data['status'] ?? '',
      title: data['title'] ?? '',
      date: data['date'] ?? Timestamp.now(),
    );
  }

  String get getDate {
    DateTime dateTime = date.toDate();
    return DateFormat('dd MMM yyyy, hh:mm').format(dateTime);
  }
}
