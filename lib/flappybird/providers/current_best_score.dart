import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/flappybird/providers/user_score_provider.dart';

class BestScoreNotifier extends StateNotifier<int> {
  BestScoreNotifier(super.i);

  void setBest(int newState) {
    state = newState;
  }
}

final bestScoreProvider = StateNotifierProvider<BestScoreNotifier, int>((ref) {
  final notifier = BestScoreNotifier(0);
  ref.watch(userScoreProvider).whenData((value) {
    notifier.setBest(value.value);
  });
  return notifier;
});
