import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/amap/providers/product_list_provider.dart';
import 'package:titan/amap/providers/selected_list_provider.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class FakeProductListNotifier extends ProductListNotifier {
  @override
  AsyncValue<List<AppModulesAmapSchemasAmapProductComplete>> build() {
    return AsyncValue.data([
      emptyProduct('1'),
      emptyProduct('2'),
      emptyProduct('3'),
    ]);
  }
}

AppModulesAmapSchemasAmapProductComplete emptyProduct(String id) =>
    AppModulesAmapSchemasAmapProductComplete(
      id: id,
      name: 'name',
      category: 'category',
      price: 0,
    );

void main() {
  group('SelectedListProvider', () {
    late ProviderContainer container;
    late SelectedListProvider provider;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          productListProvider.overrideWith(FakeProductListNotifier.new),
        ],
      );
      provider = container.read(selectedListProvider.notifier);
    });

    tearDown(() => container.dispose());

    test(
      'SelectedListProvider toggle should toggle the value at the given index',
      () {
        expect(provider.state, [true, true, true]);
        provider.toggle(1);
        expect(provider.state, [true, false, true]);
      },
    );

    test('SelectedListProvider clear should set all values to true', () {
      provider.toggle(1);
      expect(provider.state, [true, false, true]);
      provider.clear();
      expect(provider.state, [true, true, true]);
    });

    test(
      'SelectedListProvider rebuild should generate a new list of true values',
      () {
        provider.toggle(1);
        expect(provider.state, [true, false, true]);
        provider.rebuild([4, 5, 6]);
        expect(provider.state, [true, true, true]);
      },
    );
  });
}
