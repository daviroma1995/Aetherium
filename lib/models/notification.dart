import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

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
      date: data['createdAt'] ?? Timestamp.now(),
    );
  }

  String get getDate {
    DateTime dateTime = date.toDate();
    var month = DateFormat('MMM').format(dateTime);
    month = tr(month);
    final day = DateFormat('dd').format(dateTime);
    final year = DateFormat('yyyy').format(dateTime);
    final time = DateFormat('hh:mm').format(dateTime);

    return '$day $month $year, $time';
  }
}
