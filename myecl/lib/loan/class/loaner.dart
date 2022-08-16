class Loaner {
  Loaner({
    required this.name,
    required this.groupManagerId,
    required this.id,
  });
  late final String name;
  late final String groupManagerId;
  late final String id;

  Loaner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    groupManagerId = json['group_manager_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['group_manager_id'] = groupManagerId;
    _data['id'] = id;
    return _data;
  }

  Loaner copyWith({name, groupManagerId, id}) {
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
}
