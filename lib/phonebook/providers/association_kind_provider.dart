import 'package:flutter_riverpod/flutter_riverpod.dart';

final associationKindProvider =
    StateNotifierProvider<AssociationKindNotifier, String>((ref) {
      return AssociationKindNotifier();
    });

class AssociationKindNotifier extends StateNotifier<String> {
  AssociationKindNotifier() : super("");

  void setKind(String i) {
    state = i;
  }
}
