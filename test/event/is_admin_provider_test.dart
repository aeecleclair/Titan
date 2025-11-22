import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/permissions.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/permissions_provider.dart';
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
                  id: '53a669d6-84b1-4352-8d7c-421c1fbd9c6a',
                  name: 'Admin',
                ),
                SimpleGroup.empty().copyWith(id: '123', name: 'User'),
              ],
            ),
          ),
          permissionsProvider.overrideWithValue({
            EventPermissionConstants.manageEvents: Permission(
              permissionName: EventPermissionConstants.manageEvents,
              authorizedGroups: ['53a669d6-84b1-4352-8d7c-421c1fbd9c6a'],
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
          permissionsProvider.overrideWithValue({
            EventPermissionConstants.manageEvents: Permission(
              permissionName: EventPermissionConstants.manageEvents,
              authorizedGroups: ['70db65ee-d533-4f6b-9ffa-a4d70a17b7ef'],
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
