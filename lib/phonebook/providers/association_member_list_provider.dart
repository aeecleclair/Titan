import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:chopper/chopper.dart';
import 'package:myecl/phonebook/adapters/membership.dart';

class AssociationMemberListNotifier extends ListNotifierAPI<MemberComplete> {
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

  Future<bool> addMember(MemberComplete member,
      AppModulesPhonebookSchemasPhonebookMembershipBase membership) async {
    return await add(
      () async {
        final response = await associationMemberRepository
            .phonebookAssociationsMembershipsPost(body: membership);
        if (response.isSuccessful && response.body != null) {
          member.memberships.add(response.body!);
          return response;
        }
        throw Exception('Failed to add membership');
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
              membershipId: membership.id, body: membership.toMembershipEdit()),
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
    return await update(
      () => associationMemberRepository
          .phonebookAssociationsMembershipsMembershipIdPatch(
              membershipId: membership.id,
              body: membership
                  .copyWith(memberOrder: newIndex)
                  .toMembershipEdit()),
      (member) => member.id,
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
      (members) => members..removeWhere((i) => i.id == member.id),
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
