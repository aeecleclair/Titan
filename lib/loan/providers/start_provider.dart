import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartNotifier extends StateNotifier<String> {
  StartNotifier() : super("");

  void setStart(String start) {
    state = start;
  }
}

final startProvider = StateNotifierProvider<StartNotifier, String>((ref) {
  return StartNotifier();
});
