import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/admin/class/account_type.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/group_list_provider.dart';
import 'package:titan/admin/repositories/group_repository.dart';
import 'package:titan/user/class/user.dart';

class MockGroupRepository extends Mock implements GroupRepository {}

class MockUserNotifier extends Mock implements StateNotifier<User> {}

void main() {
  group('GroupListNotifier', () {
    test('Should return a group', () async {
      final mockGroup = MockGroupRepository();
      when(
        () => mockGroup.getGroupList(),
      ).thenAnswer((_) async => [SimpleGroup.empty()]);
      final GroupListNotifier groupNotifier = GroupListNotifier(
        groupRepository: mockGroup,
      );
      final groupList = await groupNotifier.loadGroups();
      expect(groupList, isA<AsyncData<List<SimpleGroup>>>());
      expect(
        groupList.when(
          data: (liste) => liste,
          error: (e, s) => null,
          loading: () => null,
        ),
        isA<List<SimpleGroup>>(),
      );
      expect(
        groupList.when(
          data: (liste) => liste.length,
          error: (e, s) => 0,
          loading: () => 0,
        ),
        1,
      );
    });

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
        accountType: AccountType(type: "external"),
        groups: [group],
        birthday: DateTime.now(),
        createdOn: DateTime.now(),
        floor: '',
        phone: '',
        promo: null,
      );
      final GroupListNotifier groupNotifier = GroupListNotifier(
        groupRepository: mockGroup,
      );
      final groupList = await groupNotifier.loadGroupsFromUser(user);
      expect(groupList, isA<AsyncData<List<SimpleGroup>>>());
      expect(
        groupList.when(
          data: (liste) => liste,
          error: (e, s) => null,
          loading: () => null,
        ),
        isA<List<SimpleGroup>>(),
      );
      expect(
        groupList.when(
          data: (liste) => liste.length,
          error: (e, s) => 0,
          loading: () => 0,
        ),
        1,
      );
    });

    test('Should create a group', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(
        () => mockGroup.getGroupList(),
      ).thenAnswer((_) async => [SimpleGroup.empty()]);
      when(
        () => mockGroup.createGroup(newGroup),
      ).thenAnswer((_) async => newGroup);
      final GroupListNotifier groupNotifier = GroupListNotifier(
        groupRepository: mockGroup,
      );
      await groupNotifier.loadGroups();
      final group = await groupNotifier.createGroup(newGroup);
      expect(group, true);
    });

    test('Should update a group', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(
        () => mockGroup.getGroupList(),
      ).thenAnswer((_) async => [SimpleGroup.empty(), newGroup]);
      when(() => mockGroup.updateGroup(newGroup)).thenAnswer((_) async => true);
      final GroupListNotifier groupNotifier = GroupListNotifier(
        groupRepository: mockGroup,
      );
      await groupNotifier.loadGroups();
      expect(await groupNotifier.updateGroup(newGroup), true);
    });

    test('Should delete a group', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(
        () => mockGroup.getGroupList(),
      ).thenAnswer((_) async => [SimpleGroup.empty(), newGroup]);
      when(() => mockGroup.deleteGroup("2")).thenAnswer((_) async => true);
      final GroupListNotifier groupNotifier = GroupListNotifier(
        groupRepository: mockGroup,
      );
      await groupNotifier.loadGroups();
      expect(await groupNotifier.deleteGroup(newGroup), true);
    });

    test('Should return a group', () async {
      final mockGroup = MockGroupRepository();
      final newGroup = SimpleGroup.empty().copyWith(id: "2");
      when(
        () => mockGroup.getGroupList(),
      ).thenAnswer((_) async => [SimpleGroup.empty(), newGroup]);
      when(() => mockGroup.updateGroup(newGroup)).thenAnswer((_) async => true);
      final GroupListNotifier groupNotifier = GroupListNotifier(
        groupRepository: mockGroup,
      );
      await groupNotifier.loadGroups();
      expect(await groupNotifier.updateGroup(newGroup), true);
    });

    test(
      'setGroup should modify an existing SimpleGroup object in the list',
      () {
        final mockGroup = MockGroupRepository();
        final groupListNotifier = GroupListNotifier(groupRepository: mockGroup);
        final existingGroup = SimpleGroup(
          id: '1',
          name: 'Existing Group',
          description: 'Existing Description',
        );
        groupListNotifier.state = AsyncValue.data([existingGroup]);
        final modifiedGroup = SimpleGroup(
          id: '1',
          name: 'Modified Group',
          description: 'Modified Description',
        );
        groupListNotifier.setGroup(modifiedGroup);
        expect(
          groupListNotifier.state.when(
            data: (data) => data,
            error: (e, s) => [],
            loading: () => [],
          ),
          contains(modifiedGroup),
        );
        expect(
          groupListNotifier.state.when(
            data: (data) => data,
            error: (e, s) => [],
            loading: () => [],
          ),
          isNot(contains(existingGroup)),
        );
      },
    );
  });
}
