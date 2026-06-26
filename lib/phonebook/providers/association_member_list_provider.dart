import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class AssociationMemberListNotifier extends ListNotifierAPI<MemberComplete> {
  Openapi get associationMemberRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<MemberComplete>> build() {
    final association = ref.watch(associationProvider);
    loadMembers(association.id, association.mandateYear);
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<MemberComplete>>> loadMembers(
    String associationId,
    int year,
  ) async {
    return await loadList(
      () async => associationMemberRepository
          .phonebookAssociationsAssociationIdMembersMandateYearGet(
            associationId: associationId,
            mandateYear: year,
          ),
    );
  }

  Future<bool> addMember(
    MemberComplete member,
    AppModulesPhonebookSchemasPhonebookMembershipBase membership,
  ) async {
    final res = await associationMemberRepository
        .phonebookAssociationsMembershipsPost(body: membership);
    if (!res.isSuccessful || res.body == null) return false;
    member.memberships.add(res.body!);
    state.whenData((members) {
      state = AsyncValue.data([...members, member]);
    });
    return true;
  }

  Future<bool> updateMember(
    MemberComplete member,
    MembershipComplete membership,
  ) async {
    return await update(
      () => associationMemberRepository
          .phonebookAssociationsMembershipsMembershipIdPatch(
            membershipId: membership.id,
            body: MembershipEdit(
              memberOrder: membership.memberOrder,
              roleName: membership.roleName,
              roleTags: membership.roleTags,
            ),
          ),
      (member) => member.id,
      member,
    );
  }

  Future<bool> reorderMember(
    MemberComplete member,
    MembershipComplete membership,
    int oldIndex,
    int newIndex,
  ) async {
    final response = await associationMemberRepository
        .phonebookAssociationsMembershipsMembershipIdPatch(
          membershipId: membership.id,
          body: MembershipEdit(
            memberOrder: membership.memberOrder,
            roleName: membership.roleName,
            roleTags: membership.roleTags,
          ),
        );
    if (!response.isSuccessful) return false;
    state.whenData((current) {
      final members = [...current];
      members.sort(
        (a, b) => a.memberships
            .firstWhere(
              (e) =>
                  e.associationId == membership.associationId &&
                  e.mandateYear == membership.mandateYear,
            )
            .memberOrder
            .compareTo(
              b.memberships
                  .firstWhere(
                    (e) =>
                        e.associationId == membership.associationId &&
                        e.mandateYear == membership.mandateYear,
                  )
                  .memberOrder,
            ),
      );
      members.remove(member);
      if (oldIndex < newIndex) newIndex--;
      members.insert(newIndex, member);

      for (int i = 0; i < members.length; i++) {
        List<MembershipComplete> memberships = members[i].memberships;
        MembershipComplete oldMembership = memberships.firstWhere(
          (e) =>
              e.associationId == membership.associationId &&
              e.mandateYear == membership.mandateYear,
        );
        memberships.remove(
          memberships.firstWhere(
            (e) =>
                e.associationId == membership.associationId &&
                e.mandateYear == membership.mandateYear,
          ),
        );
        memberships.add(oldMembership.copyWith(memberOrder: i));
        members[i].copyWith(memberships: memberships);
      }
      state = AsyncValue.data(members);
    });
    return true;
  }

  Future<bool> deleteMember(
    MemberComplete member,
    MembershipComplete membership,
  ) async {
    return await delete(
      () => associationMemberRepository
          .phonebookAssociationsMembershipsMembershipIdDelete(
            membershipId: membership.id,
          ),
      (member) => member.id,
      member.id,
    );
  }
}

final associationMemberListProvider =
    NotifierProvider<
      AssociationMemberListNotifier,
      AsyncValue<List<MemberComplete>>
    >(() => AssociationMemberListNotifier());
