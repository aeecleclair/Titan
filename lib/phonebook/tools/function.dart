import 'package:diacritic/diacritic.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/class/association_groupement.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/class/membership.dart';

Membership getMembershipForAssociation(
  CompleteMember member,
  Association association,
) {
  return member.memberships.firstWhere(
    (element) =>
        element.associationId == association.id &&
        element.mandateYear == association.mandateYear,
    orElse: () => Membership.empty(),
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
