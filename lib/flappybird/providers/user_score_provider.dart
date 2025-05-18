import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class ScoreListNotifier
    extends SingleNotifierAPI<FlappyBirdScoreCompleteFeedBack> {
  final Openapi scoreRepository;
  ScoreListNotifier({required this.scoreRepository})
      : super(const AsyncLoading());

  Future<AsyncValue<FlappyBirdScoreCompleteFeedBack>>
      getLeaderBoardPosition() async {
    return await load(scoreRepository.flappybirdScoresMeGet);
  }
}

final userScoreProvider = StateNotifierProvider<ScoreListNotifier,
    AsyncValue<FlappyBirdScoreCompleteFeedBack>>((ref) {
  final scoreRepository = ref.watch(repositoryProvider);
  return ScoreListNotifier(scoreRepository: scoreRepository)
    ..getLeaderBoardPosition();
});
