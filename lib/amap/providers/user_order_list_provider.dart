import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/repositories/amap_user_repository.dart';
import 'package:myecl/amap/repositories/order_list_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserOrderListNotifier extends ListNotifier<Order> {
  final OrderListRepository _orderListRepository = OrderListRepository();
  final AmapUserRepository _userRepository = AmapUserRepository();
  UserOrderListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _orderListRepository.setToken(token);
    _userRepository.setToken(token);
  }

  Future<AsyncValue<List<Order>>> loadOrderList(String userId) async {
    return await loadList(() async => _userRepository.getOrderList(userId));
  }

  Future<AsyncValue<List<Order>>> loadDeliveryOrderList(
      String deliveryId) async {
    return await loadList(
        () async => _orderListRepository.getDeliveryOrderList(deliveryId));
  }

  Future<bool> addOrder(Order order) async {
    return await add(
        (o) async => _orderListRepository.createOrder(o),
        order);
  }

  Future<bool> updateOrder(
      Order order) async {
    return await update(
        (o) async =>
            _orderListRepository.updateOrder(order),
        (orders, order) =>
            orders..[orders.indexWhere((o) => o.id == order.id)] = order,
        order);
  }

  Future<bool> deleteOrder(Order order) async {
    return await delete(
        (id) async => _orderListRepository.deleteOrder(order.id),
        (orders, order) => orders..removeWhere((i) => i.id == order.id),
        order.id,
        order);
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
        state = AsyncValue.error(error, stackTrace);
      },
      loading: () {
        state = const AsyncValue.error(
            "Cannot update product while loading", StackTrace.empty);
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
        state = AsyncValue.error(error, stackTrace);
      },
      loading: () {
        state = const AsyncValue.error(
            "Cannot toggle expanded while loading", StackTrace.empty);
      },
    );
  }

  Future<bool> setProducts(int indexOrder, List<Product> newListProduct,
      String deliveryId, String userId) async {
    return state.when(
      data: (orders) async {
        try {
          var newOrder = orders[indexOrder].copyWith(products: newListProduct);
          await _orderListRepository.updateOrder(newOrder);
          orders[indexOrder] = newOrder;
          state = AsyncValue.data(orders);
          return true;
        } catch (e) {
          state = AsyncValue.data(orders);
          return false;
        }
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          state = AsyncValue.error(error, stackTrace);
          return false;
        }
      },
      loading: () {
        state = const AsyncValue.error(
            "Cannot update product while loading", StackTrace.empty);
        return false;
      },
    );
  }

  Future<double> getPrice(int indexOrder) async {
    double price = 0;
    try {
      state.when(
        data: (orders) async {
          price = orders[indexOrder].products.fold(0, (previousValue, element) {
            return previousValue + element.price * element.quantity;
          });
        },
        error: (error, stackTrace) {
          state = AsyncValue.error(error, stackTrace);
        },
        loading: () {
          state = const AsyncValue.error(
              "Cannot get price while loading", StackTrace.empty);
        },
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.empty);
    }
    return price;
  }

  Future<AsyncValue<List<Order>>> copy() async {
    return state.when(
      data: (orders) async {
        return AsyncValue.data(orders.sublist(0));
      },
      error: (error, stackTrace) {
        return AsyncValue.error(error, stackTrace);
      },
      loading: () {
        return const AsyncValue.loading();
      },
    );
  }
}

final userOrderListProvider =
    StateNotifierProvider<UserOrderListNotifier, AsyncValue<List<Order>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  UserOrderListNotifier userOrderListNotifier =
      UserOrderListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    final userId = ref.watch(idProvider);
    userId.whenData(
        (value) async => await userOrderListNotifier.loadOrderList(value));
  });
  return userOrderListNotifier;
});
