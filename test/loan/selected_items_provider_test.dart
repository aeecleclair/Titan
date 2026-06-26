import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/loan/providers/item_list_provider.dart';
import 'package:titan/loan/providers/selected_items_provider.dart';

void main() {
  group('SelectedListProvider', () {
    test('should initialize with false values', () {
      final items = [
        Item.empty().copyWith(id: '1'),
        Item.empty().copyWith(id: '2'),
        Item.empty().copyWith(id: '3'),
      ];
      final container = ProviderContainer(
        overrides: [
          itemListProvider.overrideWith(
            () => _StubItemListNotifier(AsyncValue.data(items)),
          ),
        ],
      );
      addTearDown(container.dispose);
      final provider = container.read(selectedListProvider.notifier);
      expect(provider.state, [0, 0, 0]);
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

class _StubItemListNotifier extends ItemListNotifier {
  _StubItemListNotifier(this._initial);

  final AsyncValue<List<Item>> _initial;

  @override
  AsyncValue<List<Item>> build() => _initial;
}
