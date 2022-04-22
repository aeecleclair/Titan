import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/models/user.dart';
import 'package:myecl/user/providers/user_id_provider.dart';
import 'package:myecl/user/repositories/user_repository.dart';

// final userRepositoryProvider = Provider((ref) {
//   return UserRepository();
// });

// final futureUser =
//     FutureProvider.autoDispose<User>((ref) async {
//   return ref.watch(userRepositoryProvider).getUser(ref.watch(userIdProvider));
// });

// final user = Provider.autoDispose((ref) {
//   return ref.watch(futureUser).when(
//         data: (data) => data,
//         error: (err, stack) => User.empty(),
//         loading: () => User.empty(),
//       );
// });

class UserNotifier extends StateNotifier<User> {
  final UserRepository _userRepository = UserRepository();
  UserNotifier() : super(User.empty());

  void setUser(User user) {
    state = user;
  }

  void loadUser(String id) async {
    state = await _userRepository.getUser(id);
  }

  void updateUser(User user) async {
    await _userRepository.updateUser(state.id, user);
    state = user;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  UserNotifier _userNotifier =  UserNotifier();
  _userNotifier.loadUser(ref.watch(userIdProvider));
  return _userNotifier;
});

// final futureUserList = FutureProvider.autoDispose((ref) async {
//   return ref.watch(userRepositoryProvider).getAllUsers();
// });
