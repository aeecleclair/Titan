import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/super_admin/class/permissions.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/super_admin/providers/permissions_list_provider.dart';
import 'package:titan/event/providers/is_admin_provider.dart';
import 'package:titan/event/tools/constants.dart';
import 'package:titan/user/class/user.dart';
import 'package:titan/user/providers/user_provider.dart';

void main() {
  group('isEventAdmin', () {
    test('should return true if user is event admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [
                SimpleGroup.empty().copyWith(
                  id: "b0357687-2211-410a-9e2a-144519eeaafa",
                  name: 'admin_calendar',
                ),
                SimpleGroup.empty().copyWith(id: '123', name: 'User'),
              ],
            ),
          ),
          mappedPermissionsProvider.overrideWithValue({
            EventPermissionConstants.manageEvents: CorePermission(
              permissionName: EventPermissionConstants.manageEvents,
              authorizedGroupIds: ['b0357687-2211-410a-9e2a-144519eeaafa'],
              authorizedAccountTypes: [],
            ),
          }),
        ],
      );

      final isEventAdminState = container.read(isEventAdminProvider);

      expect(isEventAdminState, true);
    });

    test('should return false if user is not event admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [SimpleGroup.empty().copyWith(id: '123', name: 'User')],
            ),
          ),
          mappedPermissionsProvider.overrideWithValue({
            EventPermissionConstants.manageEvents: CorePermission(
              permissionName: EventPermissionConstants.manageEvents,
              authorizedGroupIds: ['70db65ee-d533-4f6b-9ffa-a4d70a17b7ef'],
              authorizedAccountTypes: [],
            ),
          }),
        ],
      );

      final isEventAdminState = container.read(isEventAdminProvider);

      expect(isEventAdminState, false);
    });
  });
}
