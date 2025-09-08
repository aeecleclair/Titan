import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/providers/product_list_provider.dart';

final selectedListProvider =
    StateNotifierProvider<SelectedListProvider, List<bool>>((ref) {
      final productsList = ref.watch(productListProvider);
      final products = [];
      productsList.when(
        data: (list) => products.addAll(list),
        error: (e, s) {},
        loading: () {},
      );
      return SelectedListProvider(products);
    });

class SelectedListProvider extends StateNotifier<List<bool>> {
  SelectedListProvider(List<dynamic> p)
    : super(List.generate(p.length, (index) => true));

  void toggle(int i) {
    var copy = state.toList();
    copy[i] = !copy[i];
    state = copy;
  }

  void clear() {
    state = List.generate(state.length, (index) => true);
  }

  void rebuild(List<dynamic> p) {
    state = List.generate(p.length, (index) => true);
  }
}
