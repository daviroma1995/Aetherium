class Consultation {
  String? id;
  List<String>? filePathList;
  Consultation(this.id, this.filePathList);
  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      json['id'],
      json['file_path_list'].cast<String>(),
    );
  }
}
