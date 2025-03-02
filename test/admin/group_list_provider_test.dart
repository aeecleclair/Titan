import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/generated/client_index.dart';
import 'package:myecl/generated/openapi.enums.swagger.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class MockGroupRepository extends Mock implements Openapi {}

class MockCoreUserNotifier extends Mock implements StateNotifier<CoreUser> {}

void main() {
  group('GroupListNotifier', () {
    final group = CoreGroupSimple(
      id: "1",
      name: "name",
      description: "description",
    );
    final coreUser = CoreUser(
      id: "1",
      name: "name",
      firstname: "firstname",
      nickname: null,
      email: "email",
      accountType: AccountType.$external,
      groups: [group],
      birthday: DateTime.now(),
      createdOn: DateTime.now(),
      floor: '',
      phone: '',
      promo: null,
      schoolId: '',
    );
    final modifiedGroup = CoreGroupSimple(
      id: '1',
      name: 'Modified Group',
      description: 'Modified Description',
    );
    final existingGroup = CoreGroupSimple(
      id: '1',
      name: 'Existing Group',
      description: 'Existing Description',
    );

    final newGroup = CoreGroupCreate.fromJson({});
    final returnedGroup = CoreGroupSimple.fromJson({}).copyWith(id: "2");

    test('Should return a group', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.groupsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('[]', 200),
          [CoreGroupSimple.fromJson({})],
        ),
      );
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      final groupList = await groupNotifier.loadGroups();
      expect(groupList, isA<AsyncData<List<CoreGroupSimple>>>());
      expect(
        groupList.when(
          data: (liste) => liste,
          error: (e, s) => null,
          loading: () => null,
        ),
        isA<List<CoreGroupSimple>>(),
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

    test('Should return an empty list when no groups are available', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.groupsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), []),
      );
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      final groupList = await groupNotifier.loadGroups();
      expect(groupList, isA<AsyncData<List<CoreGroupSimple>>>());
      expect(
        groupList.when(
          data: (liste) => liste,
          error: (e, s) => null,
          loading: () => null,
        ),
        isEmpty,
      );
    });

    test('Should handle error when loading groups', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.groupsGet()).thenThrow(Exception('Error'));
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      final groupList = await groupNotifier.loadGroups();
      expect(groupList, isA<AsyncError>());
    });

    test('Should return a group from coreUser', () async {
      final mockGroup = MockGroupRepository();
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      final groupList = await groupNotifier.loadGroupsFromUser(coreUser);
      expect(groupList, isA<AsyncData<List<CoreGroupSimple>>>());
      expect(
        groupList.when(
          data: (liste) => liste,
          error: (e, s) => null,
          loading: () => null,
        ),
        isA<List<CoreGroupSimple>>(),
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
      when(() => mockGroup.groupsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('[]', 200),
          [CoreGroupSimple.fromJson({})],
        ),
      );
      when(() => mockGroup.groupsPost(body: any(named: 'body'))).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), returnedGroup),
      );
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      await groupNotifier.loadGroups();
      final group = await groupNotifier.createGroup(newGroup);
      expect(group, true);
    });

    test('Should handle error when creating a group', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.groupsPost(body: any(named: 'body')))
          .thenThrow(Exception('Error'));
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      final result = await groupNotifier.createGroup(newGroup);
      expect(result, false);
    });

    test('Should update a group', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.groupsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('[]', 200),
          [CoreGroupSimple.fromJson({}), returnedGroup],
        ),
      );
      when(
        () => mockGroup.groupsGroupIdPatch(
          groupId: any(named: 'groupId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), true),
      );
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      await groupNotifier.loadGroups();
      expect(await groupNotifier.updateGroup(returnedGroup), true);
    });

    test('Should handle error when updating a group', () async {
      final mockGroup = MockGroupRepository();
      when(
        () => mockGroup.groupsGroupIdPatch(
          groupId: any(named: 'groupId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Error'));
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      final result = await groupNotifier.updateGroup(returnedGroup);
      expect(result, false);
    });

    test('Should delete a group', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.groupsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('[]', 200),
          [CoreGroupSimple.fromJson({}), returnedGroup],
        ),
      );
      when(() => mockGroup.groupsGroupIdDelete(groupId: any(named: 'groupId')))
          .thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), true),
      );
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      await groupNotifier.loadGroups();
      expect(await groupNotifier.deleteGroup(returnedGroup.id), true);
    });

    test('Should handle error when deleting a group', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.groupsGroupIdDelete(groupId: any(named: 'groupId')))
          .thenThrow(Exception('Error'));
      final GroupListNotifier groupNotifier =
          GroupListNotifier(groupRepository: mockGroup);
      final result = await groupNotifier.deleteGroup("2");
      expect(result, false);
    });

    test(
        'setGroup should modify an existing CoreGroupSimple object in the list',
        () {
      final mockGroup = MockGroupRepository();
      final groupListNotifier = GroupListNotifier(groupRepository: mockGroup);
      groupListNotifier.state = AsyncValue.data([existingGroup]);
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
    });
  });
}
