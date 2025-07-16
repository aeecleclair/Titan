import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/super_admin/class/simple_group.dart';
import 'package:titan/event/providers/is_admin_provider.dart';
import 'package:titan/user/class/user.dart';
import 'package:titan/user/providers/user_provider.dart';

void main() {
  group('isEventSuperAdmin', () {
    test('should return true if user is event admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [
                SimpleGroup.empty().copyWith(
                  id: '53a669d6-84b1-4352-8d7c-421c1fbd9c6a',
                  name: 'SuperAdmin',
                ),
                SimpleGroup.empty().copyWith(id: '123', name: 'User'),
              ],
            ),
          ),
        ],
      );

      final isEventSuperAdminState = container.read(isEventSuperAdminProvider);

      expect(isEventSuperAdminState, true);
    });

    test('should return false if user is not event admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [SimpleGroup.empty().copyWith(id: '123', name: 'User')],
            ),
          ),
        ],
      );

      final isEventSuperAdminState = container.read(isEventSuperAdminProvider);

      expect(isEventSuperAdminState, false);
    });
  });
}
