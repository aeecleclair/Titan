import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/vote/class/contender.dart';
import 'package:titan/vote/providers/contender_provider.dart';

void main() {
  group('ContenderNotifier', () {
    test('setId should update the state', () {
      final container = ProviderContainer();
      final notifier = container.read(contenderProvider.notifier);

      final contender = Contender.empty().copyWith(id: '123', name: 'John Doe');

      notifier.setId(contender);

      expect(container.read(contenderProvider).id, '123');
      expect(container.read(contenderProvider).name, 'John Doe');
    });
  });
}
