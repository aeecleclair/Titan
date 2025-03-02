import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
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

  Future<bool> addMember(
    MemberComplete member,
    AppModulesPhonebookSchemasPhonebookMembershipBase membership,
  ) async {
    return await handleState(
      (d) async {
        final response = await associationMemberRepository
            .phonebookAssociationsMembershipsPost(body: membership);
        final data = response.body;
        if (response.isSuccessful && data != null) {
          d.add(member);
          state = AsyncValue.data(d);
          return true;
        } else {
          throw response.error!;
        }
      },
      "Cannot add while loading",
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
        body: membership.toMembershipEdit(),
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
    return await update(
      () => associationMemberRepository
          .phonebookAssociationsMembershipsMembershipIdPatch(
        membershipId: membership.id,
        body: membership.copyWith(memberOrder: newIndex).toMembershipEdit(),
      ),
      (member) => member.id,
      member,
    );
  }

  Future<bool> deleteMember(
    String memberId,
    String membershipId,
  ) async {
    return await delete(
      () => associationMemberRepository
          .phonebookAssociationsMembershipsMembershipIdDelete(
        membershipId: membershipId,
      ),
      (m) => m.id,
      memberId,
    );
  }
}

final associationMemberListProvider = StateNotifierProvider<
    AssociationMemberListNotifier, AsyncValue<List<MemberComplete>>>((ref) {
  final associationMemberRepository = ref.watch(repositoryProvider);
  AssociationMemberListNotifier provider = AssociationMemberListNotifier(
    associationMemberRepository: associationMemberRepository,
  );
  tokenExpireWrapperAuth(ref, () async {
    final association = ref.watch(associationProvider);

    await provider.loadMembers(
      association.id,
      association.mandateYear,
    );
  });
  return provider;
});
