import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/borrower_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

void main() {
  group('BorrowerNotifier', () {
    test('setBorrower should update state', () {
      final container = ProviderContainer();
      final borrower = EmptyModels.empty<CoreUserSimple>()
          .copyWith(id: '2', name: 'Jane Doe');
      final notifier = container.read(borrowerProvider.notifier);
      notifier.setBorrower(borrower);

      expect(container.read(borrowerProvider), borrower);
    });
  });
}
