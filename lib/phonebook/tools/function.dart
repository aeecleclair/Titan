import 'package:diacritic/diacritic.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

MembershipComplete getMembershipForAssociation(
  MemberComplete member,
  AssociationComplete association,
) {
  return member.memberships.firstWhere(
    (element) =>
        element.associationId == association.id &&
        element.mandateYear == association.mandateYear,
    orElse: () => MembershipComplete.empty(),
  );
}

int getPosition(MemberComplete member, AssociationComplete association) {
  final membership = getMembershipForAssociation(member, association);
  return membership.memberOrder;
}

List<MemberComplete> sortedMembers(
  List<MemberComplete> members,
  AssociationComplete association,
) {
  return members..sort(
    (a, b) =>
        getPosition(a, association).compareTo(getPosition(b, association)),
  );
}

List<AssociationComplete> sortedAssociationByKind(
  List<AssociationComplete> associations,
  List<AssociationGroupement> groupements,
) {
  Map<String, List<AssociationComplete>> sortedByGroupement = {
    for (var groupement in groupements) groupement.id: [],
  };
  for (AssociationComplete association in associations) {
    sortedByGroupement[association.groupementId]!.add(association);
  }
  for (List<AssociationComplete> list in sortedByGroupement.values) {
    list.sort(
      (a, b) => removeDiacritics(
        a.name,
      ).toLowerCase().compareTo(removeDiacritics(b.name).toLowerCase()),
    );
  }
  // Flatten the sorted map values into a single list
  return sortedByGroupement.values.expand((list) => list).toList();
}
