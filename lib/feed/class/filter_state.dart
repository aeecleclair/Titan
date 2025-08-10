class FilterState {
  final List<String> selectedEntities;
  final List<String> selectedModules;

  FilterState({required this.selectedEntities, required this.selectedModules});

  FilterState copyWith({
    List<String>? selectedEntities,
    List<String>? selectedModules,
  }) {
    return FilterState(
      selectedEntities: selectedEntities ?? this.selectedEntities,
      selectedModules: selectedModules ?? this.selectedModules,
    );
  }

  factory FilterState.empty() {
    return FilterState(selectedEntities: [], selectedModules: []);
  }
}
