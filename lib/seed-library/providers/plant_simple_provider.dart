import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/seed-library/class/plant_simple.dart';

final plantSimpleProvider =
    StateNotifierProvider<PlantSimpleNotifier, PlantSimple>((ref) {
      return PlantSimpleNotifier();
    });

class PlantSimpleNotifier extends StateNotifier<PlantSimple> {
  PlantSimpleNotifier() : super(PlantSimple.empty());

  void setPlant(PlantSimple i) {
    state = i;
  }
}
