import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:uuid/uuid.dart';

var _uuid = const Uuid();

class OrderListNotifier extends StateNotifier<List<Order>> {
  OrderListNotifier([List<Order>? listCmd]) : super(listCmd ?? []);

  void addProduct(int i, Product p) {
    state[i].products.add(p.copy());
  }

  void removeProducts(int i, Product p) {
    state[i].products.removeWhere((element) => element.nom == p.nom);
  }

  void removeOrder(int i) {
    state = state.sublist(0)..removeAt(i);
  }

  void addOrder(DateTime date, List<Product> products) {
    state = [
      ...state,
      Order(
        id: _uuid.v4(),
        date: date,
        products: products,
      ),
    ];
  }

  void setProductQuantite(int i, Product p, int quantite) {
    List<Order> r = state.sublist(0);

    for (int j = 0; j < r[i].products.length; j++) {
      if (r[i].products[j].id == p.id) {
        r[i].products[j].quantite = quantite;
      }
    }

    state = r;
  }

  void toggleExpanded(String id) {
    state = [
      for (final p in state)
        if (p.id == id)
          Order(
              id: p.id,
              date: p.date,
              products: p.products,
              expanded: !p.expanded)
        else
          p,
    ];
  }

  void setProducts(String id, List<Product> products) {
    state = [
      for (final p in state)
        if (p.id == id)
          Order(
              id: p.id, date: p.date, products: products, expanded: p.expanded)
        else
          p,
    ];
  }

  double getPrix(int i) {
    return state[i]
        .products
        .map((e) => e.prix * e.quantite)
        .reduce((value, element) => value + element);
  }
}

final orderListProvider = StateNotifierProvider<OrderListNotifier, List<Order>>((ref) {
  return OrderListNotifier([]);
});
