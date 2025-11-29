class Announcer {
  Announcer({
    required this.name,
    required this.groupManagerId,
    required this.id,
  });
  late final String name;
  late final String groupManagerId;
  late final String id;

  Announcer.fromJson(Map<String, dynamic> json) {
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

  Announcer copyWith({String? name, String? groupManagerId, String? id}) {
    return Announcer(
      name: name ?? this.name,
      groupManagerId: groupManagerId ?? this.groupManagerId,
      id: id ?? this.id,
    );
  }

  Announcer.empty() {
    name = "";
    groupManagerId = "";
    id = "";
  }

  @override
  String toString() {
    return 'Announcer(name: $name, groupManagerId: $groupManagerId, id: $id)';
  }
}
