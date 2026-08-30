import 'package:titan/admin/class/document_template.dart';
import 'package:titan/admin/class/simple_group.dart';

class DocumentTeam {
  late String id;
  late String groupId;
  late String name;
  late String apiKey;
  late int teamId;
  late List<DocumentTemplate> templates;
  late SimpleGroup group;

  DocumentTeam({
    required this.id,
    required this.groupId,
    required this.name,
    required this.apiKey,
    required this.teamId,
    required this.templates,
    required this.group,
  });

  DocumentTeam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    name = json['name'];
    apiKey = json['api_key'];
    teamId = json['team_id'];
    templates = List<DocumentTemplate>.from(
      json['templates'].map((x) => DocumentTemplate.fromJson(x)),
    );
    group = SimpleGroup.fromJson(json['group']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['group_id'] = groupId;
    data['name'] = name;
    data['api_key'] = apiKey;
    data['team_id'] = teamId;
    data['templates'] = templates.map((e) => e.toJson()).toList();
    data['group'] = group.toJson();
    return data;
  }

  DocumentTeam copyWith({
    String? id,
    String? groupId,
    String? name,
    String? apiKey,
    int? teamId,
    List<DocumentTemplate>? templates,
    SimpleGroup? group,
  }) {
    return DocumentTeam(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      apiKey: apiKey ?? this.apiKey,
      teamId: teamId ?? this.teamId,
      templates: templates ?? this.templates,
      group: group ?? this.group,
    );
  }

  DocumentTeam.empty() {
    id = '';
    groupId = '';
    name = '';
    apiKey = '';
    teamId = 0;
    templates = [];
    group = SimpleGroup.empty();
  }

  @override
  String toString() {
    return 'DocumentTeam(id: $id, groupId: $groupId, name: $name, apiKey: $apiKey, teamId: $teamId, templates: $templates, group: $group)';
  }
}
