import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/association_kinds.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/class/roles_tags.dart';

String nameConstructor(Map<String, AsyncValue<List<bool>>> data) {
  String name = '';
  data.forEach((key, value) {
    value.maybeWhen(
        data: (d) {
          if (d[0]) {
            name += "$key, ";
          }
        },
        orElse: () {});
  });
  if (name.isEmpty) {
    return "";
  }
  return name.substring(0, name.length - 2);
}

List<CompleteMember> sortMembers(List<CompleteMember> members,
    String associationId, List<String> rolesTags) {
  List<CompleteMember> sorted = [];
  List<List<CompleteMember>> sortedByRole =
      List.generate(rolesTags.length, (index) => []);
  for (CompleteMember member in members) {
    Membership membership = member.memberships
        .firstWhere((element) => element.associationId == associationId);
    List<String> memberRoleTags = membership.rolesTags;
    int highestPosition = 1000;
    for (String roleTag in memberRoleTags) {
      int position = rolesTags.indexOf(roleTag);
      if (position < highestPosition) {
        highestPosition = position;
      }
    }
    sortedByRole[highestPosition].add(member);
  }
  for (List<CompleteMember> list in sortedByRole) {
    sorted.addAll(list);
  }
  return sorted;
}

List<Association> sortAssociation(
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
