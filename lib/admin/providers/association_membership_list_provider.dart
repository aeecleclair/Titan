import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/association_membership_simple.dart';
import 'package:titan/super_admin/repositories/association_membership_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class AssociationMembershipListNotifier
    extends ListNotifier<AssociationMembership> {
  final AssociationMembershipRepository associationMembershipRepository;
  AssociationMembershipListNotifier({
    required this.associationMembershipRepository,
  }) : super(const AsyncValue.loading());

  Future<AsyncValue<List<AssociationMembership>>>
  loadAssociationMemberships() async {
    return await loadList(
      associationMembershipRepository.getAssociationMembershipList,
    );
  }

  Future<bool> createAssociationMembership(
    AssociationMembership associationMembership,
  ) async {
    return await add(
      associationMembershipRepository.createAssociationMembership,
      associationMembership,
    );
  }

  Future<bool> updateAssociationMembership(
    AssociationMembership associationMembership,
  ) async {
    return await update(
      associationMembershipRepository.updateAssociationMembership,
      (associationMemberships, associationMembership) => associationMemberships
        ..[associationMemberships.indexWhere(
              (g) => g.id == associationMembership.id,
            )] =
            associationMembership,
      associationMembership,
    );
  }

  Future<bool> deleteAssociationMembership(
    AssociationMembership associationMembership,
  ) async {
    return await delete(
      associationMembershipRepository.deleteAssociationMembership,
      (associationMemberships, associationMembership) =>
          associationMemberships
            ..removeWhere((i) => i.id == associationMembership.id),
      associationMembership.id,
      associationMembership,
    );
  }
}

final allAssociationMembershipListProvider =
    StateNotifierProvider<
      AssociationMembershipListNotifier,
      AsyncValue<List<AssociationMembership>>
    >((ref) {
      final associationMembershipRepository = ref.watch(
        associationMembershipRepositoryProvider,
      );
      AssociationMembershipListNotifier provider =
          AssociationMembershipListNotifier(
            associationMembershipRepository: associationMembershipRepository,
          );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadAssociationMemberships();
      });
      return provider;
    });
