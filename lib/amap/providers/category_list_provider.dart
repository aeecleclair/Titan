import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';

final categoryListProvider = Provider<List<String>>((ref) {
  final productList = ref.watch(productListProvider);
  return productList.when(
    data: (productList) => productList.map((e) => e.category).toSet().toList(),
    error: (error, stackTrace) => [],
    loading: () => [],
  );
});
