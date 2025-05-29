class Information {
  Information({
    required this.manager,
    required this.link,
    required this.description,
  });
  late final String manager;
  late final String link;
  late final String description;

  Information.fromJson(Map<String, dynamic> json) {
    manager = json['manager'];
    link = json['link'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['manager'] = manager;
    data['link'] = link;
    data['description'] = description;
    return data;
  }

  Information copyWith({String? manager, String? link, String? description}) {
    return Information(
      manager: manager ?? this.manager,
      link: link ?? this.link,
      description: description ?? this.description,
    );
  }

  static Information empty() =>
      Information(manager: '', link: '', description: '');

  @override
  String toString() {
    return 'Information{manager: $manager, link: $link, description: $description}';
  }
}
