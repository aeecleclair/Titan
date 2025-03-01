import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/adapters/list.dart';

class ListListNotifier extends ListNotifierAPI<ListReturn> {
  final Openapi listRepository;
  ListListNotifier({required this.listRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<ListReturn>>> loadListList() async {
    await loadList(listRepository.campaignListsGet);
    shuffle();
    return state;
  }

  Future<bool> addList(ListBase list) async {
    return await add(() => listRepository.campaignListsPost(body: list), list);
  }

  Future<bool> updateList(ListReturn list) async {
    return await update(
      () => listRepository.campaignListsListIdPatch(
        listId: list.id,
        body: list.toListEdit(),
      ),
      (list) => list.id,
      list,
    );
  }

  Future<bool> deleteList(ListReturn list) async {
    return await delete(
      () => listRepository.campaignListsListIdDelete(listId: list.id),
      (lists) => lists..removeWhere((p) => p.id == list.id),
    );
  }

  Future<bool> deleteLists({ListType? type}) async {
    return await delete(
      () => listRepository.campaignListsDelete(listType: type),
      (lists) =>
          lists..removeWhere((p) => type != null ? p.type == type : true),
    );
  }

  Future<AsyncValue<List<ListReturn>>> copy() async {
    return state.when(
      data: (lists) async => AsyncValue.data(lists),
      loading: () async => const AsyncValue.loading(),
      error: (error, stackTrace) async => AsyncValue.error(error, stackTrace),
    );
  }

  void shuffle() {
    state.maybeWhen(
      data: (lists) {
        final serious = [];
        final fakes = [];
        final blank = [];
        for (var list in lists) {
          if (list.type == ListType.serio) {
            serious.add(list);
          } else if (list.type == ListType.pipo) {
            fakes.add(list);
          } else {
            blank.add(list);
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

final listListProvider =
    StateNotifierProvider<ListListNotifier, AsyncValue<List<ListReturn>>>(
        (ref) {
  final listRepository = ref.watch(repositoryProvider);
  final listListNotifier = ListListNotifier(listRepository: listRepository);
  tokenExpireWrapperAuth(ref, () async {
    await listListNotifier.loadListList();
  });
  return listListNotifier;
});
