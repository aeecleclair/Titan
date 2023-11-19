import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/amap/providers/is_amap_admin_provider.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_provider.dart';

void main() {
  group('isAmapAdmin', () {
    test('should return true if user is an Amap admin', () {
      final container = ProviderContainer(overrides: [
        userProvider.overrideWithValue(User.empty().copyWith(
          groups: [
            SimpleGroup.empty().copyWith(
                id: '70db65ee-d533-4f6b-9ffa-a4d70a17b7ef', name: 'Amap Admin'),
            SimpleGroup.empty().copyWith(id: '123', name: 'Some Group'),
          ],
        )),
      ]);

      final isAmapAdminState = container.read(isAmapAdmin);

      expect(isAmapAdminState, true);
    });

    test('should return false if user is not an Amap admin', () {
      final container = ProviderContainer(overrides: [
        userProvider.overrideWithValue(User.empty().copyWith(
          groups: [
            SimpleGroup.empty().copyWith(id: '123', name: 'Some Group'),
          ],
        )),
      ]);

      final isAmapAdminState = container.read(isAmapAdmin);

      expect(isAmapAdminState, false);
    });
  });
}
