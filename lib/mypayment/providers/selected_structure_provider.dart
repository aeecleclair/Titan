import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class SelectedStructureNotifier extends Notifier<Structure> {
  @override
  Structure build() {
    return Structure.empty();
  }

  void setStructure(Structure structure) {
    state = structure;
  }
}

final selectedStructureProvider =
    NotifierProvider<SelectedStructureNotifier, Structure>(
      SelectedStructureNotifier.new,
    );
