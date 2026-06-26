import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/loan/providers/borrower_provider.dart';

void main() {
  group('BorrowerNotifier', () {
    test('setBorrower should update state', () {
      final container = ProviderContainer();
      final borrower = CoreUserSimple.empty().copyWith(
        id: '2',
        name: 'Jane Doe',
      );
      final notifier = container.read(borrowerProvider.notifier);
      notifier.setBorrower(borrower);

      expect(container.read(borrowerProvider), borrower);
    });
  });
}
