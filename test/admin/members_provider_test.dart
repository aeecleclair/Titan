import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/super_admin/providers/members_provider.dart';

void main() {
  group('MembersNotifier', () {
    final user1 = CoreUserSimple.empty().copyWith(id: '1', name: 'John');
    final user2 = CoreUserSimple.empty().copyWith(id: '2', name: 'Jane');
    test('Adding a user to the list', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final membersNotifier = container.read(membersProvider.notifier);
      membersNotifier.add(user1);
      expect(membersNotifier.state.length, 1);
      expect(membersNotifier.state[0], user1);
    });

    test('Removing a user from the list', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final membersNotifier = container.read(membersProvider.notifier);
      membersNotifier.add(user1);
      membersNotifier.add(user2);
      membersNotifier.remove(user1);
      expect(membersNotifier.state.length, 1);
      expect(membersNotifier.state[0], user2);
    });

    test('Removing a user that doesn\'t exist in the list', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final membersNotifier = container.read(membersProvider.notifier);
      membersNotifier.add(user1);
      membersNotifier.remove(user2);
      expect(membersNotifier.state.length, 1);
      expect(membersNotifier.state[0], user1);
    });
  });
}
