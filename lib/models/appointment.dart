import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Appointment {
  String? id;
  String? date;
  String? time;
  String? number;
  String? email;
  String? notes;
  String? startTime;
  String? endTime;
  List<String>? employeeId;
  List<String>? serviceId;
  String? clientId;
  String? statusId;
  Timestamp? dateTimestamp;
  List<String>? roomId;
  num? duration;
  bool? isRegular;
  Appointment({
    this.id,
    this.date,
    this.number,
    this.email,
    this.notes,
    this.employeeId,
    this.serviceId,
    this.clientId,
    this.roomId,
    this.statusId,
    this.dateTimestamp,
    this.startTime,
    this.endTime,
    this.duration,
    this.isRegular,
  });

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    number = json['number'];
    email = json['email'];
    notes = json['notes'];
    employeeId = json['employee_id_list'].cast<String>();
    serviceId = json['treatment_id_list'].cast<String>();
    roomId = json['room_id_list'].cast<String>();
    clientId = json['client_id'];
    statusId = json['status_id'];
    dateTimestamp = json['date_timestamp'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    duration = json['total_duration'];
    isRegular = json['is_regular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['time'] = time;
    data['number'] = number;
    data['email'] = email;
    data['notes'] = notes;
    data['employee_id_list'] = employeeId;
    data['treatment_id_list'] = serviceId;
    data['client_id'] = clientId;
    data['status_id'] = statusId;
    data['date_timestamp'] = dateTimestamp;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['room_id_list'] = roomId;
    data['total_duration'] = duration;
    data['is_regular'] = isRegular;
    return data;
  }

  String get dateString {
    var date = DateTime.fromMillisecondsSinceEpoch(
            dateTimestamp!.millisecondsSinceEpoch)
        .toLocal();
    // dateTimestamp?.toDate().toUtc() ?? DateTime.now();
    return DateFormat("MM/dd/yyyy").format(date);
  }

  String get dateWithMonthName {
    var date = DateTime.fromMillisecondsSinceEpoch(
            dateTimestamp!.millisecondsSinceEpoch)
        .toLocal();
    // dateTimestamp?.toDate().toUtc() ?? DateTime.now();
    return DateFormat("dd MMM").format(date);
  }
}
