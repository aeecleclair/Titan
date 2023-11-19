import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/repositories/group_repository.dart';

class MockGroupRepository extends Mock implements GroupRepository {}

void main() {
  group('Testing Group Class', () {
    test('Should return a group', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.getGroupList())
          .thenAnswer((_) async => [SimpleGroup.empty()]);
      final group = await mockGroup.getGroupList();
      expect(group, isA<List<SimpleGroup>>());
      expect(group.length, 1);
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
}
