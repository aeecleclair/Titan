class Tag {
  late final String id;
  late final String name;

  Tag({required this.id, required this.name});

  Tag.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }

  Tag copyWith({String? id, String? name}) {
    return Tag(id: id ?? this.id, name: name ?? this.name);
  }

  static Tag empty() {
    return Tag(id: "", name: "");
  }

  @override
  String toString() {
    return 'Tag{id: $id, name: $name}';
  }
}
