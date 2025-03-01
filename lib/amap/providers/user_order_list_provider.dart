import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/amap/adapters/order.dart';

class UserOrderListNotifier extends ListNotifierAPI<OrderReturn> {
  final Openapi userOrderListRepository;
  UserOrderListNotifier({
    required this.userOrderListRepository,
  }) : super(const AsyncValue.loading());

  Future<AsyncValue<List<OrderReturn>>> loadOrderList(String userId) async {
    return await loadList(
      () async =>
          userOrderListRepository.amapUsersUserIdOrdersGet(userId: userId),
    );
  }

  Future<AsyncValue<List<OrderReturn>>> loadDeliveryOrderList(
    String deliveryId,
  ) async {
    return await loadList(
      () async => userOrderListRepository.amapDeliveriesDeliveryIdOrdersGet(
        deliveryId: deliveryId,
      ),
    );
  }

  Future<bool> addOrder(OrderBase order) async {
    return await add(
      () => userOrderListRepository.amapOrdersPost(body: order),
      order,
    );
  }

  Future<bool> updateOrder(OrderReturn order) async {
    return await update(
      () => userOrderListRepository.amapOrdersOrderIdPatch(
        orderId: order.orderId,
        body: order.toOrderEdit(),
      ),
      (order) => order.orderId,
      order,
    );
  }

  Future<bool> deleteOrder(OrderReturn order) async {
    return await delete(
      () => userOrderListRepository.amapOrdersOrderIdDelete(
          orderId: order.orderId),
      (orders) => orders..removeWhere((i) => i.orderId == order.orderId),
    );
  }

  void setProductQuantity(
    int indexOrder,
    AppModulesAmapSchemasAmapProductComplete product,
    int newQuantity,
  ) async {
    state.when(
      data: (orders) async {
        final productDetailsIndex = orders[indexOrder]
            .productsdetail
            .map((p) => p.product.id)
            .toList()
            .indexOf(product.id);
        orders[indexOrder] = orders[indexOrder].copyWith(
          productsdetail: orders[indexOrder].productsdetail
            ..replaceRange(
              productDetailsIndex,
              1,
              [
                orders[indexOrder]
                    .productsdetail[productDetailsIndex]
                    .copyWith(quantity: newQuantity)
              ],
            ),
        );
        state = AsyncValue.data(orders);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
      loading: () {
        state = const AsyncValue.error(
          "Cannot update product while loading",
          StackTrace.empty,
        );
      },
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
          var newOrder = orders[indexOrder]
              .copyWith(productsdetail: newListProductQuantity);
          await userOrderListRepository.amapOrdersOrderIdPatch(
              orderId: newOrder.orderId,
              body: OrderEdit(
                productsIds: newListProductQuantity.map((p) => p.product.id),
                collectionSlot: newOrder.collectionSlot,
                productsQuantity: newListProductQuantity.map((p) => p.quantity),
              ));
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
          price = orders[indexOrder].productsdetail.fold(0,
              (previousValue, element) {
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
    StateNotifierProvider<UserOrderListNotifier, AsyncValue<List<OrderReturn>>>(
        (ref) {
  final userOrderListRepository = ref.watch(repositoryProvider);
  UserOrderListNotifier userOrderListNotifier = UserOrderListNotifier(
    userOrderListRepository: userOrderListRepository,
  );
  tokenExpireWrapperAuth(ref, () async {
    final userId = ref.watch(idProvider);
    userId.whenData(
      (value) async => await userOrderListNotifier.loadOrderList(value),
    );
  });
  return userOrderListNotifier;
});
