import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/repositories/user_list_repository.dart';

final userListProvider = Provider((ref) {
  return UserListRepository();
});

final userList = FutureProvider.autoDispose((ref) async {
  return ref.watch(userListProvider).getAllUsers();
});
