import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/user_association_membership.dart';
import 'package:titan/admin/repositories/association_membership_user_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class UserMembershiplistNotifier
    extends ListNotifier<UserAssociationMembership> {
  final AssociationMembershipUserRepository associationMembershipUserRepository;
  UserMembershiplistNotifier({
    required this.associationMembershipUserRepository,
  }) : super(const AsyncValue.loading());

  Future<AsyncValue<List<UserAssociationMembership>>>
  loadPersonalAssociationMembershipsList() async {
    return await loadList(
      () async => associationMembershipUserRepository
          .getPersonalAssociationMembershipList(),
    );
  }

  Future<AsyncValue<List<UserAssociationMembership>>>
  loadUserAssociationMembershipsList(String userId) async {
    return await loadList(
      () async => associationMembershipUserRepository
          .getUserAssociationMembershipList(userId),
    );
  }
}

final userMembershipListProvider =
    StateNotifierProvider<
      UserMembershiplistNotifier,
      AsyncValue<List<UserAssociationMembership>>
    >((ref) {
      final associationMembershipUserRepository = ref.watch(
        associationMembershipUserRepositoryProvider,
      );
      return UserMembershiplistNotifier(
        associationMembershipUserRepository:
            associationMembershipUserRepository,
      );
    });

final myMembershipListProvider =
    StateNotifierProvider<
      UserMembershiplistNotifier,
      AsyncValue<List<UserAssociationMembership>>
    >((ref) {
      final associationMembershipUserRepository = ref.watch(
        associationMembershipUserRepositoryProvider,
      );
      UserMembershiplistNotifier provider = UserMembershiplistNotifier(
        associationMembershipUserRepository:
            associationMembershipUserRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadPersonalAssociationMembershipsList();
      });
      return provider;
    });
