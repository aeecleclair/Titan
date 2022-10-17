enum ListType {serio, pipo}

class Pretendance {
  String id;
  String name;
  String logoPath;
  String description;
  ListType listType;

  Pretendance({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.description,
    required this.listType,
  });

  Pretendance copyWith({
    String? id,
    String? name,
    String? logoPath,
    String? description,
    ListType? listType,
  }) {
    return Pretendance(
      id: id ?? this.id,
      name: name ?? this.name,
      logoPath: logoPath ?? this.logoPath,
      description: description ?? this.description,
      listType: listType ?? this.listType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logoPath': logoPath,
      'description': description,
      'listType': listType,
    };
  }

  factory Pretendance.fromJson(Map<String, dynamic> map) {
    return Pretendance(
      id: map['id'],
      name: map['name'],
      logoPath: map['logoPath'],
      description: map['description'],
      listType: map['listType'],
    );
  }
}