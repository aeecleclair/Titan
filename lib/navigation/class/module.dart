import 'package:either_dart/either.dart';
import 'package:heroicons/heroicons.dart';

class Module {
  String name;
  String description;
  String root;

  Module({required this.name, required this.description, required this.root});

  Module copy({
    String? name,
    String? description,
    Either<HeroIcons, String>? icon,
    String? root,
    bool? selected,
  }) => Module(
    name: name ?? this.name,
    description: description ?? this.description,
    root: root ?? this.root,
  );
}
