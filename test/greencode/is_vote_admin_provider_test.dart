import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/greencode/providers/is_greencode_admin_provider.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_provider.dart';

void main() {
  group('isGreenCodeAdmin', () {
    test('should return true if user is a greencode admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [
                SimpleGroup.empty()
                    .copyWith(id: 'e23d52eb-3fe4-4ce3-91f5-1f645647ef7d'),
              ],
            ),
          ),
        ],
      );

      final isGreenCodeAdminState = container.read(isGreenCodeAdminProvider);

      expect(isGreenCodeAdminState, true);
    });

    test('should return false if user is not a greencode admin', () {
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

      final isGreenCodeAdminState = container.read(isGreenCodeAdminProvider);

      expect(isGreenCodeAdminState, false);
    });
  });
}
