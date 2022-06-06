import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/repositories/amap_user_repository.dart';
import 'package:myecl/amap/repositories/order_list_repository.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';

class OrderListNotifier extends StateNotifier<AsyncValue<List<Order>>> {
  final OrderListRepository _repository = OrderListRepository();
  final AmapUserRepository _userRepository = AmapUserRepository();
  late String deliveryId;
  late String userId;
  OrderListNotifier() : super(const AsyncValue.loading());

  void setId(String id) {
    deliveryId = id;
  }

  void setUserId(String userId) {
    this.userId = userId;
  }

  void loadOrderList(String userId) async {
    try {
      final orders = await _userRepository.getOrderList(userId);
      state = AsyncValue.data(orders);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  void addOrder(Order order) async {
    try {
      state.when(
        data: (orders) async {
          if (await _repository.createOrder(deliveryId, order, userId)) {
            orders.add(order);
            state = AsyncValue.data(orders);
          } else {
            state = AsyncValue.error(Exception("Failed to add order"));
          }
        },
        error: (error, s) {
          state = AsyncValue.error(error);
        },
        loading: () {
          state = const AsyncValue.error("Cannot add order while loading");
        },
      );
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  void updateOrder(String orderId, Order order) async {
    try {
      state.when(
        data: (orders) async {
          if (await _repository.updateOrder(deliveryId, order)) {
            orders.replaceRange(
                orders.indexOf(
                    orders.firstWhere((element) => element.id == orderId)),
                1,
                [order]);
            state = AsyncValue.data(orders);
          } else {
            state = AsyncValue.error(Exception("Failed to update order"));
          }
        },
        error: (error, stackTrace) {
          state = AsyncValue.error(error);
        },
        loading: () {
          state = const AsyncValue.error("Cannot update order while loading");
        },
      );
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  void deleteOrder(int indexOrder) async {
    try {
      state.when(
        data: (orders) async {
          if (await _repository.deleteOrder(
              deliveryId, orders[indexOrder].id)) {
            orders.removeAt(indexOrder);
            state = AsyncValue.data(orders);
          } else {
            state = AsyncValue.error(Exception("Failed to delete order"));
          }
        },
        error: (error, stackTrace) {
          state = AsyncValue.error(error);
        },
        loading: () {
          state = const AsyncValue.error("Cannot delete order while loading");
        },
      );
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  void addProduct(int indexOrder, Product product) async {
    try {
      state.when(
        data: (orders) async {
          var newOrder = orders[indexOrder]
              .copyWith(products: orders[indexOrder].products..add(product));
          if (await _repository.updateOrder(deliveryId, newOrder)) {
            orders[indexOrder] = newOrder;
            state = AsyncValue.data(orders);
          } else {
            state = AsyncValue.error(Exception("Failed to add product"));
          }
        },
        error: (error, stackTrace) {
          state = AsyncValue.error(error);
        },
        loading: () {
          state = const AsyncValue.error("Cannot add product while loading");
        },
      );
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<AsyncValue<List<Order>>> deleteProduct(
      int indexOrder, Product product) async {
    try {
      state.when(
        data: (orders) async {
          var newOrder = orders[indexOrder]
              .copyWith(products: orders[indexOrder].products..remove(product));
          if (await _repository.updateOrder(deliveryId, newOrder)) {
            orders[indexOrder] = newOrder;
            state = AsyncValue.data(orders);
          } else {
            state = AsyncValue.error(Exception("Failed to delete product"));
          }
        },
        error: (error, stackTrace) {
          state = AsyncValue.error(error);
        },
        loading: () {
          state = const AsyncValue.error("Cannot delete product while loading");
        },
      );
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<List<Order>>> updateProduct(
      int indexOrder, Product product) async {
    try {
      state.when(
        data: (orders) async {
          var newOrder = orders[indexOrder].copyWith(
              products: orders[indexOrder].products
                ..replaceRange(orders[indexOrder].products.indexOf(product), 1,
                    [product]));
          if (await _repository.updateOrder(deliveryId, newOrder)) {
            orders[indexOrder] = newOrder;
            state = AsyncValue.data(orders);
          } else {
            state = AsyncValue.error(Exception("Failed to update product"));
          }
        },
        error: (error, stackTrace) {
          state = AsyncValue.error(error);
        },
        loading: () {
          state = const AsyncValue.error("Cannot update product while loading");
        },
      );
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  void setProductQuantity(
      int indexOrder, Product product, int newQuantity) async {
    state.when(
      data: (orders) async {
        orders[indexOrder] = orders[indexOrder].copyWith(
            products: orders[indexOrder].products
              ..replaceRange(orders[indexOrder].products.indexOf(product), 1,
                  [product.copyWith(quantity: newQuantity)]));
        state = AsyncValue.data(orders);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
      },
      loading: () {
        state = const AsyncValue.error("Cannot update product while loading");
      },
    );
  }

  void toggleExpanded(int indexOrder) async {
    state.when(
      data: (orders) async {
        orders[indexOrder] =
            orders[indexOrder].copyWith(expanded: !orders[indexOrder].expanded);
        state = AsyncValue.data(orders);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
      },
      loading: () {
        state = const AsyncValue.error("Cannot toggle expanded while loading");
      },
    );
  }

  void setProducts(int indexOrder, List<Product> newListProduct) async {
    state.when(
      data: (orders) async {
        orders[indexOrder] = orders[indexOrder].copyWith(products: newListProduct);
        state = AsyncValue.data(orders);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
      },
      loading: () {
        state = const AsyncValue.error("Cannot update products while loading");
      },
    );
  }

  Future<double> getprice(int indexOrder) async {
    double _price = 0;
    try {
      state.when(
        data: (orders) async {
          _price =
              orders[indexOrder].products.fold(0, (previousValue, element) {
            return previousValue + element.price * element.quantity;
          });
        },
        error: (error, stackTrace) {
          state = AsyncValue.error(error);
        },
        loading: () {
          state = const AsyncValue.error("Cannot get price while loading");
        },
      );
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return _price;
  }
}

final orderListProvider = StateNotifierProvider.family<OrderListNotifier,
    AsyncValue<List<Order>>, String>((ref, deliveryId) {
  final userId = ref.read(idProvider);
  OrderListNotifier _orderListNotifier = OrderListNotifier();
  _orderListNotifier.setId(deliveryId);
  _orderListNotifier.setUserId(userId);
  _orderListNotifier.loadOrderList(userId);
  return _orderListNotifier;
});

final orderList = Provider((ref) {
  final deliveryId = ref.watch(deliveryIdProvider);
  final notifier = ref.watch(orderListProvider(deliveryId));
  return notifier.when(data: (orders) {
    return orders;
  }, error: (error, stackTrace) {
    return [];
  }, loading: () {
    return [];
  });
});
