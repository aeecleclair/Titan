import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myemapp/admin/class/simple_group.dart';
import 'package:myemapp/tools/providers/list_notifier.dart';
import 'package:myemapp/tools/token_expire_wrapper.dart';
import 'package:myemapp/user/class/simple_users.dart';
import 'package:myemapp/user/repositories/user_list_repository.dart';

class UserListNotifier extends ListNotifier<SimpleUser> {
  final UserListRepository userListRepository;
  UserListNotifier({required this.userListRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<SimpleUser>>> filterUsers(
    String query, {
    List<SimpleGroup>? includeGroup,
    List<SimpleGroup>? excludeGroup,
  }) async {
    return await loadList(
      () async => userListRepository.searchUser(
        query,
        includeId: includeGroup?.map((e) => e.id).toList(),
        excludeId: excludeGroup?.map((e) => e.id).toList(),
      ),
    );
  }

  Future clear() async {
    state = const AsyncValue.data([]);
  }
}

final userList =
    StateNotifierProvider<UserListNotifier, AsyncValue<List<SimpleUser>>>((
      ref,
    ) {
      final userListRepository = ref.watch(userListRepositoryProvider);
      UserListNotifier userListNotifier = UserListNotifier(
        userListRepository: userListRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        userListNotifier.clear();
      });
      return userListNotifier;
    });
