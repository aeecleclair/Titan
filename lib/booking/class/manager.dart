class Manager {
  final String name;
  final String groupId;
  final String id;

  Manager({required this.name, required this.groupId, required this.id});

  Manager.fromJson(Map<String, dynamic> json)
      : name = json["name"] as String,
        groupId = json["group_id"] as String,
        id = json["id"] as String;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["name"] = name;
    data["group_id"] = groupId;
    data["id"] = id;
    return data;
  }

  Manager copyWith({String? name, String? groupId, String? id}) => Manager(
        name: name ?? this.name,
        groupId: groupId ?? this.groupId,
        id: id ?? this.id,
      );

  Manager.empty() : this(name: '', groupId: '', id: '');

  @override
  String toString() {
    return 'Manager{name: $name, group_id: $groupId, id: $id}';
  }

  bool isEmpty() {
    return name == '' && groupId == '' && id == '';
  }
}
