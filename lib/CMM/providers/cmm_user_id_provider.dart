import 'package:flutter_riverpod/flutter_riverpod.dart';

class CMMUserIdNotifier extends StateNotifier<String> {
  CMMUserIdNotifier() : super("");

  void setUserId(String s) {
    state = s;
  }
}

final cmmUserIdProvider =
    StateNotifierProvider<CMMUserIdNotifier, String>((ref) {
  return CMMUserIdNotifier();
});
