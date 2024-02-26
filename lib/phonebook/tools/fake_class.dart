import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/class/role.dart';

List<Association> fakeAssociations = [
  Association(id: '1', name: 'test1', description: 'description test1'),
  Association(id: '2', name: 'test2', description: 'description test2'),
  Association(id: '3', name: 'test3', description: 'description test3'),
  Association(id: '4', name: 'test4', description: 'description test4'),
  Association(id: '5', name: 'test5', description: 'description test5'),
  Association(id: '6', name: 'test6', description: 'description test6'),
  Association(id: '7', name: 'test7', description: 'description test7'),
];

List<Role> fakeRoles = [
  Role(id: '1', name: 'Prez\''),
  Role(id: '2', name: 'Trez\''),
  Role(id: '3', name: 'SG'),
  Role(id: '4', name: 'Fillot'),
  Role(id: '5', name: 'VP Emprunt'),
];

List<CompleteMember> fakeMembersContructor(Association association) {
  return [
    CompleteMember(
        member: Member(
            name: 'Dupond',
            firstname: 'Michel',
            nickname: 'Testouille',
            id: '1',
            email: 'test1@useless'),
        memberships: [Membership(association: association, role: fakeRoles[0])]),
    CompleteMember(
        member: Member(
            name: 'Debouck',
            firstname: 'Frank',
            nickname: 'Chad',
            id: '2',
            email: 'test2@useless'),
        memberships: [Membership(association: association, role: fakeRoles[1])]),
    CompleteMember(
        member: Member(
            name: 'Ray',
            firstname: 'Pascal',
            nickname: 'Salut',
            id: '3',
            email: 'test3@useless'),
        memberships: [Membership(association: association, role: fakeRoles[2])]),
    CompleteMember(
        member: Member(
            name: 'Guarriguenc',
            firstname: 'Jean-Luc',
            nickname: 'Cascouille',
            id: '4',
            email: 'test4@useless'),
        memberships: [
          Membership(association: association, role: fakeRoles[3]),
          Membership(
              association: Association(
                  id: '12', name: 'testTest', description: 'JSP frère'),
              role: fakeRoles[4])
        ]),
  ];
}
