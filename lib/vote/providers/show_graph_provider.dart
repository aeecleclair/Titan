import 'package:flutter_riverpod/flutter_riverpod.dart';

final showGraphProvider =
    StateNotifierProvider<ShowGraphNotifier, bool>((ref) {
  return ShowGraphNotifier();
});

class ShowGraphNotifier extends StateNotifier<bool> {
  ShowGraphNotifier() : super(false);

  void toggle(bool p) {
    state = p;
  }
}
