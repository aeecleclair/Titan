import 'dart:math';

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

int getPosition(
    CompleteMember member, String associationId, List<String> rolesTags) {
  Membership membership = member.memberships
      .firstWhere((element) => element.associationId == associationId);
  return membership.rolesTags
      .map((roleTag) => rolesTags.indexOf(roleTag))
      .reduce((value, element) => min(value, element));
}

List<CompleteMember> sortMembers(List<CompleteMember> members,
    String associationId, List<String> rolesTags) {
  return members
    ..sort((a, b) => getPosition(a, associationId, rolesTags)
        .compareTo(getPosition(b, associationId, rolesTags)));
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
