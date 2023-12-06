import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';

final selectedListProvider =
    StateNotifierProvider<SelectedListProvider, List<bool>>((ref) {
  final productsList = ref.watch(productListProvider);
  final products = <ProductComplete>[];
  productsList.maybeWhen(
    data: (list) => products.addAll(list),
    orElse: () {},
  );
  return SelectedListProvider(products);
});

class SelectedListProvider extends StateNotifier<List<bool>> {
  SelectedListProvider(List<ProductComplete> p)
      : super(List.generate(p.length, (index) => true));

  void toggle(int i) {
    var copy = state.toList();
    copy[i] = !copy[i];
    state = copy;
  }

  void clear() {
    state = List.generate(state.length, (index) => true);
  }

  void rebuild(List<ProductComplete> p) {
    state = List.generate(p.length, (index) => true);
  }
}
