import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class ListListNotifier extends ListNotifierAPI<ListReturn> {
  Openapi get listRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<ListReturn>> build() {
    loadListList();
    return const AsyncValue.loading();
  }

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
        body: ListEdit(
          name: list.name,
          description: list.description,
          type: list.type,
          program: list.program,
          members: list.members
              .map((e) => ListMemberBase(userId: e.userId, role: e.role))
              .toList(),
        ),
      ),
      (list) => list.id,
      list,
    );
  }

  Future<bool> deleteList(ListReturn list) async {
    return await delete(
      () => listRepository.campaignListsListIdDelete(listId: list.id),
      (list) => list.id,
      list.id,
    );
  }

  Future<bool> deleteLists({ListType? type}) async {
    return await delete(
      () => listRepository.campaignListsDelete(listType: type),
      (list) => type != null ? list.type.name : "all",
      type?.name ?? "all",
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
    NotifierProvider<ListListNotifier, AsyncValue<List<ListReturn>>>(
      ListListNotifier.new,
    );
