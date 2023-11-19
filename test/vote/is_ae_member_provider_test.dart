import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/vote/providers/is_ae_member_provider.dart';

void main() {
  group('isAEMemberProvider', () {
    test('should return true if user is a member of AE group', () {
      final container = ProviderContainer(overrides: [
        userProvider.overrideWith(
          (ref) => User.empty().copyWith(groups: [
            SimpleGroup.empty()
                .copyWith(id: '45649735-866a-49df-b04b-a13c74fd5886')
          ]),
        ),
      ]);

      final result = container.read(isAEMemberProvider);

      expect(result, true);
    });

    test('should return false if user is not a member of AE group', () {
      final container = ProviderContainer(overrides: [
        userProvider.overrideWith(
          (ref) => User.empty().copyWith(groups: [
            SimpleGroup.empty()
                .copyWith(id: '12345678-1234-5678-1234-567812345678')
          ]),
        ),
      ]);

      final result = container.read(isAEMemberProvider);

      expect(result, false);
    });
  });
}
