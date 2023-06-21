class Treatment {
  String? id;
  String? desc;
  String? treatmentCategoryId;
  String? name;
  String? price;
  String? duration;
  bool? isLimited;
  List<String>? availableDays;
  bool? isEmployeeRequired;

  Treatment({
    this.id,
    this.treatmentCategoryId,
    this.name,
    this.price,
    this.duration,
    this.isLimited,
    this.availableDays,
    this.isEmployeeRequired,
    this.desc,
  });

  Treatment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    treatmentCategoryId = json['treatment_category_id'];
    name = json['name'];
    desc = json['desc'];
    price = json['price'].toString();
    duration = json['duration'].toString();
    isLimited = json['isLimited'];
    isEmployeeRequired = json['isEmployeeRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['desc'] = desc;
    data['treatment_category_id'] = treatmentCategoryId;
    data['name'] = name;
    data['price'] = price;
    data['duration'] = duration;
    data['isLimited'] = isLimited;
    data['isEmployeeRequired'] = isEmployeeRequired;
    return data;
  }
}
