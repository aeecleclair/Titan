import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/user/class/user.dart';
import 'package:titan/user/providers/user_provider.dart';

void main() {
  group('isAdminProvider', () {
    test('returns true if user is admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [
                SimpleGroup.empty().copyWith(
                  id: '0a25cb76-4b63-4fd3-b939-da6d9feabf28',
                  name: 'Admin',
                ),
                SimpleGroup.empty().copyWith(id: '123', name: 'User'),
              ],
            ),
          ),
        ],
      );

      final isAdmin = container.read(isAdminProvider);

      expect(isAdmin, true);
    });

    test('returns false if user is not admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [SimpleGroup.empty().copyWith(id: '123', name: 'User')],
            ),
          ),
        ],
      );

      final isAdmin = container.read(isAdminProvider);

      expect(isAdmin, false);
    });
  });
}
