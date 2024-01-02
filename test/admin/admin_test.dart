import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/admin/repositories/group_repository.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/class/user.dart';

class MockGroupRepository extends Mock implements GroupRepository {}

class MockUserNotifier extends Mock implements StateNotifier<User> {}

void main() {
  group('Testing CoreUserSimple', () {
    test('Should return a group', () async {
      final group = CoreUserSimple.empty();
      expect(group, isA<CoreUserSimple>());
    });

    test('Should return a group with a name', () async {
      final group = CoreUserSimple.empty();
      expect(group.name, 'Nom');
    });

    test('Should update a group', () async {
      final group = CoreUserSimple.empty();
      CoreUserSimple newGroup = group.copyWith(name: 'name');
      expect(newGroup.name, 'name');
      newGroup = group.copyWith(description: 'description');
      expect(newGroup.description, 'description');
      newGroup = group.copyWith(id: 'id');
      expect(newGroup.id, 'id');
    });

    test('Should return correct toString', () async {
      final group = CoreUserSimple.empty();
      expect(group.toString(),
          'CoreUserSimple(name: Nom, description: Description, id: )');
    });

    test('Should parse a group from json', () async {
      final group = CoreUserSimple.fromJson({
        "id": "1",
        "name": "name",
        "description": "description",
      });
      expect(group.name, 'name');
    });

    test('Should return correct json', () async {
      const group = CoreUserSimple(
        id: "1",
        name: "name",
        description: "description",
      );
      expect(group.toJson(), {
        "id": "1",
        "name": "name",
        "description": "description",
      });
    });
  });

  group('Testing Group', () {
    test('Should return a group', () async {
      final group = Group.empty();
      expect(group, isA<Group>());
    });

    test('Should return a group with a name', () async {
      final group = Group.empty();
      expect(group.name, 'Nom');
    });

    test('Should update a group', () async {
      final group = Group.empty();
      Group newGroup = group.copyWith(name: 'name');
      expect(newGroup.name, 'name');
      newGroup = group.copyWith(description: 'description');
      expect(newGroup.description, 'description');
      newGroup = group.copyWith(id: 'id');
      expect(newGroup.id, 'id');
      newGroup = group.copyWith(members: [SimpleUser.empty()]);
      expect(newGroup.members, isA<List<SimpleUser>>());
      expect(newGroup.members.length, 1);
    });

    test('Should return a simple group', () async {
      final group = Group.empty();
      final CoreUserSimple = group.toCoreUserSimple();
      expect(CoreUserSimple, isA<CoreUserSimple>());
      expect(CoreUserSimple.name, 'Nom');
      expect(CoreUserSimple.description, 'Description');
      expect(CoreUserSimple.id, '');
    });

    test('Should print a group', () async {
      final group = Group.empty();
      expect(group.toString(),
          'Group(id: , name: Nom, description: Description, members: [])');
    });

    test('Should parse a group from json', () async {
      final group = Group.fromJson({
        "id": "1",
        "name": "name",
        "description": "description",
        "members": [
          {
            "id": "1",
            "name": "name",
            "firstname": "firstname",
            "nickname": "nickname",
          }
        ]
      });
      expect(group.name, 'name');
      expect(group.members, isA<List<SimpleUser>>());
      expect(group.members.length, 1);
      expect(group.members[0].name, 'Name');
    });

    test('Should return correct json', () async {
      final group = Group(
        id: "1",
        name: "name",
        description: "description",
        members: [
          SimpleUser(
            id: "1",
            name: "name",
            firstname: "firstname",
            nickname: null,
          )
        ],
      );
      expect(group.toJson(), {
        "id": "1",
        "name": "name",
        "description": "description",
        "members": [
          {
            "id": "1",
            "name": "name",
            "firstname": "firstname",
            "nickname": null,
          }
        ]
      });
    });
  });
}
