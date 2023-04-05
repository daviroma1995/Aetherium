class Event {
  String? id;
  String? title;
  String? desc;
  String? date;
  String? startTime;
  String? endTime;
  String? duration;
  String? address;
  String? imageUrl;
  int? longitude;
  int? latitude;
  bool? isFavorite;

  Event(
      {this.id,
      this.title,
      this.desc,
      this.date,
      this.startTime,
      this.endTime,
      this.duration,
      this.address,
      this.imageUrl,
      this.longitude,
      this.latitude,
      this.isFavorite});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    duration = json['duration'];
    address = json['address'];
    imageUrl = json['imageUrl'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['duration'] = this.duration;
    data['address'] = this.address;
    data['imageUrl'] = this.imageUrl;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['isFavorite'] = this.isFavorite;
    return data;
  }
}
