import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Appointment {
  String? id;
  String? date;
  String? time;
  String? number;
  String? email;
  String? notes;
  List<String>? employeeId;
  List<String>? serviceId;
  String? clientId;
  String? statusId;
  Timestamp? dateTimestamp;
  Appointment({
    this.id,
    this.date,
    this.time,
    this.number,
    this.email,
    this.notes,
    this.employeeId,
    this.serviceId,
    this.clientId,
    this.statusId,
    this.dateTimestamp,
  });

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    number = json['number'];
    email = json['email'];
    notes = json['notes'];
    employeeId = json['employee_id_list'].cast<String>();
    serviceId = json['service_id_list'].cast<String>();
    clientId = json['client_id'];
    statusId = json['status_id'];
    dateTimestamp = json['date_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['time'] = time;
    data['number'] = number;
    data['email'] = email;
    data['notes'] = notes;
    data['employee_id_list'] = employeeId;
    data['service_id_list'] = serviceId;
    data['client_id'] = clientId;
    data['status_id'] = statusId;
    data['date_timestamp'] = dateTimestamp;
    return data;
  }

  String get dateString {
    var date = dateTimestamp?.toDate() ?? DateTime.now();
    return DateFormat("MM/dd/yyyy").format(date);
  }

  String get dateWithMonthName {
    var date = dateTimestamp?.toDate() ?? DateTime.now();
    return DateFormat("dd MMMM").format(date);
  }
}
