import 'package:hooks_riverpod/hooks_riverpod.dart';

class StructureIdNotifier extends StateNotifier<String> {
  StructureIdNotifier() : super("");

  void setId(String id) {
    state = id;
  }
}

final structureIdProvider = StateNotifierProvider<StructureIdNotifier, String>(
  (ref) => StructureIdNotifier(),
);
