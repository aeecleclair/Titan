import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/flap/providers/user_score_provider.dart';

class BestScoreNotifier extends StateNotifier<int> {
  BestScoreNotifier(int i) : super(i);

  void setBest(int newState) {
    state = newState;
  }
}

final bestScoreProvider = StateNotifierProvider<BestScoreNotifier, int>((ref) {
  ref.watch(userScoreProvider).whenData((value) {
    return BestScoreNotifier(value.value);
  });
  return BestScoreNotifier(0);
});
