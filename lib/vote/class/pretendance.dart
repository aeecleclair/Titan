class Pretendance {
  String id;
String name;
  String logoPath;
  String description;
  Pretendance({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.description,
  });

  Pretendance copyWith({
    String? id,
    String? name,
    String? logoPath,
    String? description,
  }) {
    return Pretendance(
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

  factory Pretendance.fromJson(Map<String, dynamic> map) {
    return Pretendance(
      id: map['id'],
      name: map['name'],
      logoPath: map['logoPath'],
      description: map['description'],
    );
  }
}