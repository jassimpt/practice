class NamesModel {
  String? name;
  String? id;
  NamesModel({required this.name, this.id});

  factory NamesModel.fromJson(Map<String, dynamic> json) {
    return NamesModel(name: json['name'], id: json["id"]);
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }
}
