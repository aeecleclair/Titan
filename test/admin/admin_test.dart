import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/super_admin/class/account_type.dart';
import 'package:titan/admin/class/group.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/repositories/group_repository.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:titan/user/class/user.dart';

class MockGroupRepository extends Mock implements GroupRepository {}

class MockUserNotifier extends Mock implements StateNotifier<User> {}

void main() {
  group('Testing SimpleGroup', () {
    test('Should return a group', () async {
      final group = SimpleGroup.empty();
      expect(group, isA<SimpleGroup>());
    });

    test('Should return a group with a name', () async {
      final group = SimpleGroup.empty();
      expect(group.name, 'Nom');
    });

    test('Should update a group', () async {
      final group = SimpleGroup.empty();
      SimpleGroup newGroup = group.copyWith(name: 'name');
      expect(newGroup.name, 'name');
      newGroup = group.copyWith(description: 'description');
      expect(newGroup.description, 'description');
      newGroup = group.copyWith(id: 'id');
      expect(newGroup.id, 'id');
    });

    test('Should return correct toString', () async {
      final group = SimpleGroup.empty();
      expect(
        group.toString(),
        'SimpleGroup(name: Nom, description: Description, id: )',
      );
    });

    test('Should parse a group from json', () async {
      final group = SimpleGroup.fromJson({
        "id": "1",
        "name": "name",
        "description": "description",
      });
      expect(group.name, 'name');
    });

    test('Should return correct json', () async {
      final group = SimpleGroup(
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
      final simpleGroup = group.toSimpleGroup();
      expect(simpleGroup, isA<SimpleGroup>());
      expect(simpleGroup.name, 'Nom');
      expect(simpleGroup.description, 'Description');
      expect(simpleGroup.id, '');
    });

    test('Should print a group', () async {
      final group = Group.empty();
      expect(
        group.toString(),
        'Group(id: , name: Nom, description: Description, members: [])',
      );
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
            "account_type": "external",
          },
        ],
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
            accountType: AccountType(type: "external"),
            name: "name",
            firstname: "firstname",
            nickname: null,
          ),
        ],
      );
      expect(group.toJson(), {
        "id": "1",
        "name": "name",
        "description": "description",
        "members": [
          {
            "id": "1",
            "account_type": "external",
            "name": "name",
            "firstname": "firstname",
            "nickname": null,
          },
        ],
      });
    });
  });
}
