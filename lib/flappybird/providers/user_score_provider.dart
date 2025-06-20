import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/flappybird/class/score.dart';
import 'package:myecl/flappybird/repositories/score_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class ScoreListNotifier extends SingleNotifier<Score> {
  final ScoreRepository _scoreRepository;
  ScoreListNotifier(this._scoreRepository) : super(const AsyncLoading());

  Future<AsyncValue<Score>> getLeaderBoardPosition() async {
    return await load(_scoreRepository.getLeaderBoardPosition);
  }
}

final userScoreProvider =
    StateNotifierProvider<ScoreListNotifier, AsyncValue<Score>>((ref) {
      final scoreRepository = ref.watch(scoreRepositoryProvider);
      final notifier = ScoreListNotifier(scoreRepository);
      notifier.getLeaderBoardPosition();
      return notifier;
    });
