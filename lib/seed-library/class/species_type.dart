import 'package:titan/seed-library/tools/constants.dart';

class SpeciesType {
  final String name;

  SpeciesType({required this.name});

  factory SpeciesType.fromString(String name) {
    return SpeciesType(name: name);
  }

  factory SpeciesType.empty() {
    return SpeciesType(name: SeedLibraryTextConstants.all);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SpeciesType && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'SpeciesType(name: $name)';
}
