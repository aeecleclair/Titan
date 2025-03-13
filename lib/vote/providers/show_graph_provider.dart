import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowGraphNotifier extends StateNotifier<bool> {
  ShowGraphNotifier() : super(false);

  void toggle(bool p) {
    state = p;
  }
}

final showGraphProvider = StateNotifierProvider<ShowGraphNotifier, bool>((ref) {
  return ShowGraphNotifier();
});
