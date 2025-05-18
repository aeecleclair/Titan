import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/cinema/providers/is_cinema_admin.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/user/providers/user_provider.dart';

void main() {
  group('isCinemaAdmin', () {
    test('should return true if user is a cinema admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            EmptyModels.empty<CoreUser>().copyWith(
              groups: [
                EmptyModels.empty<CoreGroupSimple>().copyWith(
                  id: 'ce5f36e6-5377-489f-9696-de70e2477300',
                  name: 'Cinema Admin',
                ),
              ],
            ),
          ),
        ],
      );

      final isCinemaAdminState = container.read(isCinemaAdminProvider);

      expect(isCinemaAdminState, true);
    });

    test('should return false if user is not a cinema admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            EmptyModels.empty<CoreUser>().copyWith(
              groups: [
                EmptyModels.empty<CoreGroupSimple>()
                    .copyWith(id: '123', name: 'Group 1'),
                EmptyModels.empty<CoreGroupSimple>()
                    .copyWith(id: '456', name: 'Group 2'),
              ],
            ),
          ),
        ],
      );

      final isCinemaAdminState = container.read(isCinemaAdminProvider);

      expect(isCinemaAdminState, false);
    });
  });
}
