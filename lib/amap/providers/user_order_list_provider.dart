import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserOrderListNotifier extends ListNotifier2<OrderReturn> {
  final Openapi repository;
  UserOrderListNotifier({required this.repository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<OrderReturn>>> loadOrderList(String userId) async {
    return await loadList(
        () async => repository.amapUsersUserIdOrdersGet(userId: userId));
  }

  Future<AsyncValue<List<OrderReturn>>> loadDeliveryOrderList(
      String deliveryId) async {
    return await loadList(() async =>
        repository.amapDeliveriesDeliveryIdOrdersGet(deliveryId: deliveryId));
  }

  Future<bool> addOrder(OrderReturn order) async {
    return await add(
        (order) async => repository.amapOrdersPost(
                body: OrderBase(
              userId: order.user.id,
              deliveryId: order.deliveryId,
              productsIds:
                  order.productsdetail.map((e) => e.product.id).toList(),
              collectionSlot: order.collectionSlot,
              productsQuantity:
                  order.productsdetail.map((e) => e.quantity).toList(),
            )),
        order);
  }

  Future<bool> updateOrder(OrderReturn order) async {
    return await update(
        (order) async => repository.amapOrdersOrderIdPatch(
            orderId: order.orderId,
            body: OrderEdit(
              collectionSlot: order.collectionSlot,
              productsQuantity:
                  order.productsdetail.map((e) => e.quantity).toList(),
            )),
        (orders, order) => orders
          ..[orders.indexWhere((o) => o.orderId == order.orderId)] = order,
        order);
  }

  Future<bool> deleteOrder(OrderReturn order) async {
    return await delete(
        (orderId) async => repository.amapOrdersOrderIdDelete(orderId: orderId),
        (orders, order) =>
            orders..removeWhere((i) => i.orderId == order.orderId),
        order.orderId,
        order);
  }

  void setProductQuantity(
      int indexOrder, ProductQuantity product, int newQuantity) async {
    state.when(
      data: (orders) async {
        orders[indexOrder] = orders[indexOrder].copyWith(
            productsdetail: orders[indexOrder].productsdetail
              ..replaceRange(orders[indexOrder].productsdetail.indexOf(product), 1,
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

  Future<double> getPrice(int indexOrder) async {
    double price = 0;
    try {
      state.when(
        data: (orders) async {
          price = orders[indexOrder].productsdetail.fold(0, (previousValue, element) {
            return previousValue + element.product.price * element.quantity;
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

  Future<AsyncValue<List<OrderReturn>>> copy() async {
    return state.whenData((orders) => orders.sublist(0));
  }
}

final userOrderListProvider =
    StateNotifierProvider<UserOrderListNotifier, AsyncValue<List<OrderReturn>>>(
        (ref) {
  final repository = ref.watch(repositoryProvider);
  UserOrderListNotifier userOrderListNotifier =
      UserOrderListNotifier(repository: repository);
  tokenExpireWrapperAuth(ref, () async {
    final userId = ref.watch(idProvider);
    userId.whenData(
        (value) async => await userOrderListNotifier.loadOrderList(value));
  });
  return userOrderListNotifier;
});
