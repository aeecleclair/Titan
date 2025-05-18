import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserListNotifier extends ListNotifierAPI<CoreUserSimple> {
  final Openapi userListRepository;
  UserListNotifier({required this.userListRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<CoreUserSimple>>> filterUsers(
    String query, {
    List<CoreGroupSimple>? includedGroups,
    List<CoreGroupSimple>? excludedGroups,
    List<AccountType>? includedAccountTypes,
    List<AccountType>? excludedAccountTypes,
  }) async {
    return await loadList(
      () async => userListRepository.usersSearchGet(
        query: query,
        includedGroups: includedGroups?.map((e) => e.id).toList(),
        excludedGroups: excludedGroups?.map((e) => e.id).toList(),
      ),
    );
  }

  Future clear() async {
    state = const AsyncValue.data([]);
  }
}

final userList =
    StateNotifierProvider<UserListNotifier, AsyncValue<List<CoreUserSimple>>>(
  (ref) {
    final userListRepository = ref.watch(repositoryProvider);
    return UserListNotifier(userListRepository: userListRepository)..clear();
  },
);
