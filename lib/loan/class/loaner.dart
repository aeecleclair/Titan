class Loaner {
  Loaner({required this.name, required this.groupManagerId, required this.id});
  late final String name;
  late final String groupManagerId;
  late final String id;

  Loaner.fromJson(Map<String, dynamic> json) {
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

  Loaner copyWith({String? name, String? groupManagerId, String? id}) {
    return Loaner(
      name: name ?? this.name,
      groupManagerId: groupManagerId ?? this.groupManagerId,
      id: id ?? this.id,
    );
  }

  Loaner.empty() {
    name = "";
    groupManagerId = "";
    id = "";
  }

  @override
  String toString() {
    return 'Loaner(name: $name, groupManagerId: $groupManagerId, id: $id)';
  }
}
