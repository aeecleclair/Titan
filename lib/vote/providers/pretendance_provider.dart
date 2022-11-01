import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/repositories/pretendance_repository.dart';

class PretendanceNotifier extends ListNotifier<Pretendance> {
  final PretendanceRepository _pretendanceRepository = PretendanceRepository();
  PretendanceNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _pretendanceRepository.setToken(token);
  }

  Future<AsyncValue<List<Pretendance>>> loadPretendanceList() async {
    // return await loadList(_pretendanceRepository.getPretendances);
    state = AsyncValue.data([
      Pretendance(
        id: '1',
        name: 'Pretendance 1',
        description:
            'Illum nihil accusamus earum delectus doloribus quos consequatur impedit itaque. Recusandae ut excepturi qui rerum quisquam porro. Maiores consequuntur adipisci. Ea itaque provident. Est tenetur dolor officia voluptates molestiae. Perspiciatis voluptates autem rerum repellendus.',
        logoPath: '',
        listType: ListType.serio,
      ),
      Pretendance(
        id: '2',
        name: 'Pretendance 2',
        description:
            'Aut qui cum consequatur enim animi tenetur quam consectetur. Aut et assumenda tenetur saepe et. Est corporis consequatur. Ut deserunt enim quisquam et enim amet cupiditate ipsum.',
        logoPath: '',
        listType: ListType.pipo,
      ),
      Pretendance(
        id: '3',
        name: 'Pretendance 3',
        description:
            'Sed et veritatis voluptas nesciunt sed. Aperiam eius et eos optio quia. Facilis laudantium consequatur excepturi consequatur architecto. Nisi autem qui natus. Dolores sed dolores optio expedita sequi. Accusamus pariatur aliquam explicabo laboriosam sequi.',
        logoPath: '',
        listType: ListType.serio,
      ),
    ]);
    return state;
  }

  Future<bool> addPretendance(Pretendance pretendance) async {
    return await add(
        (p) async => _pretendanceRepository.createPretendance(p), pretendance);
  }

  Future<bool> updatePretendance(Pretendance pretendance) async {
    return await update(
        (p) async => _pretendanceRepository.updatePretendance(p),
        (pretendances, pretendance) => pretendances
          ..[pretendances.indexWhere((p) => p.id == pretendance.id)] =
              pretendance,
        pretendance);
  }

  Future<bool> deletePretendance(Pretendance pretendance) async {
    return await delete(
        (id) async => _pretendanceRepository.deletePretendance(id),
        (pretendances, pretendance) =>
            pretendances..removeWhere((p) => p.id == pretendance.id),
        pretendance.id,
        pretendance);
  }

  Future<AsyncValue<List<Pretendance>>> loadPretendanceListBySection(
      String sectionId) async {
    return await loadList(
        () => _pretendanceRepository.getPretendanceList(sectionId));
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
        return AsyncValue.error(error);
      },
    );
  }
}

final pretendanceProvider =
    StateNotifierProvider<PretendanceNotifier, AsyncValue<List<Pretendance>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  final pretendanceNotifier = PretendanceNotifier(token: token);
  pretendanceNotifier.loadPretendanceList();
  return pretendanceNotifier;
});
