import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/vote/providers/is_vote_admin_provider.dart';

void main() {
  group('isVoteAdmin', () {
    test('should return true if user is a vote admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [
                SimpleGroup.empty()
                    .copyWith(id: '6c6d7e88-fdb8-4e42-b2b5-3d3cfd12e7d6'),
              ],
            ),
          ),
        ],
      );

      final isVoteAdminState = container.read(isVoteAdmin);

      expect(isVoteAdminState, true);
    });

    test('should return false if user is not a vote admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [
                SimpleGroup.empty()
                    .copyWith(id: '12345678-1234-1234-1234-123456789012'),
              ],
            ),
          ),
        ],
      );

      final isVoteAdminState = container.read(isVoteAdmin);

      expect(isVoteAdminState, false);
    });
  });
}
