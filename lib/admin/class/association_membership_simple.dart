class AssociationMembership {
  AssociationMembership({
    required this.id,
    required this.name,
    required this.groupId,
  });
  late final String id;
  late final String name;
  late final String groupId;

  AssociationMembership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    groupId = json['group_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['group_id'] = groupId;
    return data;
  }

  AssociationMembership copyWith({
    String? id,
    String? name,
    String? groupId,
  }) =>
      AssociationMembership(
        id: id ?? this.id,
        name: name ?? this.name,
        groupId: groupId ?? this.groupId,
      );

  AssociationMembership.empty() {
    id = '';
    name = 'Nom';
    groupId = '';
  }

  @override
  String toString() {
    return 'AssociationMembership(id: $id, name: $name, groupId: $groupId)';
  }
}
