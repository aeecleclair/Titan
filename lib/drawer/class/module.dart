import 'package:heroicons/heroicons.dart';


class Module {
  String name;
  HeroIcons icon;
  String root;
  bool selected;

  Module(
      {required this.name,
      required this.icon,
      required this.root,
      required this.selected});

  Module copy({name, icon, root, selected}) => Module(
        name: name ?? this.name,
        icon: icon ?? this.icon,
        root: root ?? this.root,
        selected: selected ?? this.selected,
      );
}
