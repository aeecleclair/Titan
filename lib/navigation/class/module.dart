import 'package:either_dart/either.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons/heroicons.dart';

class Module {
  final String Function(BuildContext) getName;
  String description;
  String root;

  Module({
    required this.getName,
    required this.description,
    required this.root,
  });

  Module copy({
    String Function(BuildContext)? getName,

    String? description,
    Either<HeroIcons, String>? icon,
    String? root,
    bool? selected,
  }) => Module(
    getName: getName ?? this.getName,
    description: description ?? this.description,
    root: root ?? this.root,
  );
}
