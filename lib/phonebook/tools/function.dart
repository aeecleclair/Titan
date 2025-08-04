import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/class/association_groupement.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/class/membership.dart';
import 'package:titan/phonebook/providers/roles_tags_provider.dart';

Membership getMembershipForAssociation(
  CompleteMember member,
  Association association,
) {
  return member.memberships.firstWhere(
    (element) =>
        element.associationId == association.id &&
        element.mandateYear == association.mandateYear,
  );
}

int getPosition(CompleteMember member, Association association) {
  final membership = getMembershipForAssociation(member, association);
  return membership.order;
}

List<CompleteMember> sortedMembers(
  List<CompleteMember> members,
  Association association,
) {
  return members..sort(
    (a, b) =>
        getPosition(a, association).compareTo(getPosition(b, association)),
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
  if (tags.isEmpty) {
    return Colors.white;
  }
  final rolesTags = ref.watch(rolesTagsProvider);
  return rolesTags.maybeWhen(
    data: (allTags) {
      int index = tags.map((tag) => allTags.indexOf(tag)).toList().min;
      switch (index) {
        case 0:
          return const Color.fromARGB(255, 251, 109, 16);
        case 1:
          return const Color.fromARGB(255, 252, 145, 74);
        case 2:
          return const Color.fromARGB(255, 253, 193, 153);
      }
      return Colors.white;
    },
    orElse: () => Colors.white,
  );
}
