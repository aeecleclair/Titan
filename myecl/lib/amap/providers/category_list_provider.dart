import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';

class CategoryListNotifier extends StateNotifier<List<String>> {
  CategoryListNotifier([List<String>? cmds]) : super(cmds ?? []);

  void ajouterCategorie(String c) {
    state = [...state, c]..sort();
  }

  void removeCategorie(String c) {
    state = state.sublist(0)..remove(c);
  }
}

final categoryListProvider =
    StateNotifierProvider<CategoryListNotifier, List<String>>((ref) {
  final products = ref.watch(productListProvider.notifier).lastLoadedProducts;

  return CategoryListNotifier([
    ...{...products.map((e) => e.categorie)}
  ]..sort());
});
