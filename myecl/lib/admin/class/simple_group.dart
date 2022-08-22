class SimpleGroup {
  SimpleGroup({
    required this.name,
    required this.description,
    required this.id,
  });
  late final String name;
  late final String description;
  late final String id;

  SimpleGroup.fromJson(Map<String, dynamic> json) {
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

  SimpleGroup copyWith({
    name,
    description,
    id,
  }) =>
      SimpleGroup(
        name: name ?? this.name,
        description: description ?? this.description,
        id: id ?? this.id,
      );

  SimpleGroup.empty() {
    name = 'Nom';
    description = 'Description';
    id = '';
  }
}
