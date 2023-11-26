import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/booking/providers/is_admin_provider.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_provider.dart';

void main() {
  group('isBookingAdminProvider', () {
    test('should return true if user is a booking admin', () {
      final container = ProviderContainer(overrides: [
        userProvider2.overrideWithValue(User.empty().copyWith(
          groups: [
            CoreUserSimple.empty().copyWith(
                id: '0a25cb76-4b63-4fd3-b939-da6d9feabf28',
                name: 'Booking Admin'),
            CoreUserSimple.empty().copyWith(id: '123', name: 'Other Group'),
          ],
        )),
      ]);

      final result = container.read(isAdminProvider);

      expect(result, true);
    });

    test('should return false if user is not a booking admin', () {
      final container = ProviderContainer(overrides: [
        userProvider2.overrideWithValue(User.empty().copyWith(
          groups: [
            CoreUserSimple.empty().copyWith(id: '123', name: 'Other Group'),
          ],
        )),
      ]);

      final result = container.read(isAdminProvider);

      expect(result, false);
    });
  });
}
