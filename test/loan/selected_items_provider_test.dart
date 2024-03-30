import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/loan/providers/item_quantities_provider.dart';

void main() {
  group('SelectedListProvider', () {
    test('should initialize with empty map', () {
      final notifier = ItemQuantitiesMapNotifier();
      expect(notifier.state, <String, int>{});
    });

    // test('should toggle value at index', () async {
    //   final provider = SelectedListProvider([1, 2, 3]);
    //   await provider.toggle(1);
    //   expect(provider.state, [false, true, false]);
    // });

    // test('should initialize with loan items selected', () {
    //   final products = [
    //     Item.empty().copyWith(id: '1', name: 'Product 1'),
    //     Item.empty().copyWith(id: '2', name: 'Product 2'),
    //     Item.empty().copyWith(id: '3', name: 'Product 3'),
    //   ];
    //   final loan = Loan.empty().copyWith(
    //     itemsQuantity: [
    //       ItemQuantity.empty().copyWith(id: '1', name: 'Product 1'),
    //       ItemQuantity.empty().copyWith(id: '3', name: 'Product 3'),
    //     ],
    //   );
    //   final provider = SelectedListProvider(products);
    //   provider.initWithLoan(products, loan);
    //   expect(provider.state, [true, false, true]);
    // });

    // test('should clear all selected values', () async {
    //   final provider = SelectedListProvider([1, 2, 3]);
    //   await provider.toggle(1);
    //   provider.clear();
    //   expect(provider.state, [false, false, false]);
    // });
  });
}
