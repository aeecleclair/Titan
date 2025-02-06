import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/user_association_membership.dart';
import 'package:myecl/admin/repositories/association_membership_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserMembershiplistNotifier
    extends ListNotifier<UserAssociationMembership> {
  final AssociationMembershipRepository associationMembershipRepository;
  UserMembershiplistNotifier({
    required this.associationMembershipRepository,
  }) : super(const AsyncValue.loading());

  Future<AsyncValue<List<UserAssociationMembership>>>
      loadPersonalAssociationMembershipsList() async {
    return await loadList(
      () async => associationMembershipRepository
          .getPersonalAssociationMembershipList(),
    );
  }

  Future<AsyncValue<List<UserAssociationMembership>>>
      loadUserAssociationMembershipsList(
    String userId,
  ) async {
    return await loadList(
      () async => associationMembershipRepository
          .getUserAssociationMembershipList(userId),
    );
  }
}

final userMembershipListProvider = StateNotifierProvider<
    UserMembershiplistNotifier,
    AsyncValue<List<UserAssociationMembership>>>((ref) {
  final associationMembershipRepository =
      ref.watch(associationMembershipRepositoryProvider);
  return UserMembershiplistNotifier(
    associationMembershipRepository: associationMembershipRepository,
  );
});

final myMembershipListProvider = StateNotifierProvider<
    UserMembershiplistNotifier,
    AsyncValue<List<UserAssociationMembership>>>((ref) {
  final associationMembershipRepository =
      ref.watch(associationMembershipRepositoryProvider);
  UserMembershiplistNotifier provider = UserMembershiplistNotifier(
    associationMembershipRepository: associationMembershipRepository,
  );
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadPersonalAssociationMembershipsList();
  });
  return provider;
});
