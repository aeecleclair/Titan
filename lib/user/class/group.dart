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
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['description'] = description;
    _data['id'] = id;
    return _data;
  }
}
