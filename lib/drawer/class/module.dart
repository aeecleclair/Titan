import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';

enum ModuleType {
  calendar,
  settings,
  amap,
  loan,
  booking,
  admin,
  event,
  vote,
  tombola,
  cinema,
  paiement,
}

class Module {
  String name;
  Either<HeroIcons, String> icon;
  String root;
  bool selected;

  Module({
    required this.name,
    required this.icon,
    required this.root,
    required this.selected,
  });

  Module copy({
    String? name,
    Either<HeroIcons, String>? icon,
    String? root,
    bool? selected,
  }) => Module(
    name: name ?? this.name,
    icon: icon ?? this.icon,
    root: root ?? this.root,
    selected: selected ?? this.selected,
  );

  Widget getIcon(Color color, {double size = 30}) {
    return icon.fold(
      (heroIcon) => HeroIcon(heroIcon, color: color, size: size),
      (svgPath) => SvgPicture.asset(
        svgPath,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
