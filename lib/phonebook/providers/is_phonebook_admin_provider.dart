import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_list_provider.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/user/providers/user_provider.dart';

final isPhonebookAdminProvider = Provider<bool>((ref) {
  return hasUserPermission(ref, PhonebookPermissionConstants.managePhonebook);
});

final isAssociationPresidentProvider = Provider<bool>((ref) {
  final association = ref.watch(associationProvider);
  final membersList = ref.watch(associationMemberListProvider);
  final me = ref.watch(userProvider);
  bool isPresident = false;
  membersList.whenData((members) {
    if (members.map((e) => e.member.id).contains(me.id)) {
      if (members
          .firstWhere((completeMember) => completeMember.member.id == me.id)
          .memberships
          .firstWhere(
            (membership) => membership.associationId == association.id,
          )
          .rolesTags
          .contains(PhonebookTextConstants.presidentRoleTag)) {
        isPresident = true;
      }
    }
  });
  return isPresident;
});

final hasPhonebookAdminAccessProvider = Provider<bool>((ref) {
  final isPhonebookAdmin = ref.watch(isPhonebookAdminProvider);
  final isAnyGroupementAdmin = ref.watch(groupementAdminProvider);
  final isAdmin = ref.watch(isAdminProvider);
  return isPhonebookAdmin || isAdmin || isAnyGroupementAdmin.isNotEmpty;
});
