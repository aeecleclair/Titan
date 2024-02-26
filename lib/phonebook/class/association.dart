class Association {
  Association({
    required this.id,
    required this.name,
    required this.description,
    required this.kind,
    required this.mandateYear,
  });

  late final String id;
  late final String name;
  late final String description;
  late final String kind;
  late final String mandateYear;

  Association.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    kind = json['kind'];
    mandateYear = json['mandateYear'];
  }

  Map<String, dynamic> toJSON() {
    final data = <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'kind': kind,
      'mandate_year': mandateYear,
    };
    return data;
  }

  Association copyWith({
    String? id,
    String? name,
    String? description,
    String? kind,
    String? mandateYear,
  }) {
    return Association(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      kind: kind ?? this.kind,
      mandateYear: mandateYear ?? this.mandateYear,
    );
  }

  Association.empty() {
    id = "";
    name = "";
    description = "";
    kind = "";
    mandateYear = "";
  }

  void newMandate() {
    mandateYear = (int.parse(mandateYear) + 1).toString();
  }

  @override
  String toString() {
    return "Nom : $name, id : $id, description : $description, kind : $kind, mandate_year : $mandateYear";
  }
}
