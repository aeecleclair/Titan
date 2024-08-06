import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/association_kinds.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';

int getPosition(
  CompleteMember member,
  String associationId,
) {
  Membership membership = member.memberships
      .firstWhere((element) => element.associationId == associationId);
  return membership.order;
}

List<CompleteMember> sortedMembers(
  List<CompleteMember> members,
  String associationId,
) {
  return members
    ..sort(
      (a, b) => getPosition(a, associationId)
          .compareTo(getPosition(b, associationId)),
    );
}

List<Association> sortedAssociationByKind(
  List<Association> associations,
  AssociationKinds kinds,
) {
  List<Association> sorted = [];
  List<List<Association>> sortedByKind =
      List.generate(kinds.kinds.length, (index) => []);
  for (Association association in associations) {
    sortedByKind[kinds.kinds.indexOf(association.kind)].add(association);
  }
  for (List<Association> list in sortedByKind) {
    list.sort(
      (a, b) => removeDiacritics(a.name)
          .toLowerCase()
          .compareTo(removeDiacritics(b.name).toLowerCase()),
    );
    sorted.addAll(list);
  }
  return sorted;
}

Color getColorFromTagList(ref, List<String> tags) {
  final rolesTags = ref.watch(rolesTagsProvider).keys.toList();
  int index = 3;
  for (String tag in tags) {
    if (rolesTags.indexOf(tag) < index) {
      index = rolesTags.indexOf(tag);
    }
  }
  switch (index) {
    case 0:
      return const Color.fromARGB(255, 251, 109, 16);
    case 1:
      return const Color.fromARGB(255, 252, 145, 74);
    case 2:
      return const Color.fromARGB(255, 253, 193, 153);
  }
  return Colors.white;
}
