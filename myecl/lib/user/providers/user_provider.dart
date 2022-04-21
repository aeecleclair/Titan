import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/models/user.dart';
import 'package:myecl/user/repositories/user_repository.dart';

final userRepositoryProvider = Provider((ref) {
  return UserRepository();
});

final futureUser =
    FutureProvider.autoDispose.family<User, String>((ref, userId) async {
  return ref.watch(userRepositoryProvider).getUsers(userId);
});

final user = Provider.autoDispose.family<User, String>((ref, userId) {
  return ref.watch(futureUser(userId)).when(
        data: (data) => data,
        error: (err, stack) => User.empty(),
        loading: () => User.empty(),
      );
});

final futureUserList = FutureProvider.autoDispose((ref) async {
  return ref.watch(userRepositoryProvider).getAllUsers();
});
