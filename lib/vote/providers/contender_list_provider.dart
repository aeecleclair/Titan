import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ContenderListNotifier extends ListNotifier2<ListReturn> {
  final Openapi contenderRepository;
  ContenderListNotifier({required this.contenderRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<ListReturn>>> loadContenderList() async {
    await loadList(contenderRepository.campaignListsGet);
    shuffle();
    return state;
  }

  Future<bool> addContender(ListReturn contender) async {
    return await add(
        (contender) async => contenderRepository.campaignListsPost(
                body: ListBase(
              sectionId: contender.section.id,
              name: contender.name,
              description: contender.description,
              type: contender.type,
              members: contender.members
                  .map((e) => ListMemberBase(
                        role: e.role,
                        userId: e.userId,
                      ))
                  .toList(),
              program: contender.program,
            )),
        contender);
  }

  Future<bool> updateContender(ListReturn contender) async {
    return await update(
        (contender) async => contenderRepository.campaignListsListIdPatch(
            listId: contender.id,
            body: ListEdit(
              name: contender.name,
              description: contender.description,
              type: contender.type,
              members: contender.members
                  .map((e) => ListMemberBase(
                        role: e.role,
                        userId: e.userId,
                      ))
                  .toList(),
              program: contender.program,
            )),
        (contenders, contender) => contenders
          ..[contenders.indexWhere((p) => p.id == contender.id)] = contender,
        contender);
  }

  Future<bool> deleteContender(ListReturn contender) async {
    return await delete(
        (contenderId) async =>
            contenderRepository.campaignListsListIdDelete(listId: contenderId),
        (contenders, contender) =>
            contenders..removeWhere((p) => p.id == contender.id),
        contender.id,
        contender);
  }

  Future<bool> deleteContenders({ListType? type}) async {
    return await delete(
        (_) async => contenderRepository.campaignListsDelete(listType: type),
        (contenders, contender) => contenders
          ..removeWhere((p) => type != null ? p.type == type : true),
        type?.value ?? "",
        ListReturn.fromJson({}));
  }

  Future<AsyncValue<List<ListReturn>>> copy() async {
    return state.when(
      data: (contenders) async => AsyncValue.data(contenders),
      loading: () async => const AsyncValue.loading(),
      error: (error, stackTrace) async => AsyncValue.error(error, stackTrace),
    );
  }

  void shuffle() {
    state.maybeWhen(
      data: (contenders) {
        final serious = [];
        final fakes = [];
        final blank = [];
        for (var contender in contenders) {
          if (contender.type == ListType.serio) {
            serious.add(contender);
          } else if (contender.type == ListType.pipo) {
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
      orElse: () {},
    );
  }
}

final contenderListProvider =
    StateNotifierProvider<ContenderListNotifier, AsyncValue<List<ListReturn>>>(
        (ref) {
  final contenderRepository = ref.watch(repositoryProvider);
  final contenderListNotifier =
      ContenderListNotifier(contenderRepository: contenderRepository);
  tokenExpireWrapperAuth(ref, () async {
    await contenderListNotifier.loadContenderList();
  });
  return contenderListNotifier;
});
