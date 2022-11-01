class Section {
  late String id;
  late String name;
  late String logoPath;
  late String description;
  Section({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.description,
  });

  Section copyWith({
    String? id,
    String? name,
    String? logoPath,
    String? description,
  }) {
    return Section(
      id: id ?? this.id,
      name: name ?? this.name,
      logoPath: logoPath ?? this.logoPath,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logoPath': logoPath,
      'description': description,
    };
  }

  factory Section.fromJson(Map<String, dynamic> map) {
    return Section(
      id: map['id'],
      name: map['name'],
      logoPath: map['logoPath'],
      description: map['description'],
    );
  }

  Section.empty() {
    id = '';
    name = '';
    logoPath = '';
    description = '';
  }
}