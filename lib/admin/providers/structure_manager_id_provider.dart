import 'package:hooks_riverpod/hooks_riverpod.dart';

class StructureManagerIdProvider extends StateNotifier<String> {
  StructureManagerIdProvider() : super("");

  void setId(String id) {
    state = id;
  }
}

final structureManagerIdProvider =
    StateNotifierProvider<StructureManagerIdProvider, String>(
  (ref) => StructureManagerIdProvider(),
);
