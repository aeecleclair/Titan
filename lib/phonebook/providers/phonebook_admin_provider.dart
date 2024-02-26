import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/user/providers/user_provider.dart';

final isPhonebookAdminProvider = StateProvider<bool>((ref) {
  final user = ref.watch(userProvider);
  if (user.groups.map((e) => e.id).contains("53a669d6-84b1-4352-8d7c-421c1fbd9c6a") || user.groups.map((e) => e.id).contains("6c6d7e88-fdb8-4e42-b2b5-3d3cfd12e7d6")) {
    return true;
  }
  return false;
});

final isAssociationPresidentProvider = StateProvider<bool>((ref) {
  final association = ref.watch(associationProvider);
  final membersList = ref.watch(associationMemberListProvider);
  final me = ref.watch(userProvider);
  bool isPresident = false;
  membersList.whenData((members) {
    if (members.map((e) => e.member.id).contains(me.id)) {
      if (members.firstWhere((completeMember) => completeMember.member.id == me.id)
        .memberships.firstWhere((membership) => membership.association.id == association.id)
        .rolesTags.contains(PhonebookTextConstants.presidentRoleTag)) {
          isPresident = true;
        }
    }
  });
  debugPrint("isPresident: $isPresident");
  return isPresident;
});

