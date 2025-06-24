import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/providers/delivery_id_provider.dart';

void main() {
  group('DeliveryIdProvider', () {
    test('initial state is empty string', () {
      final container = ProviderContainer();
      final state = container.read(deliveryIdProvider);

      expect(state, '');
    });

    test('setId sets the state to the given value', () {
      final container = ProviderContainer();
      final providerNotifier = container.read(deliveryIdProvider.notifier);

      providerNotifier.setId('123');
      final state = container.read(deliveryIdProvider);

      expect(state, '123');
    });
  });
}
