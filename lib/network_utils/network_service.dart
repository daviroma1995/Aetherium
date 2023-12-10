import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/appointment.dart';
import '../models/appointment_status.dart';
import '../models/client.dart';
import '../models/employee.dart';
import '../models/event.dart';
import '../models/membership.dart';
import '../models/membership_type.dart';
import '../models/room.dart';
import '../models/shop_info.dart';
import '../models/treatment.dart';
import '../models/treatment_category.dart';

class NetworkService {
  static Future loadJson(String fileName) async {
    var jsonData = await rootBundle.loadString('data/$fileName.json');
    final data = json.decode(jsonData);
    return data;
  }

  static Future<List> getAvailableSlots() async {
    List<dynamic> data = await loadJson('appointment_available_timeslot');
    return data;
  }

  static Future<List<Appointment>> getAppoitnemntsList() async {
    var data = await loadJson('appointment_list');

    List<Appointment> appointmentList =
        data.map<Appointment>((json) => Appointment.fromJson(json)).toList();
    return appointmentList;
  }

  static Future<List<AppointmentStatus>> getAppointmentStatusList() async {
    var data = await loadJson('appointment_status_list');
    List<AppointmentStatus> appointmentStatusList = data
        .map<AppointmentStatus>((json) => AppointmentStatus.fromJson(json))
        .toList();
    return appointmentStatusList;
  }

  static Future<List<Client>> getClientsList() async {
    var data = await loadJson('client_list');
    List<Client> clientList =
        data.map<Client>((json) => Client.fromJson(json)).toList();
    return clientList;
  }

  static Future<List<Employee>> getEmployeeList() async {
    var data = await loadJson('employee_list');
    List<Employee> employeeList =
        data.map<Employee>((json) => Employee.fromJson(json)).toList();
    return employeeList;
  }

  static Future<List<Event>> getEventsList() async {
    var data = await loadJson('event_list');
    List<Event> eventList =
        data.map<Event>((json) => Event.fromJson(json)).toList();
    return eventList;
  }

  static Future<List<MembershipType>> getMembershipTypesList() async {
    var data = await loadJson('membership_type_list');
    List<MembershipType> membershipTypeList = data
        .map<MembershipType>((json) => MembershipType.fromJson(json))
        .toList();
    return membershipTypeList;
  }

  static Future<List<Membership>> getMembershipList() async {
    var data = await loadJson('membership_list');
    List<Membership> membershipList =
        data.map<Membership>((json) => Membership.fromJson(json)).toList();
    return membershipList;
  }

  static Future<List<Room>> getRoomList() async {
    var data = await loadJson('room_list');
    List<Room> roomList =
        data.map<Room>((json) => Room.fromJson(json)).toList();
    return roomList;
  }

  static Future<List<ShopInfo>> getShopInfo() async {
    var data = await loadJson('shop_info');
    List<ShopInfo> shopInfo =
        data.map<ShopInfo>((json) => ShopInfo.fromJson(json)).toList();
    return shopInfo;
  }

  static Future<List<TreatmentCategory>> getTreatmentCategoryList() async {
    var data = await loadJson('treatment_category');
    List<TreatmentCategory> treatmentCategoryList = data
        .map<TreatmentCategory>((json) => TreatmentCategory.fromJson(json))
        .toList();
    return treatmentCategoryList;
  }

  static Future<List<Treatment>> getTreatmentsList() async {
    var data = await loadJson('treatment_list');
    List<Treatment> treatmentCategoryList =
        data.map<Treatment>((json) => Treatment.fromJson(json)).toList();
    return treatmentCategoryList;
  }
}
