import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/auth/providers/is_connected_provider.dart';

void main() {
  group('IsConnectedProvider', () {
    setUp(() async {
      await dotenv.load();
    });

    test('IsConnectedProvider initial state is false', () {
      final provider = IsConnectedProvider();
      expect(provider.state, false);
    });

    test('isConnectedProvider returns the correct value', () {
      final container = ProviderContainer();
      final provider = container.read(isConnectedProvider.notifier);
      expect(container.read(isConnectedProvider), provider.state);
    });
  });
}
