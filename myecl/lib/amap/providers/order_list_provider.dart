import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/repositories/amap_user_repository.dart';
import 'package:myecl/amap/repositories/order_list_repository.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/list_provider.dart';

class OrderListNotifier extends ListProvider<Order> {
  final OrderListRepository _orderListRepository = OrderListRepository();
  final AmapUserRepository _userRepository = AmapUserRepository();
  late String deliveryId;
  late String userId;
  OrderListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _orderListRepository.setToken(token);
    _userRepository.setToken(token);
  }

  void setId(String id) {
    deliveryId = id;
  }

  void setUserId(String userId) {
    this.userId = userId;
  }

  Future<AsyncValue<List<Order>>> loadOrderList() async {
    return await loadList(() async {
      return await _userRepository.getOrderList(userId);
    });
  }

  Future<bool> addOrder(Order order) async {
    return await add((o) async {
      return await _orderListRepository.createOrder(deliveryId, o, userId);
    }, order);
  }

  Future<bool> updateOrder(Order order) async {
    return await update((o) async {
      return await _orderListRepository.updateOrder(deliveryId, order, userId);
    }, (orders, order) {
      final ordersId = orders.map((o) => o.id).toList();
      final index = ordersId.indexOf(order.id);
      orders[index] = order;
      return orders;
    }, order);
  }

  Future<bool> deleteOrder(Order order) async {
    return await delete((id) async {
      return await _orderListRepository.deleteOrder(order.deliveryId, id);
    }, order.id, order);
  }

  Future<bool> addProduct(int indexOrder, Product product) async {
    return state.when(
      data: (orders) async {
        try {
          var newOrder = orders[indexOrder]
              .copyWith(products: orders[indexOrder].products..add(product));
          await _orderListRepository.updateOrder(deliveryId, newOrder, userId);
          orders[indexOrder] = newOrder;
          state = AsyncValue.data(orders);
          return true;
        } catch (e) {
          state = AsyncValue.data(orders);
          return false;
        }
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          state = AsyncValue.error(error);
          return false;
        }
      },
      loading: () {
        state = const AsyncValue.error("Cannot add product while loading");
        return false;
      },
    );
  }

  Future<bool> deleteProduct(int indexOrder, Product product) async {
    return state.when(
      data: (orders) async {
        try {
          var newOrder = orders[indexOrder]
              .copyWith(products: orders[indexOrder].products..remove(product));
          await _orderListRepository.updateOrder(deliveryId, newOrder, userId);
          orders[indexOrder] = newOrder;
          state = AsyncValue.data(orders);
          return true;
        } catch (e) {
          state = AsyncValue.data(orders);
          return false;
        }
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          state = AsyncValue.error(error);
          return false;
        }
      },
      loading: () {
        state = const AsyncValue.error("Cannot delete product while loading");
        return false;
      },
    );
  }

  Future<bool> updateProduct(int indexOrder, Product product) async {
    return state.when(
      data: (orders) async {
        try {
          var newOrder = orders[indexOrder].copyWith(
              products: orders[indexOrder].products
                ..replaceRange(orders[indexOrder].products.indexOf(product), 1,
                    [product]));
          await _orderListRepository.updateOrder(deliveryId, newOrder, userId);
          orders[indexOrder] = newOrder;
          state = AsyncValue.data(orders);
          return true;
        } catch (e) {
          state = AsyncValue.data(orders);
          return false;
        }
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          state = AsyncValue.error(error);
          return false;
        }
      },
      loading: () {
        state = const AsyncValue.error("Cannot update product while loading");
        return false;
      },
    );
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

  Future<bool> setProducts(int indexOrder, List<Product> newListProduct) async {
    return state.when(
      data: (orders) async {
        try {
          var newOrder = orders[indexOrder].copyWith(products: newListProduct);
          await _orderListRepository.updateOrder(deliveryId, newOrder, userId);
          orders[indexOrder] = newOrder;
          state = AsyncValue.data(orders);
          return true;
        } catch (e) {
          state = AsyncValue.data(orders);
          return false;
        }
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          state = AsyncValue.error(error);
          return false;
        }
      },
      loading: () {
        state = const AsyncValue.error("Cannot update product while loading");
        return false;
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
  final userId = ref.watch(idProvider);
  final token = ref.watch(tokenProvider);
  OrderListNotifier _orderListNotifier = OrderListNotifier(token: token);
  _orderListNotifier.setId(deliveryId);
  _orderListNotifier.setUserId(userId);
  _orderListNotifier.loadOrderList();
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
