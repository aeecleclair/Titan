import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/class/structure.dart';

class StructureNotifier extends StateNotifier<Structure> {
  StructureNotifier() : super(Structure.empty());

  void setStructure(Structure structure) {
    state = structure;
  }

  void resetStructure() {
    state = Structure.empty();
  }
}

final structureProvider = StateNotifierProvider<StructureNotifier, Structure>(
  (ref) => StructureNotifier(),
);
