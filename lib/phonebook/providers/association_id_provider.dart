import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssociationIdNotifier extends StateNotifier<String> {
  AssociationIdNotifier() : super("");

  void setId(String id) {
    state = id;
  }
}

final associationIdProvider =
    StateNotifierProvider<AssociationIdNotifier, String>(
        (ref) => AssociationIdNotifier());
