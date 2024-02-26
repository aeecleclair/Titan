import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/user/providers/user_provider.dart';

final isPhonebookAdminProvider = StateProvider<bool>((ref) {
  final user = ref.watch(userProvider);
  if (user.groups.map((e) => e.id).contains("53a669d6-84b1-4352-8d7c-421c1fbd9c6a")) {
    return true;
  }
  return false;
});

final isAssociationPresidentProvider = StateProvider<bool>((ref) {
  final association = ref.watch(associationProvider);
  final membersList = ref.watch(associationMemberListProvider);
  final me = ref.watch(userProvider);
  membersList.whenData((members) {
    if (members.map((e) => e.member.id).contains(me.id)) {
      if (members.firstWhere((member) => member.member.id == me.id)
        .memberships.firstWhere((membership) => membership.association.id == association.id)
        .rolesTags.contains(PhonebookTextConstants.presidentRoleTag)) {
          return true;
        }
    }
  });
  return false;
});

