import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/class/association_groupement.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/class/membership.dart';
import 'package:titan/phonebook/providers/roles_tags_provider.dart';

int getPosition(CompleteMember member, String associationId, int year) {
  Membership membership = member.memberships.firstWhere(
    (element) =>
        element.associationId == associationId && element.mandateYear == year,
  );
  return membership.order;
}

List<CompleteMember> sortedMembers(
  List<CompleteMember> members,
  String associationId,
  int year,
) {
  return members..sort(
    (a, b) => getPosition(
      a,
      associationId,
      year,
    ).compareTo(getPosition(b, associationId, year)),
  );
}

List<Association> sortedAssociationByKind(
  List<Association> associations,
  List<AssociationGroupement> groupements,
) {
  Map<String, List<Association>> sortedByGroupement = {
    for (var groupement in groupements) groupement.id: [],
  };
  for (Association association in associations) {
    sortedByGroupement[association.groupementId]!.add(association);
  }
  for (List<Association> list in sortedByGroupement.values) {
    list.sort(
      (a, b) => removeDiacritics(
        a.name,
      ).toLowerCase().compareTo(removeDiacritics(b.name).toLowerCase()),
    );
  }
  // Flatten the sorted map values into a single list
  return sortedByGroupement.values.expand((list) => list).toList();
}

Color getColorFromTagList(WidgetRef ref, List<String> tags) {
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
