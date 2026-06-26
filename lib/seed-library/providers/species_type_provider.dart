import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.enums.swagger.dart';

class SpeciesTypeNotifier extends Notifier<SpeciesType> {
  @override
  SpeciesType build() {
    return SpeciesType.autre;
  }

  void setType(SpeciesType i) {
    state = i;
  }
}

final speciesTypeProvider = NotifierProvider<SpeciesTypeNotifier, SpeciesType>(
  SpeciesTypeNotifier.new,
);
