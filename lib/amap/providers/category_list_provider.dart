import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';

class CategoryListNotifier extends StateNotifier<List<String>> {
  CategoryListNotifier([List<String>? cmds]) : super(cmds ?? []);

  void ajoutercategory(String c) {
    state = [...state, c]..sort();
  }

  void removecategory(String c) {
    state = state.sublist(0)..remove(c);
  }
}

final categoryListProvider =
    StateNotifierProvider<CategoryListNotifier, List<String>>((ref) {
  final deliveryId = ref.watch(deliveryIdProvider);
  final products = ref.watch(deliveryProductListProvider(deliveryId));
  return products.when(
    data: (p) {
      return CategoryListNotifier(p.map((e) => e.category).toSet().toList());
    },
    error: (e, s) {
      return CategoryListNotifier([]);
    },
    loading: () {
      return CategoryListNotifier([]);
    },
  );
});
