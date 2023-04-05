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
        openingHours!.add(new OpeningHours.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['phone_number'] = this.phoneNumber;
    data['description'] = this.description;
    if (this.openingHours != null) {
      data['opening_hours'] =
          this.openingHours!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    return data;
  }
}
