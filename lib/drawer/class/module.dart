import 'package:heroicons/heroicons.dart';

enum ModuleType {
  amap, 
  loan,
  booking,
  event,
  vote,
  tombola,
  cinema,
}

class Module {
  String name;
  HeroIcons icon;
  ModuleType page;
  bool selected;

  Module(
      {required this.name,
      required this.icon,
      required this.page,
      required this.selected});

  Module copy({name, icon, page, selected}) => Module(
        name: name ?? this.name,
        icon: icon ?? this.icon,
        page: page ?? this.page,
        selected: selected ?? this.selected,
      );
}
