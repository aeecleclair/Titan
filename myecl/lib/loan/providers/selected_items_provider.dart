import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/item.dart';

final selectedListProvider =
    StateNotifierProvider<SelectedListProvider, List<bool>>((ref) {
  final productsList = AsyncValue.data([
    Item(
      name: "Item 1",
      caution: 20,
      expiration: DateTime.now().add(Duration(days: 1)),
      groupId: '',
      id: '1',
    ),
    Item(
      name: "Item 2",
      caution: 20,
      expiration: DateTime.now().add(Duration(days: 1)),
      groupId: '',
      id: '1',
    ),
    Item(
      name: "Item 3",
      caution: 20,
      expiration: DateTime.now().add(Duration(days: 1)),
      groupId: '',
      id: '2',
    ),
    Item(
      name: "Item 4",
      caution: 20,
      expiration: DateTime.now().add(Duration(days: 1)),
      groupId: '',
      id: '3',
    ),
  ]);
  final products = [];
  productsList.when(
    data: (list) => products.addAll(list),
    error: (e, s) {},
    loading: () {},
  );
  return SelectedListProvider(products);
});

class SelectedListProvider extends StateNotifier<List<bool>> {
  SelectedListProvider(List<dynamic> p) : super(List.generate(p.length, (index) => false));

  void toggle(int i) {
    var copy = state.toList();
    copy[i] = !copy[i];
    state = copy;
  }


  void clear() {
    state = List.generate(state.length, (index) => false);
  }
}
