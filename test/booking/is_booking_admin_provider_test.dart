import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/booking/providers/is_booking_admin_provider.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_provider.dart';

void main() {
  group('isBookingAdminProvider', () {
    test('should return true if user is a booking admin', () {
      final container = ProviderContainer(overrides: [
        userProvider.overrideWithValue(User.empty().copyWith(
          groups: [
            SimpleGroup.empty().copyWith(
                id: '53a669d6-84b1-4352-8d7c-421c1fbd9c6a',
                name: 'Booking Admin'),
            SimpleGroup.empty().copyWith(id: '123', name: 'Other Group'),
          ],
        )),
      ]);

      final result = container.read(isBookingAdminProvider);

      expect(result, true);
    });

    test('should return false if user is not a booking admin', () {
      final container = ProviderContainer(overrides: [
        userProvider.overrideWithValue(User.empty().copyWith(
          groups: [
            SimpleGroup.empty().copyWith(id: '123', name: 'Other Group'),
          ],
        )),
      ]);

      final result = container.read(isBookingAdminProvider);

      expect(result, false);
    });
  });
}
