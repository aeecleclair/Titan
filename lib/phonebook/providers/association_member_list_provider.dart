import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AssociationMemberListNotifier extends ListNotifier2<MemberComplete> {
  final Openapi associationMemberRepository;
  AssociationMemberListNotifier({required this.associationMemberRepository})
      : super(const AsyncValue.loading());

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

  // requires work
  Future<bool> addMember(MemberComplete member, AppModulesPhonebookSchemasPhonebookMembershipBase membership) async {
    return await add(
      () async {
        final res = await associationMemberRepository
            .phonebookAssociationsMembershipsPost(
                body: membership);
        if (res.isSuccessful) {
          member.memberships.add(res.body!);
        }
        return member;
      },
      member,
    );
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
                  roleTags: membership.roleTags)),
      (members, member) =>
          members..[members.indexWhere((i) => i.id == member.id)] = member,
      member,
    );
  }

  Future<bool> reorderMember(
    MemberComplete member,
    MembershipComplete membership,
    int oldIndex,
    int newIndex,
  ) async {
    return await update(
      () => associationMemberRepository
          .phonebookAssociationsMembershipsMembershipIdPatch(
              membershipId: membership.id,
              body: MembershipEdit(
                  memberOrder: membership.memberOrder,
                  roleName: membership.roleName,
                  roleTags: membership.roleTags)),
      (members, member) {
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
        return members;
      },
      member,
    );
  }

  Future<bool> deleteMember(
    MemberComplete member,
    MembershipComplete membership,
  ) async {
    return await delete(
      () => associationMemberRepository
          .phonebookAssociationsMembershipsMembershipIdDelete(
              membershipId: membership.id),
      (members, member) => members..removeWhere((i) => i.id == member.id),
      member,
    );
  }
}

final associationMemberListProvider = StateNotifierProvider<
    AssociationMemberListNotifier, AsyncValue<List<MemberComplete>>>((ref) {
  final associationMemberRepository = ref.watch(repositoryProvider);
  AssociationMemberListNotifier provider = AssociationMemberListNotifier(
      associationMemberRepository: associationMemberRepository);
  tokenExpireWrapperAuth(ref, () async {
    final association = ref.watch(associationProvider);

    await provider.loadMembers(
      association.id,
      association.mandateYear,
    );
  });
  return provider;
});
