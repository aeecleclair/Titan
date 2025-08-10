import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/repositories/user_invitation_repository.dart';

class UserInvitationNotifier extends StateNotifier {
  final UserInvitationRepository userInvitationRepository;
  UserInvitationNotifier({required this.userInvitationRepository})
    : super(null);

  Future<bool> createUsers(List<String> mailList) async {
    return await userInvitationRepository.createUsers(mailList);
  }
}

final userInvitationProvider =
    StateNotifierProvider<UserInvitationNotifier, void>((ref) {
      final userInvitationRepository = ref.watch(
        userInvitationRepositoryProvider,
      );
      return UserInvitationNotifier(
        userInvitationRepository: userInvitationRepository,
      );
    });
