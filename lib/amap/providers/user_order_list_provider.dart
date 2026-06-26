import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class UserOrderListNotifier extends ListNotifierAPI<OrderReturn> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<OrderReturn>> build() {
    final userId = ref.watch(idProvider);
    userId.whenData((value) async => await loadOrderList(value));
    return state;
  }

  Future<AsyncValue<List<OrderReturn>>> loadOrderList(String userId) async {
    return await loadList(
      () async => repository.amapUsersUserIdOrdersGet(userId: userId),
    );
  }

  Future<AsyncValue<List<OrderReturn>>> loadDeliveryOrderList(
    String deliveryId,
  ) async {
    return await loadList(
      () async =>
          repository.amapDeliveriesDeliveryIdOrdersGet(deliveryId: deliveryId),
    );
  }

  Future<bool> addOrder(OrderBase order) async {
    return await add(() => repository.amapOrdersPost(body: order), order);
  }

  Future<bool> updateOrder(OrderReturn order) async {
    return await update(
      () => repository.amapOrdersOrderIdPatch(
        orderId: order.orderId,
        body: OrderEdit(
          collectionSlot: order.collectionSlot,
          productsIds: order.productsdetail
              .map((product) => product.product.id)
              .toList(),
          productsQuantity: order.productsdetail
              .map((product) => product.quantity)
              .toList(),
        ),
      ),
      (order) => order.orderId,
      order,
    );
  }

  Future<bool> deleteOrder(OrderReturn order) async {
    return await delete(
      () => repository.amapOrdersOrderIdDelete(orderId: order.orderId),
      (order) => order.orderId,
      order.orderId,
    );
  }

  Future<bool> setProducts(
    int indexOrder,
    List<ProductQuantity> newListProductQuantity,
    String deliveryId,
    String userId,
  ) async {
    return state.when(
      data: (orders) async {
        try {
          var newOrder = orders[indexOrder].copyWith(
            productsdetail: newListProductQuantity,
          );
          await repository.amapOrdersOrderIdPatch(
            orderId: newOrder.orderId,
            body: OrderEdit(
              productsIds: newListProductQuantity
                  .map((p) => p.product.id)
                  .toList(),
              collectionSlot: newOrder.collectionSlot,
              productsQuantity: newListProductQuantity
                  .map((p) => p.quantity)
                  .toList(),
            ),
          );
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
          "Cannot update product while loading",
          StackTrace.empty,
        );
        return false;
      },
    );
  }

  Future<double> getPrice(int indexOrder) async {
    double price = 0;
    try {
      state.when(
        data: (orders) async {
          price = orders[indexOrder].productsdetail.fold(0, (
            previousValue,
            element,
          ) {
            return previousValue + element.product.price * element.quantity;
          });
        },
        error: (error, stackTrace) {
          state = AsyncValue.error(error, stackTrace);
        },
        loading: () {
          state = const AsyncValue.error(
            "Cannot get price while loading",
            StackTrace.empty,
          );
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
    NotifierProvider<UserOrderListNotifier, AsyncValue<List<OrderReturn>>>(
      UserOrderListNotifier.new,
    );
