import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/roles_tags_provider.dart';
import 'package:titan/phonebook/tools/function.dart';
import 'package:titan/user/providers/user_provider.dart';

final isPhonebookAdminProvider = Provider<bool>((ref) {
  final user = ref.watch(userProvider);
  return (user.groups ?? [])
      .map((e) => e.id)
      .contains("d3f91313-d7e5-49c6-b01f-c19932a7e09b"); // admin_phonebook
});

final hasPhonebookAdminAccessProvider = Provider<bool>((ref) {
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
        (m) => m.id == me.id,
        orElse: () => MemberComplete.empty(),
      );
      if (member.id == "") return false;
      final membership = getMembershipForAssociation(member, association);
      return rolesTags.maybeWhen(
        data: (tags) {
          return membership.roleTags?.contains(tags.tags.first) ?? false;
        },
        orElse: () => false,
      );
    },
    orElse: () => false,
  );
});
