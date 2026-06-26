import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/vote/providers/show_graph_provider.dart';

void main() {
  group('ShowGraphNotifier', () {
    test('initial state should be false', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final showGraphNotifier = container.read(showGraphProvider.notifier);
      expect(showGraphNotifier.state, false);
    });

    test('toggle should change the state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final showGraphNotifier = container.read(showGraphProvider.notifier);
      showGraphNotifier.toggle(true);
      expect(showGraphNotifier.state, true);
      showGraphNotifier.toggle(false);
      expect(showGraphNotifier.state, false);
    });

    test('should update the state when using provider', () {
      final container = ProviderContainer();
      expect(container.read(showGraphProvider), false);
      container.read(showGraphProvider.notifier).toggle(true);
      expect(container.read(showGraphProvider), true);
    });
  });
}
