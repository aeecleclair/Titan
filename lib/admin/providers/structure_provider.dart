import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class StructureNotifier extends Notifier<Structure> {
  @override
  Structure build() {
    return Structure.empty();
  }

  void setStructure(Structure structure) {
    state = structure;
  }

  void resetStructure() {
    state = Structure.empty();
  }
}

final structureProvider = NotifierProvider<StructureNotifier, Structure>(
  () => StructureNotifier(),
);
