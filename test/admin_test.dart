// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/repositories/group_repository.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/class/user.dart';

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
      expect(group.toString(),
          'SimpleGroup(name: Nom, description: Description, id: )');
    });

    test('Should parse a group from json', () async {
      final group = SimpleGroup.fromJson({
        "id": "1",
        "name": "name",
        "description": "description",
      });
      expect(group.name, 'name'); // capitaliseAll
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

  group('Testing loadGroups', () {
    test('Should return a group', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty()]);
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      final groupList = await groupNotifier.loadGroups();
      expect(groupList, isA<AsyncData<List<SimpleGroup>>>());
      expect(
          groupList.when(
              data: (liste) => liste,
              error: (e, s) => null,
              loading: () => null),
          isA<List<SimpleGroup>>());
      expect(
          groupList.when(
              data: (liste) => liste.length,
              error: (e, s) => 0,
              loading: () => 0),
          1);
    });

    test('Should catch an error if groups are not loaded', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.getGroupList())
          .thenThrow((_) async => Exception("Error"));
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      expect(await groupNotifier.loadGroups(), isA<AsyncError>());
    });
  });

  group('Testing loadGroupsFromUser', () {
    test('Should return a group', () async {
      final mockGroup = MockGroupRepository();
      final group = SimpleGroup(
        id: "1",
        name: "name",
        description: "description",
      );
      final user = User(
        id: "1",
        name: "name",
        firstname: "firstname",
        nickname: null,
        email: "email",
        groups: [group],
        birthday: '',
        createdOn: '',
        floor: '',
        phone: '',
        promo: null,
      );
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      final groupList = await groupNotifier.loadGroupsFromUser(user);
      expect(groupList, isA<AsyncData<List<SimpleGroup>>>());
      expect(
          groupList.when(
              data: (liste) => liste,
              error: (e, s) => null,
              loading: () => null),
          isA<List<SimpleGroup>>());
      expect(
          groupList.when(
              data: (liste) => liste.length,
              error: (e, s) => 0,
              loading: () => 0),
          1);
    });
  });

  group('Testing createGroup', () {
    test('Should create a group', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty()]);
      when(() => mockGroup.createGroup(newGroup))
          .thenAnswer((_) async => newGroup);
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      await groupNotifier.loadGroups();
      final group = await groupNotifier.createGroup(newGroup);
      expect(group, true);
    });

    test('Should catch an error if group is not created', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty()]);
      when(() => mockGroup.createGroup(newGroup))
          .thenThrow((_) async => Exception("Error"));
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      await groupNotifier.loadGroups();
      expect(await groupNotifier.createGroup(newGroup), false);
    });

    test('Should catch an error if group list is not loaded', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty()]);
      when(() => mockGroup.createGroup(newGroup))
          .thenAnswer((_) async => newGroup);
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      expect(await groupNotifier.createGroup(newGroup), false);
    });
  });

  group('Testing updateGroup', () {
    test('Should update a group', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty(), newGroup]);
      when(() => mockGroup.updateGroup(newGroup)).thenAnswer((_) async => true);
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      await groupNotifier.loadGroups();
      expect(await groupNotifier.updateGroup(newGroup), true);
    });

    test('Should catch an error if group is not updated', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty(), newGroup]);
      when(() => mockGroup.updateGroup(newGroup))
          .thenThrow((_) async => Exception("Error"));
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      await groupNotifier.loadGroups();
      expect(await groupNotifier.updateGroup(newGroup), false);
    });

    test('Should catch an error if group list is not loaded', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty(), newGroup]);
      when(() => mockGroup.updateGroup(newGroup)).thenAnswer((_) async => true);
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      expect(await groupNotifier.updateGroup(newGroup), false);
    });

    test('Should catch an error if group is not found', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty()]);
      when(() => mockGroup.updateGroup(newGroup)).thenAnswer((_) async => true);
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      await groupNotifier.loadGroups();
      expect(await groupNotifier.updateGroup(newGroup), false);
    });
  });

  group('Testing deleteGroup', () {
    test('Should delete a group', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty(), newGroup]);
      when(() => mockGroup.deleteGroup("2")).thenAnswer((_) async => true);
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      await groupNotifier.loadGroups();
      expect(await groupNotifier.deleteGroup(newGroup), true);
    });

    test('Should catch an error if group is not deleted', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty(), newGroup]);
      when(() => mockGroup.deleteGroup("2"))
          .thenThrow((_) async => Exception("Error"));
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      await groupNotifier.loadGroups();
      expect(await groupNotifier.deleteGroup(newGroup), false);
    });

    test('Should catch an error if group list is not loaded', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty(), newGroup]);
      when(() => mockGroup.deleteGroup("2")).thenAnswer((_) async => true);
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      expect(await groupNotifier.deleteGroup(newGroup), false);
    });
  });

  group('Testing updateGroup', () {
    test('Should return a group', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty(), newGroup]);
      when(() => mockGroup.updateGroup(newGroup)).thenAnswer((_) async => true);
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      await groupNotifier.loadGroups();
      expect(await groupNotifier.updateGroup(newGroup), true);
    });

    test('Should catch an error if group is not updated', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty(), newGroup]);
      when(() => mockGroup.updateGroup(newGroup))
          .thenThrow((_) async => Exception("Error"));
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      await groupNotifier.loadGroups();
      expect(await groupNotifier.updateGroup(newGroup), false);
    });

    test('Should catch an error if group list is not loaded', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty(), newGroup]);
      when(() => mockGroup.updateGroup(newGroup)).thenAnswer((_) async => true);
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      expect(await groupNotifier.updateGroup(newGroup), false);
    });

    test('Should catch an error if group is not found', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty()]);
      when(() => mockGroup.updateGroup(newGroup)).thenAnswer((_) async => true);
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      await groupNotifier.loadGroups();
      expect(await groupNotifier.updateGroup(newGroup), false);
    });
  });

  group('Testing setGroup', () {
    test('setGroup should modify an existing SimpleGroup object in the list',
        () {
      final mockGroup = MockGroupRepository();
      final groupListNotifier = GroupListNotifier(groupRepository: mockGroup);
      final existingGroup = SimpleGroup(
          id: '1', name: 'Existing Group', description: 'Existing Description');
      groupListNotifier.state = AsyncValue.data([existingGroup]);
      final modifiedGroup = SimpleGroup(
          id: '1', name: 'Modified Group', description: 'Modified Description');
      groupListNotifier.setGroup(modifiedGroup);
      expect(
          groupListNotifier.state.when(
              data: (data) => data, error: (e, s) => [], loading: () => []),
          contains(modifiedGroup));
      expect(
          groupListNotifier.state.when(
              data: (data) => data, error: (e, s) => [], loading: () => []),
          isNot(contains(existingGroup)));
    });

    test('setGroup should keep the list unchanged if the group is not found',
        () {
      final mockGroup = MockGroupRepository();
      final groupListNotifier = GroupListNotifier(groupRepository: mockGroup);
      final existingGroup = SimpleGroup(
          id: '1', name: 'Existing Group', description: 'Existing Description');
      groupListNotifier.state = AsyncValue.data([existingGroup]);
      final modifiedGroup = SimpleGroup(
          id: '2', name: 'Modified Group', description: 'Modified Description');
      groupListNotifier.setGroup(modifiedGroup);
      expect(
          groupListNotifier.state.when(
              data: (data) => data, error: (e, s) => [], loading: () => []),
          contains(existingGroup));
      expect(
          groupListNotifier.state.when(
              data: (data) => data, error: (e, s) => [], loading: () => []),
          isNot(contains(modifiedGroup)));
    });
  });

  group('allGroupListProvider', () {
    test('should load groups successfully', () async {
      final mockGroupRepository = MockGroupRepository();
      final mockAsyncValue = [
        SimpleGroup(id: '1', name: 'Group 1', description: '')
      ];
      when(() => mockGroupRepository.getGroupList())
          .thenAnswer((_) async => mockAsyncValue);

      final provider = GroupListNotifier(groupRepository: mockGroupRepository);
      await provider.loadGroups();

      expect(
          provider.state.when(
              data: (data) => data, error: (e, s) => [], loading: () => []),
          mockAsyncValue);
    });

    test('should handle error when loading groups', () async {
      final mockGroupRepository = MockGroupRepository();
      const mockAsyncValue =
          AsyncValue.error('Error loading groups', StackTrace.empty);
      when(() => mockGroupRepository.getGroupList())
          .thenThrow((_) async => mockAsyncValue);

      final provider = GroupListNotifier(groupRepository: mockGroupRepository);
      await provider.loadGroups();

      expect(provider.state, isA<AsyncError>());
    });
  });

  group('userGroupListNotifier', () {
    test('should load user groups successfully', () async {
      final mockGroupRepository = MockGroupRepository();
      final groups = [
        SimpleGroup(id: '1', name: 'Group 1', description: ''),
        SimpleGroup(id: '2', name: 'Group 2', description: ''),
      ];
      final mockUserProvider = User.empty().copyWith(
        groups: groups,
      );
      final provider = GroupListNotifier(groupRepository: mockGroupRepository);
      await provider.loadGroupsFromUser(mockUserProvider);

      expect(
          provider.state.when(
              data: (data) => data, error: (e, s) => [], loading: () => []),
          groups);
    });
  });
}
