import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.enums.swagger.dart';

class FilterNotifier extends Notifier<SpeciesType> {
  @override
  SpeciesType build() {
    return SpeciesType.autre;
  }

  void setFilter(SpeciesType i) {
    state = i;
  }
}

final speciesTypeFilterProvider = NotifierProvider<FilterNotifier, SpeciesType>(
  FilterNotifier.new,
);
