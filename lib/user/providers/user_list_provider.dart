import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserListNotifier extends ListNotifier2<CoreUserSimple> {
  final Openapi userListRepository;
  UserListNotifier({required this.userListRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<CoreUserSimple>>> filterUsers(
    String query, {
    List<SimpleGroup>? includedGroups,
    List<SimpleGroup>? excludedGroups,
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
    UserListNotifier userListNotifier =
        UserListNotifier(userListRepository: userListRepository);
    tokenExpireWrapperAuth(ref, () async {
      userListNotifier.clear();
    });
    return userListNotifier;
  },
);
