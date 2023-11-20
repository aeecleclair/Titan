import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:myecl/user/repositories/user_list_repository.dart';

class MockUserListRepository extends Mock implements UserListRepository {}

void main() {
  group('UserListNotifier', () {
    late UserListRepository userListRepository;
    late UserListNotifier userListNotifier;

    setUp(() {
      userListRepository = MockUserListRepository();
      userListNotifier =
          UserListNotifier(userListRepository: userListRepository);
    });

    test('initial state is loading', () {
      expect(userListNotifier.state, isA<AsyncValue<List<SimpleUser>>>());
    });

    test('filterUsers returns list of users', () async {
      const query = 'test';
      final includeGroup = [
        SimpleGroup.empty().copyWith(id: '1', name: 'Group 1')
      ];
      final excludeGroup = [
        SimpleGroup.empty().copyWith(id: '2', name: 'Group 2')
      ];
      final users = [SimpleUser.empty().copyWith(id: '1', name: 'User 1')];

      when(() => userListRepository.searchUser(query,
              includeId: includeGroup.map((e) => e.id).toList(),
              excludeId: excludeGroup.map((e) => e.id).toList()))
          .thenAnswer((_) async => users);

      final result = await userListNotifier.filterUsers(query,
          includeGroup: includeGroup, excludeGroup: excludeGroup);

      expect(
          result.when(
              data: (data) => data, loading: () => [], error: (_, __) => []),
          users);
    });

    test('clear sets state to empty list', () async {
      await userListNotifier.clear();

      expect(userListNotifier.state, isA<AsyncValue<List<SimpleUser>>>());
    });
  });
}
