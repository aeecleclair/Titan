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
    final data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['id'] = id;
    return data;
  }

  SimpleGroup copyWith({String? name, String? description, String? id}) =>
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

  @override
  String toString() {
    return 'SimpleGroup(name: $name, description: $description, id: $id)';
  }
}
