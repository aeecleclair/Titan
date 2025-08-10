import 'package:either_dart/either.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons/heroicons.dart';

class Module {
  final String Function(BuildContext) getName;
  final String Function(BuildContext) getDescription;
  String root;

  Module({
    required this.getName,
    required this.getDescription,
    required this.root,
  });

  Module copy({
    String Function(BuildContext)? getName,

    String Function(BuildContext)? description,
    Either<HeroIcons, String>? icon,
    String? root,
    bool? selected,
  }) => Module(
    getName: getName ?? this.getName,
    getDescription: getDescription,
    root: root ?? this.root,
  );
}
