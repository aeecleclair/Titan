import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:titan/admin/providers/group_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class MockGroupRepository extends Mock implements Openapi {}

void main() {
  group('GroupNotifier', () {
    late MockGroupRepository mockGroup;
    late ProviderContainer container;
    late GroupNotifier groupNotifier;
    final group = CoreGroup(
      id: "1",
      name: "name",
      description: "description",
      members: [],
    );
    final user = CoreUserSimple(
      id: "1",
      name: "name",
      firstname: "firstname",
      accountType: AccountType.$external,
      schoolId: "1",
    );

    setUp(() async {
      mockGroup = MockGroupRepository();
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockGroup)],
      );
      groupNotifier = container.read(groupProvider.notifier);
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test('Should load a group', () async {
      when(
        () => mockGroup.groupsGroupIdGet(groupId: any(named: 'groupId')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), group),
      );
      final result = await groupNotifier.loadGroup("1");
      expect(result, isA<AsyncData<CoreGroup>>());
      expect(
        result.when(
          data: (data) => data,
          error: (e, s) => null,
          loading: () => null,
        ),
        group,
      );
    });

    test('Should handle error when loading a group', () async {
      when(
        () => mockGroup.groupsGroupIdGet(groupId: any(named: 'groupId')),
      ).thenThrow(Exception('Error'));
      final result = await groupNotifier.loadGroup("1");
      expect(result, isA<AsyncError>());
    });

    test('Should add a member to the group', () async {
      when(
        () => mockGroup.groupsMembershipPost(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), group),
      );
      groupNotifier.setGroup(group);
      final result = await groupNotifier.addMember(group, user);
      expect(result, true);
    });

    test('Should handle error when adding a member to the group', () async {
      when(
        () => mockGroup.groupsMembershipPost(body: any(named: 'body')),
      ).thenThrow(Exception('Error'));
      groupNotifier.setGroup(group);
      final result = await groupNotifier.addMember(group, user);
      expect(result, false);
    });

    test('Should delete a member from the group', () async {
      when(
        () => mockGroup.groupsMembershipDelete(body: any(named: 'body')),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), true),
      );
      groupNotifier.setGroup(group);
      final result = await groupNotifier.deleteMember(group, user);
      expect(result, true);
    });

    test('Should handle error when deleting a member from the group', () async {
      when(
        () => mockGroup.groupsMembershipDelete(body: any(named: 'body')),
      ).thenThrow(Exception('Error'));
      groupNotifier.setGroup(group);
      final result = await groupNotifier.deleteMember(group, user);
      expect(result, false);
    });

    test('setGroup should modify the state with the given group', () {
      groupNotifier.setGroup(group);
      expect(
        groupNotifier.state.when(
          data: (data) => data,
          error: (e, s) => null,
          loading: () => null,
        ),
        group,
      );
    });
  });
}
