import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/class/role.dart';

List<Association> fakeAssociations = [
  Association(id: '1', name: 'test1', description: 'description test1'),
  Association(id: '2', name: 'test2', description: 'description test2'),
];

List<Role> fakeRoles = [
  Role(id: '1', name: 'Prez\''),
  Role(id: '2', name: 'Trez\''),
  Role(id: '3', name: 'SG'),
  Role(id: '4', name: 'Fillot'),
  Role(id: '5', name: 'VP Emprunt'),
  Role(id: '6', name: 'VP Compta'),
  Role(id: '7', name: 'VP Com'),
  Role(id: '8', name: 'VP Log'),
  Role(id: '9', name: 'VP RH'),
  Role(id: '10', name: 'VP Appro'),
];

List<CompleteMember> fakeMembersList = [
    CompleteMember(
        member: Member(
            name: 'Dupond',
            firstname: 'Michel',
            nickname: 'Testouille',
            id: '1',
            email: 'test1@useless'),
        memberships: [Membership(association: fakeAssociations[0], role: fakeRoles[0])]),
    CompleteMember(
        member: Member(
            name: 'Debouck',
            firstname: 'Frank',
            nickname: 'Chad',
            id: '2',
            email: 'test2@useless'),
        memberships: [Membership(association: fakeAssociations[0], role: fakeRoles[1])]),
    CompleteMember(
        member: Member(
            name: 'Ray',
            firstname: 'Pascal',
            nickname: 'Salut',
            id: '3',
            email: 'test3@useless'),
        memberships: [Membership(association: fakeAssociations[1], role: fakeRoles[2])]),
    CompleteMember(
        member: Member(
            name: 'Guarriguenc',
            firstname: 'Jean-Luc',
            nickname: 'Cascouille',
            id: '4',
            email: 'test4@useless'),
        memberships: [
          Membership(association: fakeAssociations[1], role: fakeRoles[3]),
          Membership(association: fakeAssociations[0], role: fakeRoles[4]),
        ]),
    CompleteMember(
        member: Member(
            name: 'Boulet',
            firstname: 'Jean',
            nickname: 'Jean',
            id: '5',
            email: 'test5@useless'),
        memberships: [Membership(association: fakeAssociations[1], role: fakeRoles[5])]),
    CompleteMember(
        member: Member(
            name: 'Sarrazin',
            firstname: 'François',
            nickname: 'Zarzou',
            id: '6',
            email: 'test6@useless'),
        memberships: [
          Membership(association: fakeAssociations[0], role: fakeRoles[6]),
          Membership(association: fakeAssociations[0], role: fakeRoles[7])]),
  ];

