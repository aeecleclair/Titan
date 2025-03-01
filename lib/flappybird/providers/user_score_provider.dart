import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

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
  final notifier = ScoreListNotifier(scoreRepository: scoreRepository);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getLeaderBoardPosition();
  });
  return notifier;
});
