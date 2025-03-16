class SpeciesType {
  final String name;

  SpeciesType({
    required this.name,
  });

  factory SpeciesType.fromString(String name) {
    return SpeciesType(
      name: name,
    );
  }

  factory SpeciesType.empty() {
    return SpeciesType(
      name: "",
    );
  }
}
