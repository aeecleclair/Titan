class RolesTags {
  RolesTags({
    required this.tags,
  });

  late final List<String> tags;

  RolesTags.fromJSON(Map<String, dynamic> json) {
    tags = json['tags'].map<String>((dynamic tag) => tag.toString()).toList();
  }

  Map<String, dynamic> toJSON() {
    final data = <String, dynamic>{
      'tags': tags,
    };
    return data;
  }

  RolesTags empty() {
    return RolesTags(tags: []);
  }
}
