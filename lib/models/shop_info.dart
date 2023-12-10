class ShopInfo {
  String? email;
  String? telephone;
  String? phoneNumber;
  String? description;
  List<OpeningHours>? openingHours;

  ShopInfo(
      {this.email,
      this.telephone,
      this.phoneNumber,
      this.description,
      this.openingHours});

  ShopInfo.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    telephone = json['telephone'];
    phoneNumber = json['phone_number'];
    description = json['description'];
    if (json['opening_hours'] != null) {
      openingHours = <OpeningHours>[];
      json['opening_hours'].forEach((v) {
        openingHours!.add(OpeningHours.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['telephone'] = telephone;
    data['phone_number'] = phoneNumber;
    data['description'] = description;
    if (openingHours != null) {
      data['opening_hours'] = openingHours!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OpeningHours {
  String? day;
  String? openingTime;
  String? closingTime;

  OpeningHours({this.day, this.openingTime, this.closingTime});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['opening_time'] = openingTime;
    data['closing_time'] = closingTime;
    return data;
  }
}
