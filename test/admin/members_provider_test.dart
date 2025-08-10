import 'package:flutter_test/flutter_test.dart';
import 'package:titan/super_admin/providers/members_provider.dart';
import 'package:titan/user/class/simple_users.dart';

void main() {
  group('MembersNotifier', () {
    test('Adding a user to the list', () {
      final membersNotifier = MembersNotifier();
      final user = SimpleUser.empty().copyWith(id: '1', name: 'John');
      membersNotifier.add(user);
      expect(membersNotifier.state.length, 1);
      expect(membersNotifier.state[0], user);
    });

    test('Removing a user from the list', () {
      final membersNotifier = MembersNotifier();
      final user1 = SimpleUser.empty().copyWith(id: '1', name: 'John');
      final user2 = SimpleUser.empty().copyWith(id: '2', name: 'Jane');
      membersNotifier.add(user1);
      membersNotifier.add(user2);
      membersNotifier.remove(user1);
      expect(membersNotifier.state.length, 1);
      expect(membersNotifier.state[0], user2);
    });

    test('Removing a user that doesn\'t exist in the list', () {
      final membersNotifier = MembersNotifier();
      final user1 = SimpleUser.empty().copyWith(id: '1', name: 'John');
      final user2 = SimpleUser.empty().copyWith(id: '2', name: 'Jane');
      membersNotifier.add(user1);
      membersNotifier.remove(user2);
      expect(membersNotifier.state.length, 1);
      expect(membersNotifier.state[0], user1);
    });
  });
}
