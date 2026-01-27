import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/ticketing/class/category.dart';

class CategoryNotifier extends StateNotifier<Category> {
  CategoryNotifier() : super(Category.empty());

  void setCategory(Category i) {
    state = i;
  }
}

final categoryProvider = StateNotifierProvider<CategoryNotifier, Category>((
  ref,
) {
  return CategoryNotifier();
});
