import 'package:hooks_riverpod/hooks_riverpod.dart';

class SchoolIdNotifier extends StateNotifier<String> {
  SchoolIdNotifier() : super("");

  void setId(String id) {
    state = id;
  }
}

final schoolIdProvider = StateNotifierProvider<SchoolIdNotifier, String>(
  (ref) => SchoolIdNotifier(),
);
