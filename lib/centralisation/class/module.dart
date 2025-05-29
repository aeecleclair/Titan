class Module {
  Module({
    required this.name,
    required this.description,
    required this.icon,
    required this.url,
    this.liked,
  });
  late final String name;
  late final String description;
  late final String icon;
  late final String url;
  late final bool? liked;

  Module.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    url = json['url'];
    liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['icon'] = icon;
    data['url'] = url;
    if (liked == null) {
      data['liked'] = false;
    } else {
      data['liked'] = liked;
    }
    return data;
  }

  Module copyWith({
    String? name,
    String? description,
    String? icon,
    String? url,
    bool? liked,
  }) => Module(
    name: name ?? this.name,
    description: description ?? this.name,
    icon: icon ?? this.icon,
    url: url ?? this.url,
    liked: liked,
  );

  Module.empty() {
    name = '';
    description = '';
    icon = '';
    url = '';
    liked = false;
  }

  @override
  String toString() {
    return 'Module{name: $name, description: $description, icon: $icon, url: $url, liked: $liked}';
  }
}
