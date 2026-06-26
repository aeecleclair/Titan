import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/flappybird/providers/user_score_provider.dart';

class BestScoreNotifier extends Notifier<int> {
  @override
  int build() {
    ref.watch(userScoreProvider).whenData((value) {
      setBest(value.value);
    });
    return 0;
  }

  void setBest(int newState) {
    state = newState;
  }
}

final bestScoreProvider = NotifierProvider<BestScoreNotifier, int>(
  BestScoreNotifier.new,
);
