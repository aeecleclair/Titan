import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class AssociationMembershipListNotifier
    extends ListNotifierAPI<MembershipSimple> {
  Openapi get associationMembershipRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<MembershipSimple>> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<MembershipSimple>>>
  loadAssociationMemberships() async {
    return await loadList(associationMembershipRepository.membershipsGet);
  }

  Future<bool> createAssociationMembership(
    MembershipSimple associationMembership,
  ) async {
    return await add(
      () => associationMembershipRepository.membershipsPost(
        body: AppCoreMembershipsSchemasMembershipsMembershipBase(
          name: associationMembership.name,
          managerGroupId: associationMembership.managerGroupId,
        ),
      ),
      associationMembership,
    );
  }

  Future<bool> updateAssociationMembership(
    MembershipSimple associationMembership,
  ) async {
    return await update(
      () => associationMembershipRepository
          .membershipsAssociationMembershipIdPatch(
            associationMembershipId: associationMembership.id,
            body: AppCoreMembershipsSchemasMembershipsMembershipBase(
              name: associationMembership.name,
              managerGroupId: associationMembership.managerGroupId,
            ),
          ),
      (membership) => membership.id,
      associationMembership,
    );
  }

  Future<bool> deleteAssociationMembership(
    MembershipSimple associationMembership,
  ) async {
    return await delete(
      () => associationMembershipRepository
          .membershipsAssociationMembershipIdDelete(
            associationMembershipId: associationMembership.id,
          ),
      (associationMembership) => associationMembership.id,
      associationMembership.id,
    );
  }
}

final allAssociationMembershipListProvider =
    NotifierProvider<
      AssociationMembershipListNotifier,
      AsyncValue<List<MembershipSimple>>
    >(AssociationMembershipListNotifier.new);
