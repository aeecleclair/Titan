import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/association_kinds.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/class/roles_tags.dart';

String printFakeAssociations() {
  String result = '';
  for (Association association in fakeAssociations) {
    result += '$association\n';
  }
  return result;
}


List<Association> fakeAssociations = [
  Association(id: '1', name: 'test1', description: 'description test1', kind: 'Section', mandateYear: "2023"),
  Association(id: '2', name: 'test2', description: 'description test2', kind: 'Club', mandateYear: "2023"),
];

RolesTags fakeRolesTags = RolesTags(tags: [
  'Prez\'',
  'Trez\'',
  'SG',
  'VP com',
  'VP sponsor',
]);

AssociationKinds fakeAssociationKinds = AssociationKinds(kinds: [
  'Section',
  'Club',
  'Comité',
  'Fédération',
  'Association',
  'Autre',
]);


List<CompleteMember> fakeMembersList = [
    CompleteMember(
        member: Member(
            name: 'Dupond',
            firstname: 'Michel',
            nickname: 'Testouille',
            id: '1',
            email: 'test1@useless'),
        memberships: [Membership(association: fakeAssociations[0], rolesTags: [fakeRolesTags.tags[0]], apparentName: 'Prez\'')]),
    CompleteMember(
        member: Member(
            name: 'Debouck',
            firstname: 'Frank',
            nickname: 'Chad',
            id: '2',
            email: 'test2@useless'),
        memberships: [Membership(association: fakeAssociations[0], rolesTags: [fakeRolesTags.tags[1]], apparentName: 'Trez\'')]),
    CompleteMember(
        member: Member(
            name: 'Ray',
            firstname: 'Pascal',
            nickname: 'Salut',
            id: '3',
            email: 'test3@useless'),
        memberships: [Membership(association: fakeAssociations[1], rolesTags: [fakeRolesTags.tags[2]], apparentName: 'SG')]),
    CompleteMember(
        member: Member(
            name: 'Guarriguenc',
            firstname: 'Jean-Luc',
            nickname: 'Cascouille',
            id: '4',
            email: 'test4@useless'),
        memberships: [
          Membership(association: fakeAssociations[1], rolesTags: [fakeRolesTags.tags[0]], apparentName: 'Prez\''),
          Membership(association: fakeAssociations[0], rolesTags: [fakeRolesTags.tags[4]], apparentName: 'VP sponsor'),
        ]),
    CompleteMember(
        member: Member(
            name: 'Boulet',
            firstname: 'Jean',
            nickname: 'Jean',
            id: '5',
            email: 'test5@useless'),
        memberships: [Membership(association: fakeAssociations[1], rolesTags: [], apparentName: 'VP Emprunt')]),
    CompleteMember(
        member: Member(
            name: 'Sarrazin',
            firstname: 'François',
            nickname: 'Zarzou',
            id: '6',
            email: 'test6@useless'),
        memberships: [
          Membership(association: fakeAssociations[0], rolesTags: [fakeRolesTags.tags[3]], apparentName: 'VP com'),
          Membership(association: fakeAssociations[0], rolesTags: [], apparentName: 'VP Event')]),
  ];

