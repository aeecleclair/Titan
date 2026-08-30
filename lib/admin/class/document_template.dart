// class TemplateBase(BaseModel):
//     documenso_id: int
//     name: str
//     recipient_id: int
//     team_id: UUID

// class Template(TemplateBase):
//     id: UUID
//     deleted: bool
//     document_directory_id: str | None = None
//     created_at: datetime
//     updated_at: datetime

import 'package:titan/tools/functions.dart';

class DocumentTemplate {
  late String id;
  late int documensoId;
  late String name;
  late int recipientId;
  late String teamId;
  late bool deleted;
  String? documentDirectoryId;
  late DateTime createdAt;
  late DateTime updatedAt;

  DocumentTemplate({
    required this.id,
    required this.documensoId,
    required this.name,
    required this.recipientId,
    required this.teamId,
    required this.deleted,
    this.documentDirectoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  DocumentTemplate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documensoId = json['documenso_id'];
    name = json['name'];
    recipientId = json['recipient_id'];
    teamId = json['team_id'];
    deleted = json['deleted'];
    documentDirectoryId = json['document_directory_id'];
    createdAt = processDateFromAPI(json['created_at']);
    updatedAt = processDateFromAPI(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['documenso_id'] = documensoId;
    data['name'] = name;
    data['recipient_id'] = recipientId;
    data['team_id'] = teamId;
    data['deleted'] = deleted;
    data['document_directory_id'] = documentDirectoryId;
    data['created_at'] = processDateToAPI(createdAt);
    data['updated_at'] = processDateToAPI(updatedAt);
    return data;
  }

  DocumentTemplate copyWith({
    String? id,
    int? documensoId,
    String? name,
    int? recipientId,
    String? teamId,
    bool? deleted,
    String? documentDirectoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DocumentTemplate(
    id: id ?? this.id,
    documensoId: documensoId ?? this.documensoId,
    name: name ?? this.name,
    recipientId: recipientId ?? this.recipientId,
    teamId: teamId ?? this.teamId,
    deleted: deleted ?? this.deleted,
    documentDirectoryId: documentDirectoryId ?? this.documentDirectoryId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  DocumentTemplate.empty() {
    id = '';
    documensoId = 0;
    name = '';
    recipientId = 0;
    teamId = '';
    deleted = false;
    documentDirectoryId = null;
    createdAt = DateTime.now();
    updatedAt = DateTime.now();
  }

  @override
  String toString() {
    return 'DocumentTemplate(id: $id, documensoId: $documensoId, name: $name, recipientId: $recipientId, teamId: $teamId, deleted: $deleted, documentDirectoryId: $documentDirectoryId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
