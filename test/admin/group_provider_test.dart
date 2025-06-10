import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/admin/class/group.dart';
import 'package:titan/admin/providers/group_provider.dart';
import 'package:titan/admin/repositories/group_repository.dart';
import 'package:titan/user/class/simple_users.dart';

class MockGroupRepository extends Mock implements GroupRepository {}

void main() {
  group('GroupNotifier', () {
    test('loadGroup', () async {
      final groupRepository = MockGroupRepository();
      final groupNotifier = GroupNotifier(groupRepository: groupRepository);
      final group = Group.empty().copyWith(id: '1', name: 'Test Group');
      when(() => groupRepository.getGroup('1')).thenAnswer((_) async => group);

      final result = await groupNotifier.loadGroup('1');

      expect(
        result.when(
          data: (data) => data,
          loading: () => null,
          error: (e, s) => null,
        ),
        group,
      );
    });

    test('addMember', () async {
      final groupRepository = MockGroupRepository();
      final groupNotifier = GroupNotifier(groupRepository: groupRepository);
      final group = Group.empty().copyWith(id: '1', name: 'Test Group');
      final user = SimpleUser.empty().copyWith(id: '2', name: 'Test User');
      groupNotifier.state = AsyncData(group);
      when(
        () => groupRepository.addMember(group, user),
      ).thenAnswer((_) async => true);

      final result = await groupNotifier.addMember(group, user);

      expect(result, true);
    });

    test('deleteMember', () async {
      final groupRepository = MockGroupRepository();
      final groupNotifier = GroupNotifier(groupRepository: groupRepository);
      final group = Group.empty().copyWith(id: '1', name: 'Test Group');
      final user = SimpleUser.empty().copyWith(id: '2', name: 'Test User');
      groupNotifier.state = AsyncData(group);
      when(
        () => groupRepository.deleteMember(group, user),
      ).thenAnswer((_) async => true);

      final result = await groupNotifier.deleteMember(group, user);

      expect(result, true);
    });

    test('setGroup', () async {
      final groupRepository = MockGroupRepository();
      final groupNotifier = GroupNotifier(groupRepository: groupRepository);
      final group = Group.empty().copyWith(id: '1', name: 'Test Group');
      groupNotifier.state = AsyncData(group);

      groupNotifier.setGroup(group);

      expect(
        groupNotifier.state.when(
          data: (data) => data,
          loading: () => null,
          error: (e, s) => null,
        ),
        group,
      );
    });
  });
}
