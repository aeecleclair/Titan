class Link {
  Link({required this.name, required this.url, required this.icon});
  late final String name;
  late final String url;
  late final String icon;

  Link.fromJson(Map<String, dynamic> l) {
    name = l["name"];
    icon = l["icon"];
    url = l["url"];
  }
}
