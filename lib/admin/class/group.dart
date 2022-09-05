import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/user/class/list_users.dart';

class Group {
  Group(
      {required this.name,
      required this.description,
      required this.id,
      required this.members});
  late final String name;
  late final String description;
  late final String id;
  late final List<SimpleUser> members;

  Group.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    id = json['id'];
    members = List<SimpleUser>.from(
        json['members'].map((x) => SimpleUser.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['description'] = description;
    _data['id'] = id;
    _data['members'] = members.map((x) => x.toJson()).toList();
    return _data;
  }

  Group copyWith({
    name,
    description,
    id,
    members,
  }) =>
      Group(
        name: name ?? this.name,
        description: description ?? this.description,
        id: id ?? this.id,
        members: members ?? this.members,
      );

  Group.empty() {
    name = 'Nom';
    description = 'Description';
    id = '';
    members = List<SimpleUser>.from([]);
  }

  SimpleGroup toSimpleGroup() {
    return SimpleGroup(
      name: name,
      description: description,
      id: id,
    );
  }
}
