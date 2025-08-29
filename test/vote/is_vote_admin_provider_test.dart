import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/user/class/user.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:titan/vote/providers/is_vote_admin_provider.dart';

void main() {
  group('isVoteAdmin', () {
    test('should return true if user is a vote admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [
                SimpleGroup.empty().copyWith(
                  id: "2ca57402-605b-4389-a471-f2fea7b27db5",
                ),
              ],
            ),
          ),
        ],
      );

      final isVoteAdminState = container.read(isVoteAdminProvider);

      expect(isVoteAdminState, true);
    });

    test('should return false if user is not a vote admin', () {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            User.empty().copyWith(
              groups: [
                SimpleGroup.empty().copyWith(
                  id: '12345678-1234-1234-1234-123456789012',
                ),
              ],
            ),
          ),
        ],
      );

      final isVoteAdminState = container.read(isVoteAdminProvider);

      expect(isVoteAdminState, false);
    });
  });
}
