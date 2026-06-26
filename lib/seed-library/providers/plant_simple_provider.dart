import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

final plantSimpleProvider = NotifierProvider<PlantSimpleNotifier, PlantSimple>(
  () => PlantSimpleNotifier(),
);

class PlantSimpleNotifier extends Notifier<PlantSimple> {
  @override
  PlantSimple build() {
    return PlantSimple.empty();
  }

  void setPlant(PlantSimple i) {
    state = i;
  }
}
