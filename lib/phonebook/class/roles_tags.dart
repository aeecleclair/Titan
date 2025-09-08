class RolesTags {
  RolesTags({required this.tags});

  late final List<String> tags;

  RolesTags.fromJson(Map<String, dynamic> json) {
    tags = json['tags'].map<String>((dynamic tag) => tag.toString()).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{'tags': tags};
    return data;
  }

  RolesTags empty() {
    return RolesTags(tags: []);
  }
}
