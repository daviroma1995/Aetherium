class Treatment {
  String? id;
  String? treatmentCategoryId;
  String? name;
  String? price;
  String? duration;
  bool? isLimited;
  List<String>? availableDays;
  bool? isEmployeeRequired;

  Treatment(
      {this.id,
      this.treatmentCategoryId,
      this.name,
      this.price,
      this.duration,
      this.isLimited,
      this.availableDays,
      this.isEmployeeRequired});

  Treatment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    treatmentCategoryId = json['treatment_category_id'];
    name = json['name'];
    price = json['price'];
    duration = json['duration'];
    isLimited = json['isLimited'];
    availableDays = json['availableDays'].cast<String>();
    isEmployeeRequired = json['isEmployeeRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['treatment_category_id'] = this.treatmentCategoryId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['isLimited'] = this.isLimited;
    data['availableDays'] = this.availableDays;
    data['isEmployeeRequired'] = this.isEmployeeRequired;
    return data;
  }
}
