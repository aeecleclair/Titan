class AssociationMembership {
  AssociationMembership({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  AssociationMembership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  AssociationMembership copyWith({
    String? id,
    String? name,
  }) =>
      AssociationMembership(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  AssociationMembership.empty() {
    id = '';
    name = 'Nom';
  }

  @override
  String toString() {
    return 'AssociationMembership(id: $id, name: $name)';
  }
}
