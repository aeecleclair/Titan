import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/flappybird/class/score.dart';
import 'package:myecl/flappybird/repositories/score_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class ScoreListNotifier extends ListNotifier<Score> {
  final ScoreRepository _scoreRepository;
  ScoreListNotifier(this._scoreRepository) : super(const AsyncLoading());

  Future<AsyncValue<List<Score>>> getLeaderboard() async {
    return await loadList(_scoreRepository.getLeaderboard);
  }

  Future<bool> createScore(Score score) async {
    return await add(_scoreRepository.createScore, score);
  }
}

final scoreListProvider =
    StateNotifierProvider<ScoreListNotifier, AsyncValue<List<Score>>>((ref) {
      final scoreRepository = ref.watch(scoreRepositoryProvider);
      final notifier = ScoreListNotifier(scoreRepository);
      notifier.getLeaderboard();
      return notifier;
    });
