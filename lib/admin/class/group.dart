import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class Group {
  Group({
    required this.name,
    required this.description,
    required this.id,
    required this.members,
  });
  late final String name;
  late final String description;
  late final String id;
  late final List<CoreUserSimple> members;

  Group.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    id = json['id'];
    members = List<CoreUserSimple>.from(
      json['members'].map((x) => CoreUserSimple.fromJson(x)),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['id'] = id;
    data['members'] = members.map((x) => x.toJson()).toList();
    return data;
  }

  Group copyWith({
    String? name,
    String? description,
    String? id,
    List<CoreUserSimple>? members,
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
    members = List<CoreUserSimple>.from([]);
  }

  SimpleGroup toSimpleGroup() {
    return SimpleGroup(
      name: name,
      description: description,
      id: id,
    );
  }

  @override
  String toString() {
    return 'Group(id: $id, name: $name, description: $description, members: $members)';
  }
}
