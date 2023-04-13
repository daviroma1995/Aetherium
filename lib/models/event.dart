import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? eventId;
  String? address;
  List<String>? clientId;
  String? date;
  String? desc;
  String? duration;
  String? endTime;
  String? image;
  String? imageUrl;
  String? startTime;
  String? subtitle;
  String? title;
  int? longitude;
  int? latitude;
  bool? isfavorite;

  Event(
      {this.eventId,
      this.address,
      this.clientId,
      this.date,
      this.desc,
      this.duration,
      this.endTime,
      this.image,
      this.imageUrl,
      this.startTime,
      this.subtitle,
      this.title,
      this.longitude,
      this.latitude,
      this.isfavorite});

  Event.fromDocumentSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    eventId = json['event_id'];
    address = json['address'];
    clientId = json['client_id'].cast<String>();
    date = json['date'];
    desc = json['desc'];
    duration = json['duration'];
    endTime = json['end_time'];
    image = json['image'];
    imageUrl = json['image_url'];
    startTime = json['start_time'];
    subtitle = json['subtitle'];
    title = json['title'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    isfavorite = json['isfavorite'];
  }

  Event.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    address = json['address'];
    clientId = json['client_id'].cast<String>();
    date = json['date'];
    desc = json['desc'];
    duration = json['duration'];
    endTime = json['end_time'];
    image = json['image'];
    imageUrl = json['image_url'];
    startTime = json['start_time'];
    subtitle = json['subtitle'];
    title = json['title'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    isfavorite = json['isfavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['client_id'] = this.clientId;
    data['date'] = this.date;
    data['desc'] = this.desc;
    data['duration'] = this.duration;
    data['end_time'] = this.endTime;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    data['start_time'] = this.startTime;
    data['subtitle'] = this.subtitle;
    data['title'] = this.title;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
