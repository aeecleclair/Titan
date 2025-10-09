class PhAdmin {
  PhAdmin({required this.name, required this.groupManagerId, required this.id});
  late final String name;
  late final String groupManagerId;
  late final String id;

  PhAdmin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    groupManagerId = json['group_manager_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['group_manager_id'] = groupManagerId;
    data['id'] = id;
    return data;
  }

  PhAdmin copyWith({String? name, String? groupManagerId, String? id}) {
    return PhAdmin(
      name: name ?? this.name,
      groupManagerId: groupManagerId ?? this.groupManagerId,
      id: id ?? this.id,
    );
  }

  PhAdmin.empty() {
    name = "";
    groupManagerId = "";
    id = "";
  }

  @override
  String toString() {
    return 'PhAdmin(name: $name, groupManagerId: $groupManagerId, id: $id)';
  }
}
