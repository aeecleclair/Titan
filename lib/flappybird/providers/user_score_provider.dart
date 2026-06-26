import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class UserScoreNotifier
    extends SingleNotifierAPI<FlappyBirdScoreCompleteFeedBack> {
  Openapi get scoreRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<FlappyBirdScoreCompleteFeedBack> build() {
    getLeaderBoardPosition();
    return const AsyncLoading();
  }

  Future<AsyncValue<FlappyBirdScoreCompleteFeedBack>>
  getLeaderBoardPosition() async {
    return await load(scoreRepository.flappybirdScoresMeGet);
  }
}

final userScoreProvider =
    NotifierProvider<
      UserScoreNotifier,
      AsyncValue<FlappyBirdScoreCompleteFeedBack>
    >(UserScoreNotifier.new);
