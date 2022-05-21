import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/repositories/user_list_repository.dart';

final userListRepositoryProvider = Provider((ref) {
  UserListRepository _userListRepository = UserListRepository();
  return _userListRepository;
});

final userList = FutureProvider.autoDispose((ref) async {
  return ref.watch(userListRepositoryProvider).getAllUsers();
});
