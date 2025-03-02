import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/vote/providers/list_members.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

void main() {
  group('ListMembersProvider', () {
    late ListMembersProvider provider;
    final member = ListMemberComplete.fromJson({}).copyWith(userId: '1');
    final member2 = ListMemberComplete.fromJson({}).copyWith(userId: '2');

    setUp(() {
      provider = ListMembersProvider();
    });

    test('addMember should add a member to the state', () async {
      final result = await provider.addMember(member);

      expect(result, true);
      expect(provider.state.length, 1);
      expect(provider.state.first, member);
    });

    test('addMember should not add a member if already in the state', () async {
      await provider.addMember(member);
      final result = await provider.addMember(member);

      expect(result, false);
      expect(provider.state.length, 1);
      expect(provider.state.first, member);
    });

    test('removeMember should remove a member from the state', () async {
      await provider.addMember(member);
      provider.removeMember(member);

      expect(provider.state.length, 0);
    });

    test('clearMembers should clear the state', () async {
      await provider.addMember(member);
      provider.clearMembers();

      expect(provider.state.length, 0);
    });

    test('setMembers should set the state to the given list of members',
        () async {
      final members = [member, member2];

      provider.setMembers(members);

      expect(provider.state.length, 2);
      expect(provider.state, members);
    });
  });
}
