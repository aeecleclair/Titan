import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';

class Module {
  String name;
  Either<HeroIcons, String> icon;
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

  Widget getIcon(Color color) {
    return icon.fold(
        (heroIcon) => HeroIcon(heroIcon, color: color),
        (svgPath) => SvgPicture.asset(svgPath,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn)));
  }
}
