import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/permissions.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/permissions_list_provider.dart';
import 'package:titan/user/class/user.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:titan/vote/providers/is_vote_admin_provider.dart';
import 'package:titan/vote/tools/constants.dart';

void main() {
  group('isVoteAdmin', () {
    test('should return true if user is a vote admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [
                SimpleGroup.empty().copyWith(
                  id: '6c6d7e88-fdb8-4e42-b2b5-3d3cfd12e7d6',
                ),
              ],
            ),
          ),
          mappedPermissionsProvider.overrideWithValue({
            VotePermissionConstants.manageVotes: CorePermission(
              permissionName: VotePermissionConstants.manageVotes,
              authorizedGroupIds: ['6c6d7e88-fdb8-4e42-b2b5-3d3cfd12e7d6'],
              authorizedAccountTypes: [],
            ),
          }),
        ],
      );

      final isVoteAdminState = container.read(isVoteAdminProvider);

      expect(isVoteAdminState, true);
    });

    test('should return false if user is not a vote admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [
                SimpleGroup.empty().copyWith(
                  id: '12345678-1234-1234-1234-123456789012',
                ),
              ],
            ),
          ),
          mappedPermissionsProvider.overrideWithValue({
            VotePermissionConstants.manageVotes: CorePermission(
              permissionName: VotePermissionConstants.manageVotes,
              authorizedGroupIds: ['6c6d7e88-fdb8-4e42-b2b5-3d3cfd12e7d6'],
              authorizedAccountTypes: [],
            ),
          }),
        ],
      );

      final isVoteAdminState = container.read(isVoteAdminProvider);

      expect(isVoteAdminState, false);
    });
  });
}
