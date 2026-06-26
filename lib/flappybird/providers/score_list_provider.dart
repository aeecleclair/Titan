import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class ScoreListNotifier extends ListNotifierAPI<FlappyBirdScoreInDB> {
  Openapi get scoreRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<FlappyBirdScoreInDB>> build() {
    getLeaderboard();
    return const AsyncLoading();
  }

  Future<AsyncValue<List<FlappyBirdScoreInDB>>> getLeaderboard() async {
    return await loadList(scoreRepository.flappybirdScoresGet);
  }

  Future<bool> createScore(FlappyBirdScoreBase score) async {
    return await add(
      () => scoreRepository.flappybirdScoresPost(body: score),
      score,
    );
  }
}

final scoreListProvider =
    NotifierProvider<ScoreListNotifier, AsyncValue<List<FlappyBirdScoreInDB>>>(
      ScoreListNotifier.new,
    );
