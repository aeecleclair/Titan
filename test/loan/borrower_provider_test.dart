import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/borrower_provider.dart';
import 'package:myecl/user/class/list_users.dart';

void main() {
  group('BorrowerNotifier', () {
    test('setBorrower should update state', () {
      final container = ProviderContainer();
      final borrower = SimpleUser.empty().copyWith(id: '2', name: 'Jane Doe');
      final notifier = container.read(borrowerProvider.notifier);
      notifier.setBorrower(borrower);

      expect(container.read(borrowerProvider), borrower);
    });
  });
}
