import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/repositories/order_list_repository.dart';

class OrderListNotifier extends StateNotifier<AsyncValue<List<Order>>> {
  final OrderListRepository _repository = OrderListRepository();
  List<Order> lastLoadedOrders = [];
  OrderListNotifier() : super(const AsyncValue.loading());

  Future<AsyncValue<List<Order>>> loadOrderList() async {
    try {
      final orders = await _repository.getAllOrders();
      lastLoadedOrders = orders;
      state = AsyncValue.data(orders);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<List<Order>>> addOrder(Order order) async {
    try {
      if (await _repository.createOrder(order)) {
        lastLoadedOrders.add(order);
        state = AsyncValue.data(lastLoadedOrders);
      } else {
        state = AsyncValue.error(Exception("Failed to create order"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<List<Order>>> updateOrder(
      String orderId, Order order) async {
    try {
      if (await _repository.updateOrder(orderId, order)) {
        lastLoadedOrders.replaceRange(
            lastLoadedOrders.indexOf(lastLoadedOrders
                .firstWhere((element) => element.id == orderId)),
            1,
            [order]);
        state = AsyncValue.data(lastLoadedOrders);
      } else {
        state = AsyncValue.error(Exception("Failed to update order"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<List<Order>>> deleteOrder(int indexOrder) async {
    try {
      String orderId = lastLoadedOrders[indexOrder].id;
      if (await _repository.deleteOrder(orderId)) {
        lastLoadedOrders.removeWhere((element) => element.id == orderId);
        state = AsyncValue.data(lastLoadedOrders);
      } else {
        state = AsyncValue.error(Exception("Failed to delete order"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<List<Order>>> addProduct(
      int indexOrder, Product product) async {
    try {
      final order = lastLoadedOrders[indexOrder];
      order.products.add(product);
      if (await _repository.updateOrder(order.id, order)) {
        lastLoadedOrders.replaceRange(
            lastLoadedOrders.indexOf(lastLoadedOrders
                .firstWhere((element) => element.id == order.id)),
            1,
            [order]);
        state = AsyncValue.data(lastLoadedOrders);
      } else {
        state = AsyncValue.error(Exception("Failed to update order"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<List<Order>>> deleteProduct(
      int indexOrder, Product product) async {
    try {
      final order = lastLoadedOrders[indexOrder];
      order.products.remove(product);
      if (await _repository.updateOrder(order.id, order)) {
        lastLoadedOrders.replaceRange(
            lastLoadedOrders.indexOf(lastLoadedOrders
                .firstWhere((element) => element.id == order.id)),
            1,
            [order]);
        state = AsyncValue.data(lastLoadedOrders);
      } else {
        state = AsyncValue.error(Exception("Failed to update order"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<List<Order>>> updateProduct(
      int indexOrder, Product product) async {
    try {
      final order = lastLoadedOrders[indexOrder];
      order.products.replaceRange(
          order.products.indexOf(
              order.products.firstWhere((element) => element.id == product.id)),
          1,
          [product]);
      if (await _repository.updateOrder(order.id, order)) {
        lastLoadedOrders.replaceRange(
            lastLoadedOrders.indexOf(lastLoadedOrders
                .firstWhere((element) => element.id == order.id)),
            1,
            [order]);
        state = AsyncValue.data(lastLoadedOrders);
      } else {
        state = AsyncValue.error(Exception("Failed to update order"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<List<Order>>> setProductQuantity(
      int indexOrder, Product product, int newQuantity) async {
    return updateProduct(indexOrder, product.copy(quantity: newQuantity));
  }

  Future<AsyncValue<List<Order>>> toggleExpanded(int indexOrder) async {
    return updateOrder(
        lastLoadedOrders[indexOrder].id,
        lastLoadedOrders[indexOrder]
            .copy(expanded: !lastLoadedOrders[indexOrder].expanded));
  }

  Future<AsyncValue<List<Order>>> setProducts(
      int indexOrder, List<Product> newListProduct) async {
    return updateOrder(lastLoadedOrders[indexOrder].id,
        lastLoadedOrders[indexOrder].copy(products: newListProduct));
  }

  Future<double> getprice(int indexOrder) async {
    double _price = 0;
    try {
      final order = lastLoadedOrders[indexOrder];
      for (var product in order.products) {
        _price += product.price * product.quantity;
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return _price;
  }
}

final orderListProvider =
    StateNotifierProvider<OrderListNotifier, AsyncValue<List<Order>>>((ref) {
  OrderListNotifier _orderListNotifier = OrderListNotifier();
  _orderListNotifier.loadOrderList();
  return _orderListNotifier;
});
