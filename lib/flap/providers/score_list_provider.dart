import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/flap/class/score.dart';
import 'package:myecl/flap/repositories/score_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/class/list_users.dart';

class ScoreListNotifier extends ListNotifier<Score> {
  final ScoreRepository _scoreRepository = ScoreRepository();
  ScoreListNotifier({required String token}) : super(const AsyncLoading()) {
    _scoreRepository.setToken(token);
  }

  Future<AsyncValue<List<Score>>> getLeaderboard() async {
    // return await loadList(_scoreRepository.getLeaderboard);
    return state = AsyncData([
      Score(
          user: SimpleUser(
              id: "",
              name: "zt'ye(è-_è_pç^ymltkrj)",
              firstname: "eqrghstjykduliutkyj",
              nickname: "qhsfjstkytlduy"),
          value: 5000,
          date: DateTime.now(),
          position: 1),
      Score(
          user: SimpleUser(
              id: "",
              name: "zt'ye(è-_è_pç^ymltkrj)",
              firstname: "eqrghstjykduliutkyj",
              nickname: "qhsfjstkytlduyiugkerh"),
          value: 4000,
          date: DateTime.now(),
          position: 2),
      Score(
          user: SimpleUser(
              id: "",
              name: "zt'ye(è-_è_pç^ymltkrj)",
              firstname: "eqrghstjykduliutkyj",
              nickname: "swdvfdbxgfnjh"),
          value: 30,
          date: DateTime.now(),
          position: 3),
      Score(
          user: SimpleUser(
              id: "",
              name: "zt'ye(è-_è_pç^ymltkrj)",
              firstname: "eqrghstjykdulzrhetriutkyj",
              nickname: null),
          value: 20,
          date: DateTime.now(),
          position: 4),
      Score(
          user: SimpleUser(
              id: "",
              name: "zt'ye(è-_è_pç^ymltkrj)",
              firstname: "eqrghstjykduliutkyj",
              nickname: "sbbfdb"),
          value: 10,
          date: DateTime.now(),
          position: 5),
      Score(
          user: SimpleUser(
              id: "",
              name: "zt'ye(è-_è_pç^ymltkrj)",
              firstname: "eqrghstjykduliutkyj",
              nickname: "qhsfjstkytlduyiugkerh"),
          value: 10,
          date: DateTime.now(),
          position: 5),
      Score(
          user: SimpleUser(
              id: "",
              name: "zt'ye(è-_è_pç^ymltkrj)",
              firstname: "eqrghstjykduliutkyj",
              nickname: "ebtqre"),
          value: 10,
          date: DateTime.now(),
          position: 5),
      Score(
          user: SimpleUser(
              id: "",
              name: "zt'ye(è-_è_pç^ymltkrj)",
              firstname: "eqrghstjykduliutkyj",
              nickname: "qhsfjstkytlduyiugkerh"),
          value: 10,
          date: DateTime.now(),
          position: 5),
      Score(
          user: SimpleUser(
              id: "",
              name: "zt'ye(è-_è_pç^ymltkrj)",
              firstname: "eqrghstjykduliutkyj",
              nickname: "qhsfjstkytlduyiugkerh"),
          value: 10,
          date: DateTime.now(),
          position: 5),
      Score(
          user: SimpleUser(
              id: "",
              name: "zt'ye(è-_è_pç^ymltkrj)",
              firstname: "eqrghstjykduliutkyj",
              nickname: "qhsfjstkytlduyiugkerh"),
          value: 10,
          date: DateTime.now(),
          position: 5),
    ]);
  }

  Future<bool> createScore(Score score) async {
    return await add(_scoreRepository.createScore, score);
  }
}

final scoreListProvider =
    StateNotifierProvider<ScoreListNotifier, AsyncValue<List<Score>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = ScoreListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getLeaderboard();
  });
  return notifier;
});
