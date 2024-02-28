import 'dart:math';

import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/association_kinds.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/membership.dart';

int getPosition(
    CompleteMember member, String associationId, List<String> rolesTags) {
  Membership membership = member.memberships
      .firstWhere((element) => element.associationId == associationId);
  if (membership.rolesTags.isEmpty || membership.rolesTags.first == "") {
    return rolesTags.length;
  }
  return membership.rolesTags
      .map((roleTag) => rolesTags.indexOf(roleTag))
      .reduce((value, element) => min(value, element));
}

List<CompleteMember> sortedMembers(List<CompleteMember> members,
    String associationId, List<String> rolesTags) {
  return members
    ..sort((a, b) => getPosition(a, associationId, rolesTags)
        .compareTo(getPosition(b, associationId, rolesTags)));
}

List<Association> sortedAssociationByKind(
    List<Association> associations, AssociationKinds kinds) {
  List<Association> sorted = [];
  List<List<Association>> sortedByKind =
      List.generate(kinds.kinds.length, (index) => []);
  for (Association association in associations) {
    sortedByKind[kinds.kinds.indexOf(association.kind)].add(association);
  }
  for (List<Association> list in sortedByKind) {
    list.sort((a, b) => a.name.compareTo(b.name));
    sorted.addAll(list);
  }
  return sorted;
}
