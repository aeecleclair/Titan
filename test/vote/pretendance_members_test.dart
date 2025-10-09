import 'package:flutter_test/flutter_test.dart';
import 'package:titan/vote/class/members.dart';
import 'package:titan/vote/providers/contender_members.dart';

void main() {
  group('ContenderMembersProvider', () {
    test('addMember should add a member to the state', () async {
      final provider = ContenderMembersProvider();
      final member = Member.empty().copyWith(name: 'John Doe', id: '123');

      final result = await provider.addMember(member);

      expect(result, true);
      expect(provider.state.length, 1);
      expect(provider.state.first, member);
    });

    test('addMember should not add a member if already in the state', () async {
      final provider = ContenderMembersProvider();
      final member = Member.empty().copyWith(name: 'John Doe', id: '123');

      await provider.addMember(member);
      final result = await provider.addMember(member);

      expect(result, false);
      expect(provider.state.length, 1);
      expect(provider.state.first, member);
    });

    test('removeMember should remove a member from the state', () async {
      final provider = ContenderMembersProvider();
      final member = Member.empty().copyWith(name: 'John Doe', id: '123');

      await provider.addMember(member);
      provider.removeMember(member);

      expect(provider.state.length, 0);
    });

    test('clearMembers should clear the state', () async {
      final provider = ContenderMembersProvider();
      final member = Member.empty().copyWith(name: 'John Doe', id: '123');

      await provider.addMember(member);
      provider.clearMembers();

      expect(provider.state.length, 0);
    });

    test(
      'setMembers should set the state to the given list of members',
      () async {
        final provider = ContenderMembersProvider();
        final members = [
          Member.empty().copyWith(name: 'John Doe', id: '123'),
          Member.empty().copyWith(name: 'Jane Doe', id: '456'),
        ];

        provider.setMembers(members);

        expect(provider.state.length, 2);
        expect(provider.state, members);
      },
    );
  });
}
