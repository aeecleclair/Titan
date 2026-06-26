import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/event/providers/is_admin_provider.dart';
import 'package:titan/generated/openapi.enums.swagger.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/user/providers/user_provider.dart';

void main() {
  group('isEventAdminProvider', () {
    final noGroupUser = CoreUser(
      id: '1',
      name: 'name',
      firstname: 'firstname',
      nickname: null,
      email: 'email',
      accountType: AccountType.$external,
      groups: [],
      birthday: DateTime.now(),
      createdOn: DateTime.now(),
      floor: '',
      phone: '',
      promo: null,
      schoolId: '',
    );

    final eventAdmin = noGroupUser.copyWith(
      groups: [
        CoreGroupSimple(
          id: 'b0357687-2211-410a-9e2a-144519eeaafa',
          name: 'event_admin_group',
        ),
      ],
    );

    final notEventAdmin = noGroupUser.copyWith(
      groups: [
        CoreGroupSimple(id: 'some-other-id', name: 'not_event_admin_group'),
      ],
    );

    test('Should return true if user is an event admin', () {
      final container = ProviderContainer(
        overrides: [userProvider.overrideWithValue(eventAdmin)],
      );

      final isAdmin = container.read(isEventAdminProvider);
      expect(isAdmin, true);
    });

    test('Should return false if user is not an event admin', () {
      final container = ProviderContainer(
        overrides: [userProvider.overrideWithValue(notEventAdmin)],
      );

      final isAdmin = container.read(isEventAdminProvider);
      expect(isAdmin, false);
    });

    test('Should return false if user has no groups', () {
      final container = ProviderContainer(
        overrides: [userProvider.overrideWithValue(noGroupUser)],
      );

      final isAdmin = container.read(isEventAdminProvider);
      expect(isAdmin, false);
    });

    test('Should return false if user is null', () {
      final container = ProviderContainer(
        overrides: [userProvider.overrideWithValue(CoreUser.empty())],
      );

      final isAdmin = container.read(isEventAdminProvider);
      expect(isAdmin, false);
    });
  });
}
