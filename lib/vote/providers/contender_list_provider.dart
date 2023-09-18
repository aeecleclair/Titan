import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/contender.dart';
import 'package:myecl/vote/repositories/contender_repository.dart';
import 'package:myecl/vote/tools/functions.dart';

class ContenderListNotifier extends ListNotifier<Contender> {
  final ContenderRepository contenderRepository = ContenderRepository();
  ContenderListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    contenderRepository.setToken(token);
  }

  Future<AsyncValue<List<Contender>>> loadContenderList() async {
    await loadList(contenderRepository.getContenders);
    shuffle();
    return state;
  }

  Future<bool> addContender(Contender contender) async {
    return await add(contenderRepository.createContender, contender);
  }

  Future<bool> updateContender(Contender contender) async {
    return await update(
        contenderRepository.updateContender,
        (contenders, contender) => contenders
          ..[contenders.indexWhere((p) => p.id == contender.id)] =
              contender,
        contender);
  }

  Future<bool> deleteContender(Contender contender) async {
    return await delete(
        contenderRepository.deleteContender,
        (contenders, contender) =>
            contenders..removeWhere((p) => p.id == contender.id),
        contender.id,
        contender);
  }

  Future<bool> deleteContenders({ListType? type}) async {
    return await delete(
        contenderRepository.deleteContenders,
        (contenders, contender) => contenders
          ..removeWhere((p) => type != null ? p.listType == type : true),
        listTypeToString(type),
        Contender.empty());
  }

  Future<AsyncValue<List<Contender>>> copy() async {
    return state.when(
      data: (contenders) async => AsyncValue.data(contenders),
      loading: () async => const AsyncValue.loading(),
      error: (error, stackTrace) async => AsyncValue.error(error, stackTrace),
    );
  }

  void shuffle() {
    state.when(
      data: (contenders) {
        final serious = [];
        final fakes = [];
        final blank = [];
        for (var contender in contenders) {
          if (contender.listType == ListType.serious) {
            serious.add(contender);
          } else if (contender.listType == ListType.fake) {
            fakes.add(contender);
          } else {
            blank.add(contender);
          }
        }
        serious.shuffle();
        fakes.shuffle();
        blank.shuffle();
        state = AsyncValue.data([...fakes, ...serious, ...blank]);
      },
      loading: () {},
      error: (error, stackTrace) {},
    );
  }
}

final contenderListProvider = StateNotifierProvider<ContenderListNotifier,
    AsyncValue<List<Contender>>>((ref) {
  final token = ref.watch(tokenProvider);
  final contenderListNotifier = ContenderListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await contenderListNotifier.loadContenderList();
  });
  return contenderListNotifier;
});
