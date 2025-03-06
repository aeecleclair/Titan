import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class ScoreListNotifier extends ListNotifierAPI<FlappyBirdScoreInDB> {
  final Openapi scoreRepository;
  ScoreListNotifier({required this.scoreRepository})
      : super(const AsyncLoading());

  Future<AsyncValue<List<FlappyBirdScoreInDB>>> getLeaderboard() async {
    return await loadList(scoreRepository.flappybirdScoresGet);
  }

  //  TODO : back bad response
  Future<bool> createScore(FlappyBirdScoreBase score) async {
    return await add(
      () => scoreRepository.flappybirdScoresPost(body: score),
      score,
    );
  }
}

final scoreListProvider = StateNotifierProvider<ScoreListNotifier,
    AsyncValue<List<FlappyBirdScoreInDB>>>((ref) {
  final scoreRepository = ref.watch(repositoryProvider);
  return ScoreListNotifier(scoreRepository: scoreRepository)..getLeaderboard();
});
