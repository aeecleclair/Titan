class Association {
  Association({required this.name, required this.groupId, required this.id});
  late final String name;
  late final String groupId;
  late final String id;

  Association.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    groupId = json['group_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['group_id'] = groupId;
    data['id'] = id;
    return data;
  }

  Association copyWith({String? name, String? groupId, String? id}) =>
      Association(
        name: name ?? this.name,
        groupId: groupId ?? this.groupId,
        id: id ?? this.id,
      );

  Association.empty() {
    name = 'Nom';
    groupId = '';
    id = '';
  }

  @override
  String toString() {
    return 'Association(name: $name, groupId: $groupId, id: $id)';
  }
}
