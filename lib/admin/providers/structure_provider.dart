import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/class/structure.dart';

class StructureNotifier extends StateNotifier<Structure> {
  StructureNotifier() : super(Structure.empty());

  void setStructure(Structure structure) {
    state = structure;
  }
}

final structureProvider = StateNotifierProvider<StructureNotifier, Structure>(
  (ref) => StructureNotifier(),
);
