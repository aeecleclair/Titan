class Association {
  Association({
    required this.id,
    required this.name,
    required this.description,
    required this.groupementId,
    required this.mandateYear,
    required this.deactivated,
    required this.associatedGroups,
  });

  late final String id;
  late final String name;
  late final String description;
  late final String groupementId;
  late final int mandateYear;
  late final bool deactivated;
  late final List<String> associatedGroups;

  Association.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    groupementId = json['groupement_id'];
    mandateYear = json['mandate_year'];
    deactivated = json['deactivated'];
    associatedGroups = List<String>.from(json['associated_groups']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'groupement_id': groupementId,
      'mandate_year': mandateYear,
      'deactivated': deactivated,
      'associated_groups': associatedGroups,
    };
    return data;
  }

  Association copyWith({
    String? id,
    String? name,
    String? description,
    String? groupementId,
    int? mandateYear,
    bool? deactivated,
    List<String>? associatedGroups,
  }) {
    return Association(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      groupementId: groupementId ?? this.groupementId,
      mandateYear: mandateYear ?? this.mandateYear,
      deactivated: deactivated ?? this.deactivated,
      associatedGroups: associatedGroups ?? this.associatedGroups,
    );
  }

  Association.empty() {
    id = "";
    name = "";
    description = "";
    groupementId = "";
    mandateYear = 0;
    deactivated = false;
    associatedGroups = [];
  }

  void newMandate() {
    mandateYear = mandateYear + 1;
  }

  @override
  String toString() {
    return "Association(Nom : $name, id : $id, description : $description, groupement_id : $groupementId, mandate_year : $mandateYear, deactivated : $deactivated, associated_groups : $associatedGroups)";
  }
}
