import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/repositories/user_invitation_repository.dart';

class UserCreationNotifier extends StateNotifier<void> {
  final UserCreationRepository userCreationRepository;
  UserCreationNotifier({required this.userCreationRepository}) : super(null);

  Future<bool> createUsers(List<String> mailList) async {
    return await userCreationRepository.createUsers(mailList);
  }
}

final userCreationProvider = StateNotifierProvider<UserCreationNotifier, void>((
  ref,
) {
  final userCreationRepository = ref.watch(userCreationRepositoryProvider);
  return UserCreationNotifier(userCreationRepository: userCreationRepository);
});
