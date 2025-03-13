import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:myecl/admin/providers/group_provider.dart';
import 'package:myecl/generated/client_index.dart';
import 'package:myecl/generated/openapi.enums.swagger.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class MockGroupRepository extends Mock implements Openapi {}

void main() {
  group('GroupNotifier', () {
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
    test('Should load a group', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.groupsGroupIdGet(groupId: any(named: 'groupId')))
          .thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), group),
      );
      final GroupNotifier groupNotifier =
          GroupNotifier(groupRepository: mockGroup);
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
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.groupsGroupIdGet(groupId: any(named: 'groupId')))
          .thenThrow(Exception('Error'));
      final GroupNotifier groupNotifier =
          GroupNotifier(groupRepository: mockGroup);
      final result = await groupNotifier.loadGroup("1");
      expect(result, isA<AsyncError>());
    });

    test('Should add a member to the group', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.groupsMembershipPost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), group),
      );
      final GroupNotifier groupNotifier =
          GroupNotifier(groupRepository: mockGroup);
      groupNotifier.setGroup(group);
      final result = await groupNotifier.addMember(group, user);
      expect(result, true);
    });

    test('Should handle error when adding a member to the group', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.groupsMembershipPost(body: any(named: 'body')))
          .thenThrow(Exception('Error'));
      final GroupNotifier groupNotifier =
          GroupNotifier(groupRepository: mockGroup);
      groupNotifier.setGroup(group);
      final result = await groupNotifier.addMember(group, user);
      expect(result, false);
    });

    test('Should delete a member from the group', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.groupsMembershipDelete(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), true),
      );
      final GroupNotifier groupNotifier =
          GroupNotifier(groupRepository: mockGroup);
      groupNotifier.setGroup(group);
      final result = await groupNotifier.deleteMember(group, user);
      expect(result, true);
    });

    test('Should handle error when deleting a member from the group', () async {
      final mockGroup = MockGroupRepository();
      when(() => mockGroup.groupsMembershipDelete(body: any(named: 'body')))
          .thenThrow(Exception('Error'));
      final GroupNotifier groupNotifier =
          GroupNotifier(groupRepository: mockGroup);
      groupNotifier.setGroup(group);
      final result = await groupNotifier.deleteMember(group, user);
      expect(result, false);
    });

    test('setGroup should modify the state with the given group', () {
      final mockGroup = MockGroupRepository();
      final groupNotifier = GroupNotifier(groupRepository: mockGroup);
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
