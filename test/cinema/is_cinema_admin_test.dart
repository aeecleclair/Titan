import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/permissions.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/permissions_provider.dart';
import 'package:titan/cinema/providers/is_cinema_admin.dart';
import 'package:titan/cinema/tools/constants.dart';
import 'package:titan/user/class/user.dart';
import 'package:titan/user/providers/user_provider.dart';

void main() {
  group('isCinemaAdmin', () {
    test('should return true if user is a cinema admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [
                SimpleGroup.empty().copyWith(
                  id: 'ce5f36e6-5377-489f-9696-de70e2477300',
                  name: 'Cinema Admin',
                ),
              ],
            ),
          ),
          permissionsProvider.overrideWithValue({
            CinemaPermissionConstants.manageSessions: Permission(
              permissionName: CinemaPermissionConstants.manageSessions,
              authorizedGroups: ['ce5f36e6-5377-489f-9696-de70e2477300'],
              authorizedAccountTypes: [],
            ),
          }),
        ],
      );

      final isCinemaAdminState = container.read(isCinemaAdminProvider);

      expect(isCinemaAdminState, true);
    });

    test('should return false if user is not a cinema admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [
                SimpleGroup.empty().copyWith(id: '123', name: 'Group 1'),
                SimpleGroup.empty().copyWith(id: '456', name: 'Group 2'),
              ],
            ),
          ),
          permissionsProvider.overrideWithValue({
            CinemaPermissionConstants.manageSessions: Permission(
              permissionName: CinemaPermissionConstants.manageSessions,
              authorizedGroups: ['ce5f36e6-5377-489f-9696-de70e2477300'],
              authorizedAccountTypes: [],
            ),
          }),
        ],
      );

      final isCinemaAdminState = container.read(isCinemaAdminProvider);

      expect(isCinemaAdminState, false);
    });
  });
}
