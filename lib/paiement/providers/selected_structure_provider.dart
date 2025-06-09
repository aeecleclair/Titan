import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myemapp/paiement/class/structure.dart';

class SelectedStructureNotifier extends StateNotifier<Structure> {
  SelectedStructureNotifier() : super(Structure.empty());

  void setStructure(Structure structure) {
    state = structure;
  }
}

final selectedStructureProvider =
    StateNotifierProvider<SelectedStructureNotifier, Structure>((ref) {
      return SelectedStructureNotifier();
    });
