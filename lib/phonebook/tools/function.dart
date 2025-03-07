import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:myecl/generated/openapi.enums.swagger.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';
import 'package:myecl/tools/builders/enums_cleaner.dart';

int getPosition(
  MemberComplete member,
  String associationId,
) {
  MembershipComplete membership = member.memberships
      .firstWhere((element) => element.associationId == associationId);
  return membership.memberOrder;
}

List<MemberComplete> sortedMembers(
  List<MemberComplete> members,
  String associationId,
) {
  return members
    ..sort(
      (a, b) => getPosition(a, associationId)
          .compareTo(getPosition(b, associationId)),
    );
}

List<AssociationComplete> sortedAssociationByKind(
  List<AssociationComplete> associations,
  KindsReturn kinds,
) {
  List<AssociationComplete> sorted = [];
  List<List<AssociationComplete>> sortedByKind =
      List.generate(Kinds.values.length, (index) => []);
  final values = getEnumValues(Kinds.values).map((e) => e.value).toList();
  for (AssociationComplete association in associations) {
    if (association.kind.value == null) {
      continue;
    }
    sortedByKind[values.indexOf(association.kind.value)].add(association);
  }
  for (List<AssociationComplete> list in sortedByKind) {
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
