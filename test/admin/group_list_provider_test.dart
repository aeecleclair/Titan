import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/admin/providers/all_group_list_provider.dart';
import 'package:titan/tools/repository/repository.dart';

class MockGroupRepository extends Mock implements Openapi {}

class MockCoreUserNotifier extends Mock implements Notifier<CoreUser> {}

void main() {
  group('GroupListNotifier', () {
    late MockGroupRepository mockGroup;
    late ProviderContainer container;
    late GroupListNotifier groupNotifier;
    final group = CoreGroupSimple(
      id: "1",
      name: "name",
      description: "description",
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
    final returnedGroup = CoreGroupSimple.empty().copyWith(id: "2");

    setUp(() async {
      mockGroup = MockGroupRepository();
      // Default stub for the build()-time auto-load.
      when(() => mockGroup.groupsGet()).thenAnswer(
        (_) async =>
            chopper.Response(http.Response('[]', 200), <CoreGroupSimple>[]),
      );
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockGroup)],
      );
      groupNotifier = container.read(allGroupListProvider.notifier);
      await Future(() {}); // let build()'s auto-load settle
    });

    tearDown(() => container.dispose());

    test('Should return a group', () async {
      when(() => mockGroup.groupsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), [
          CoreGroupSimple.empty(),
        ]),
      );
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
      when(
        () => mockGroup.groupsGet(),
      ).thenAnswer((_) async => chopper.Response(http.Response('[]', 200), []));
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
      when(() => mockGroup.groupsGet()).thenThrow(Exception('Error'));
      final groupList = await groupNotifier.loadGroups();
      expect(groupList, isA<AsyncError>());
    });

    test('Should return a group from coreUser', () async {
      when(() => mockGroup.groupsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), [
          CoreGroupSimple.empty(),
        ]),
      );
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

    test('Should create a group', () async {
      when(() => mockGroup.groupsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), [
          CoreGroupSimple.empty(),
        ]),
      );
      when(() => mockGroup.groupsPost(body: any(named: 'body'))).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), returnedGroup),
      );
      await groupNotifier.loadGroups();
      final result = await groupNotifier.createGroup(group);
      expect(result, true);
    });

    test('Should handle error when creating a group', () async {
      when(
        () => mockGroup.groupsPost(body: any(named: 'body')),
      ).thenThrow(Exception('Error'));
      final result = await groupNotifier.createGroup(group);
      expect(result, false);
    });

    test('Should update a group', () async {
      when(() => mockGroup.groupsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), [
          CoreGroupSimple.empty(),
          returnedGroup,
        ]),
      );
      when(
        () => mockGroup.groupsGroupIdPatch(
          groupId: any(named: 'groupId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), true),
      );
      await groupNotifier.loadGroups();
      expect(await groupNotifier.updateGroup(returnedGroup), true);
    });

    test('Should handle error when updating a group', () async {
      when(
        () => mockGroup.groupsGroupIdPatch(
          groupId: any(named: 'groupId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Error'));
      final result = await groupNotifier.updateGroup(returnedGroup);
      expect(result, false);
    });

    test('Should delete a group', () async {
      when(() => mockGroup.groupsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), [
          CoreGroupSimple.empty(),
          returnedGroup,
        ]),
      );
      when(
        () => mockGroup.groupsGroupIdDelete(groupId: any(named: 'groupId')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), true),
      );
      await groupNotifier.loadGroups();
      expect(await groupNotifier.deleteGroup(returnedGroup), true);
    });

    test('Should handle error when deleting a group', () async {
      when(
        () => mockGroup.groupsGroupIdDelete(groupId: any(named: 'groupId')),
      ).thenThrow(Exception('Error'));
      final result = await groupNotifier.deleteGroup(returnedGroup);
      expect(result, false);
    });

    test(
      'setGroup should modify an existing CoreGroupSimple object in the list',
      () {
        groupNotifier.state = AsyncValue.data([existingGroup]);
        groupNotifier.setGroup(modifiedGroup);
        expect(
          groupNotifier.state.when(
            data: (data) => data,
            error: (e, s) => [],
            loading: () => [],
          ),
          contains(modifiedGroup),
        );
        expect(
          groupNotifier.state.when(
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
