class Recommendation {
  final String? id;
  final DateTime? creation;
  final String title;
  final String? code;
  final String summary;
  final String description;

  Recommendation({
    this.id,
    this.creation,
    required this.title,
    required this.code,
    required this.summary,
    required this.description,
  });

  Recommendation.fromJson(Map<String, dynamic> json)
      : id = json["id"] as String,
        creation = DateTime.parse(json["creation"] as String),
        title = json["title"] as String,
        code = json["code"] as String,
        summary = json["summary"] as String,
        description = json["description"] as String;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["title"] = title;
    data["code"] = code;
    data["summary"] = summary;
    data["description"] = description;
    return data;
  }

  Recommendation copyWith(
      {String? id,
      DateTime? creation,
      String? title,
      String? code,
      String? summary,
      String? description}) {
    return Recommendation(
      id: id ?? this.id,
      creation: creation ?? this.creation,
      title: title ?? this.title,
      code: code ?? this.code,
      summary: summary ?? this.summary,
      description: description ?? this.description,
    );
  }

  static Recommendation empty() {
    return Recommendation(
      title: "",
      code: null,
      summary: "",
      description: "",
    );
  }

  @override
  String toString() {
    return 'Recommendation{id: $id, creation: $creation, title: $title, code: $code, summary: $summary, description: $description}';
  }
}
