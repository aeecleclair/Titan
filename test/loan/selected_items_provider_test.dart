import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';

void main() {
  group('SelectedListProvider', () {
    test('should initialize with false values', () {
      final provider = SelectedListProvider([1, 2, 3]);
      expect(provider.state, [0, 0, 0]);
    });

    // test('should toggle value at index', () async {
    //   final provider = SelectedListProvider([1, 2, 3]);
    //   await provider.toggle(1);
    //   expect(provider.state, [false, true, false]);
    // });

    // test('should initialize with loan items selected', () {
    //   final products = [
    //     Item.fromJson({}).copyWith(id: '1', name: 'Product 1'),
    //     Item.fromJson({}).copyWith(id: '2', name: 'Product 2'),
    //     Item.fromJson({}).copyWith(id: '3', name: 'Product 3'),
    //   ];
    //   final loan = Loan.fromJson({}).copyWith(
    //     itemsQuantity: [
    //       ItemQuantity.fromJson({}).copyWith(id: '1', name: 'Product 1'),
    //       ItemQuantity.fromJson({}).copyWith(id: '3', name: 'Product 3'),
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
