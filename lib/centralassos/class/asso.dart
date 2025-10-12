import 'package:titan/centralassos/class/link.dart';

class Asso {
  Asso({required this.name, required this.description, required this.icon});
  late final String name;
  late final String description;
  late final List<Link> linkList;
  late final String icon;

  Asso.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    description = json["description"];
    icon = json["icon"];
    linkList = List<Link>.from(json["links"].map((e) => Link.fromJson(e)));
  }

  Asso.empty() {
    name = '';
    description = '';
    linkList = [];
  }

  @override
  String toString() {
    return 'Asso{name: $name, description: $description, link_list: $linkList, icon: $icon}';
  }
}
