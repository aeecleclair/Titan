import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/class/membership.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/repositories/association_member_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class AssociationMemberListNotifier extends ListNotifier<CompleteMember> {
  final AssociationMemberRepository associationMemberRepository =
      AssociationMemberRepository();
  AssociationMemberListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    associationMemberRepository.setToken(token);
  }

  Future<AsyncValue<List<CompleteMember>>> loadMembers(
    String associationId,
    String year,
  ) async {
    return await loadList(
      () async => associationMemberRepository.getAssociationMemberList(
        associationId,
        year,
      ),
    );
  }

  Future<bool> addMember(CompleteMember member, Membership membership) async {
    return await add((member) async {
      member.memberships.add(
        await associationMemberRepository.addMember(membership),
      );
      return member;
    }, member);
  }

  Future<bool> updateMember(
    CompleteMember member,
    Membership membership,
  ) async {
    return await update(
      (member) => associationMemberRepository.updateMember(membership),
      (members, member) => members
        ..[members.indexWhere((i) => i.member.id == member.member.id)] = member,
      member,
    );
  }

  Future<bool> reorderMember(
    CompleteMember member,
    Membership membership,
    int oldIndex,
    int newIndex,
  ) async {
    return await update(
      (member) => associationMemberRepository.updateMember(membership),
      (members, member) {
        members.sort(
          (a, b) => a.memberships
              .firstWhere(
                (e) =>
                    e.associationId == membership.associationId &&
                    e.mandateYear == membership.mandateYear,
              )
              .order
              .compareTo(
                b.memberships
                    .firstWhere(
                      (e) =>
                          e.associationId == membership.associationId &&
                          e.mandateYear == membership.mandateYear,
                    )
                    .order,
              ),
        );
        members.remove(member);
        if (oldIndex < newIndex) newIndex--;
        members.insert(newIndex, member);

        for (int i = 0; i < members.length; i++) {
          List<Membership> memberships = members[i].memberships;
          Membership oldMembership = memberships.firstWhere(
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
          memberships.add(oldMembership.copyWith(order: i));
          members[i].copyWith(membership: memberships);
        }
        return members;
      },
      member,
    );
  }

  Future<bool> deleteMember(
    CompleteMember member,
    Membership membership,
  ) async {
    return await delete(
      associationMemberRepository.deleteMember,
      (members, member) =>
          members..removeWhere((i) => i.member.id == member.member.id),
      membership.id,
      member,
    );
  }
}

final associationMemberListProvider =
    StateNotifierProvider<
      AssociationMemberListNotifier,
      AsyncValue<List<CompleteMember>>
    >((ref) {
      final token = ref.watch(tokenProvider);
      AssociationMemberListNotifier provider = AssociationMemberListNotifier(
        token: token,
      );
      tokenExpireWrapperAuth(ref, () async {
        final association = ref.watch(associationProvider);

        await provider.loadMembers(
          association.id,
          association.mandateYear.toString(),
        );
      });
      return provider;
    });
