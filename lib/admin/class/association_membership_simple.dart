class AssociationMembership {
  AssociationMembership({
    required this.id,
    required this.name,
    required this.managerGroupId,
  });
  late final String id;
  late final String name;
  late final String managerGroupId;

  AssociationMembership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    managerGroupId = json['manager_group_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['manager_group_id'] = managerGroupId;
    return data;
  }

  AssociationMembership copyWith({
    String? id,
    String? name,
    String? managerGroupId,
  }) => AssociationMembership(
    id: id ?? this.id,
    name: name ?? this.name,
    managerGroupId: managerGroupId ?? this.managerGroupId,
  );

  AssociationMembership.empty() {
    id = '';
    name = "Pas d'adhésion";
    managerGroupId = '';
  }

  @override
  String toString() {
    return 'AssociationMembership(id: $id, name: $name, groupId: $managerGroupId)';
  }
}
