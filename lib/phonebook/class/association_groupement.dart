class AssociationGroupement {
  AssociationGroupement({
    required this.id,
    required this.name,
    required this.managerGroupId,
  });

  late final String id;
  late final String name;
  late final String managerGroupId;

  AssociationGroupement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    managerGroupId = json['manager_group_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'name': name,
      'manager_group_id': managerGroupId,
    };
    return data;
  }

  AssociationGroupement.empty() {
    id = "";
    name = "";
    managerGroupId = "";
  }

  @override
  String toString() {
    return 'AssociationGroupement(kinds: $id, name: $name, managerGroupId: $managerGroupId)';
  }
}
