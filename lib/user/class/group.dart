class Groups {
  Groups({
    required this.name,
    required this.description,
    required this.id,
  });
  late final String name;
  late final String description;
  late final String id;

  Groups.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['id'] = id;
    return data;
  }

  @override
  String toString() {
    return "Groups {name: $name, description: $description, id: $id}";
  }
}
