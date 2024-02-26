import 'package:flutter_riverpod/flutter_riverpod.dart';


final kindProvider = StateNotifierProvider<KindNotifier, String>((ref) {
  return KindNotifier();
});

class KindNotifier extends StateNotifier<String> {
  KindNotifier() : super("");

  void setKind(String i) {
    state = i;
  }
}