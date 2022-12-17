import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/repositories/pretendance_repository.dart';

class PretendanceListNotifier extends ListNotifier<Pretendance> {
  final PretendanceRepository _pretendanceRepository = PretendanceRepository();
  PretendanceListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _pretendanceRepository.setToken(token);
  }

  Future<AsyncValue<List<Pretendance>>> loadPretendanceList() async {
    await loadList(_pretendanceRepository.getPretendances);
    shuffle();
    return state;
  }

  Future<bool> addPretendance(Pretendance pretendance) async {
    return await add(_pretendanceRepository.createPretendance, pretendance);
  }

  Future<bool> updatePretendance(Pretendance pretendance) async {
    return await update(
        _pretendanceRepository.updatePretendance,
        (pretendances, pretendance) => pretendances
          ..[pretendances.indexWhere((p) => p.id == pretendance.id)] =
              pretendance,
        pretendance);
  }

  Future<bool> deletePretendance(Pretendance pretendance) async {
    return await delete(
        _pretendanceRepository.deletePretendance,
        (pretendances, pretendance) =>
            pretendances..removeWhere((p) => p.id == pretendance.id),
        pretendance.id,
        pretendance);
  }

  Future<AsyncValue<List<Pretendance>>> copy() async {
    return state.when(
      data: (pretendances) async {
        return AsyncValue.data(pretendances);
      },
      loading: () async {
        return const AsyncValue.loading();
      },
      error: (error, stackTrace) async {
        return AsyncValue.error(error, stackTrace);
      },
    );
  }

  void shuffle() {
    state.when(
      data: (pretendances) {
        final serio = [];
        final pipo = [];
        final blank = [];
        for (var pretendance in pretendances) {
          if (pretendance.listType == ListType.serio) {
            serio.add(pretendance);
          } else if (pretendance.listType == ListType.pipo) {
            pipo.add(pretendance);
          } else {
            blank.add(pretendance);
          }
        }
        serio.shuffle();
        pipo.shuffle();
        blank.shuffle();
        state = AsyncValue.data([...pipo, ...serio, ...blank]);
      },
      loading: () {},
      error: (error, stackTrace) {},
    );
  }
}

final pretendanceListProvider = StateNotifierProvider<PretendanceListNotifier,
    AsyncValue<List<Pretendance>>>((ref) {
  final token = ref.watch(tokenProvider);
  final pretendanceListNotifier = PretendanceListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await pretendanceListNotifier.loadPretendanceList();
  });
  return pretendanceListNotifier;
});
