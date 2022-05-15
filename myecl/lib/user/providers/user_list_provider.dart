import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/providers/auth_token_provider.dart';
import 'package:myecl/user/repositories/user_list_repository.dart';

final userListRepositoryProvider = Provider((ref) {
  UserListRepository _userListRepository = UserListRepository();
  _userListRepository.setToken(ref.read(authTokenProvider));
  return _userListRepository;
});

final userList = FutureProvider.autoDispose((ref) async {
  return ref.watch(userListRepositoryProvider).getAllUsers();
});
