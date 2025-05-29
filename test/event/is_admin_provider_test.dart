import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/event/providers/is_admin_provider.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_provider.dart';

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
        ],
      );

      final isEventAdminState = container.read(isEventAdminProvider);

      expect(isEventAdminState, false);
    });
  });
}
