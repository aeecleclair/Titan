class Section {
  late String id;
  late String name;
  late String description;
  Section({required this.id, required this.name, required this.description});

  Section copyWith({
    String? id,
    String? name,
    String? logoPath,
    String? description,
  }) {
    return Section(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }

  factory Section.fromJson(Map<String, dynamic> map) {
    return Section(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  Section.empty() {
    id = '';
    name = '';
    description = '';
  }

  @override
  String toString() {
    return 'Section{id: $id, name: $name, description: $description}';
  }
}
