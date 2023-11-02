class Policies {
  String? filePath;
  String? name;

  Policies({this.filePath, this.name});

  factory Policies.fromJson(Map<String, dynamic> json) {
    return Policies(
      filePath: json['file_path'],
      name: json['name'],
    );
  }
}
