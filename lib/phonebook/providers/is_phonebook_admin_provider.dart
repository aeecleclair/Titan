import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/roles_tags_provider.dart';
import 'package:titan/phonebook/tools/function.dart';
import 'package:titan/user/providers/user_provider.dart';

final isPhonebookAdminProvider = StateProvider<bool>((ref) {
  final user = ref.watch(userProvider);
  return user.groups
      .map((e) => e.id)
      .contains("d3f91313-d7e5-49c6-b01f-c19932a7e09b"); // admin_phonebook
});

final hasPhonebookAdminAccessProvider = StateProvider<bool>((ref) {
  final isPhonebookAdmin = ref.watch(isPhonebookAdminProvider);
  final isAdmin = ref.watch(isAdminProvider);
  return isPhonebookAdmin || isAdmin;
});

final isAssociationPresidentProvider = Provider<bool>((ref) {
  final association = ref.watch(associationProvider);
  final rolesTags = ref.watch(rolesTagsProvider);
  final membersList = ref.watch(associationMemberListProvider);
  final me = ref.watch(userProvider);

  return membersList.maybeWhen(
    data: (members) {
      final member = members.firstWhere(
        (m) => m.member.id == me.id,
        orElse: () => CompleteMember.empty(),
      );
      if (member.member.id == "") return false;
      final membership = getMembershipForAssociation(member, association);
      return rolesTags.maybeWhen(
        data: (tags) {
          return membership.rolesTags.contains(tags.first);
        },
        orElse: () => false,
      );
    },
    orElse: () => false,
  );
});
