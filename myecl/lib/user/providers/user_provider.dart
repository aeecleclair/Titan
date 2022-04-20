import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/models/list_users.dart';
import 'package:myecl/user/models/user.dart';
import 'package:myecl/user/repositories/user_repository.dart';

final userRepositoryProvider = Provider((ref) {
  return UserRepository();
});

final user = FutureProvider.autoDispose.family<Future<User>, String>((ref, userId) async {
  return ref.watch(userRepositoryProvider).getUsers(userId);
});

final userList = FutureProvider.autoDispose((ref) async {
  return ref.watch(userRepositoryProvider).getAllUsers();
});


