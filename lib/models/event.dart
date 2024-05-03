import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Event {
  String? eventId;
  String? address;
  List<String>? clientId;
  String? date;
  Timestamp? dateTimstamp;
  Timestamp? startTimeStamp;
  Timestamp? endTimeStamp;
  String? desc;
  String? duration;
  String? endTime;
  String? image;
  String? imageUrl;
  String? startTime;
  String? subtitle;
  String? title;
  double? longitude;
  double? latitude;
  bool? isfavorite;

  Event(
      {this.eventId,
      this.dateTimstamp,
      this.address,
      this.clientId,
      this.date,
      this.startTimeStamp,
      this.endTimeStamp,
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
    clientId = json['client_id']?.cast<String>();
    date = json['date'].toString();
    desc = json['desc'];
    dateTimstamp = json['date_timestamp'];
    startTimeStamp = json['start_timestamp'];
    endTimeStamp = json['end_timestamp'];
    duration = json['duration'];
    endTime = json['end_time'];
    image = json['image'];
    imageUrl = json['image_url'];
    startTime = json['start_time'];
    subtitle = json['subtitle'];
    title = json['title'];
    longitude = double.parse(json['longitude'].toString());
    latitude = double.parse(json['latitude'].toString());
    isfavorite = json['isfavorite'];
  }

  Event.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    address = json['address'];
    clientId = json['client_id']?.cast<String>();
    date = json['date'].toString();
    dateTimstamp = json['date_timestamp'];
    startTimeStamp = json['start_timestamp'];
    endTimeStamp = json['end_timestamp'];
    desc = json['desc'];
    duration = json['duration'];
    endTime = json['end_time'];
    image = json['image'];
    imageUrl = json['image_url'];
    startTime = json['start_time'];
    subtitle = json['subtitle'];
    title = json['title'];
    longitude = json['longitude']==''?double.parse('00.0') :double.parse(json['longitude'].toString());
    latitude = json['latitude']==''?double.parse('00.0') :double.parse(json['latitude'].toString());
    isfavorite = json['isfavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['client_id'] = clientId;
    data['date_timestamp'] = dateTimstamp;
    data['start_timestamp'] = startTimeStamp;
    data['end_timestamp'] = endTimeStamp;
    data['date'] = date;
    data['desc'] = desc;
    data['duration'] = duration;
    data['end_time'] = endTime;
    data['image'] = image;
    data['image_url'] = imageUrl;
    data['start_time'] = startTime;
    data['subtitle'] = subtitle;
    data['title'] = title;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }

  String get dateString {
    String date = '';
    final dateTime = dateTimstamp?.toDate() ?? DateTime.now();
    date = DateFormat("dd/MM/yyyy").format(dateTime);
    return date;
  }

  String get endTimeString {
    final dateTime = endTimeStamp?.toDate() ?? DateTime.now();
    return DateFormat("hh:mm aa").format(dateTime);
  }

  String get startTimeString {
    final dateTime = startTimeStamp?.toDate() ?? DateTime.now();
    return DateFormat("hh:mm aa").format(dateTime);
  }

  String get durationString {
    final startTime = startTimeStamp?.toDate() ?? DateTime.now();
    final endTime = endTimeStamp?.toDate() ?? DateTime.now();

    final startingHour = int.parse(DateFormat("hh").format(startTime));
    final endTimeHour = int.parse(DateFormat("hh").format(endTime));
    return '${endTimeHour - startingHour} hrs';
  }
}
