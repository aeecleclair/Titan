import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/group_id_provider.dart';

void main() {
  group('GroupIdNotifier', () {
    test('initial state is empty string', () {
      final container = ProviderContainer();
      final groupId = container.read(groupIdProvider);

      expect(groupId, '');
    });

    test('setId updates state', () {
      final container = ProviderContainer();
      final groupIdNotifier = container.read(groupIdProvider.notifier);

      groupIdNotifier.setId('123');

      expect(groupIdNotifier.state, '123');
    });
  });
}
