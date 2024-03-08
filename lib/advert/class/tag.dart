class Tag {
  late final String id;
  late final String name;

  Tag({required this.id, required this.name});

  Tag.fromJson(Map<String, dynamic> json) {
    id = json["id"] as String;
    name = json["name"] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }

  Tag copyWith({String? id, String? name}) =>
      Tag(id: id ?? this.id, name: name ?? this.name);

  static Tag empty() {
    return Tag(id: "", name: "");
  }

  @override
  String toString() {
    return 'Tag{id: $id, name: $name}';
  }
}
