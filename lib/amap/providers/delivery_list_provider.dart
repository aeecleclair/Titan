import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/repositories/delivery_list_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class DeliveryListNotifier extends ListNotifier<Delivery> {
  final DeliveryListRepository _deliveriesListRepository =
      DeliveryListRepository();
  DeliveryListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _deliveriesListRepository.setToken(token);
  }

  Future<AsyncValue<List<Delivery>>> loadDeliveriesList() async {
    return await loadList(_deliveriesListRepository.getDeliveryList);
  }

  Future<bool> addDelivery(Delivery delivery) async {
    return await add(_deliveriesListRepository.createDelivery, delivery);
  }

  Future<bool> updateDelivery(Delivery delivery) async {
    return await update(
        _deliveriesListRepository.updateDelivery,
        (deliveries, delivery) => deliveries
          ..[deliveries.indexWhere((d) => d.id == delivery.id)] = delivery,
        delivery);
  }

  Future<bool> deleteDelivery(Delivery delivery) async {
    return await delete(
        _deliveriesListRepository.deleteDelivery,
        (deliveries, delivery) =>
            deliveries..removeWhere((i) => i.id == delivery.id),
        delivery.id,
        delivery);
  }

  void toggleExpanded(String deliveryId) {
    state.when(
      data: (deliveries) {
        var index = deliveries.indexWhere((p) => p.id == deliveryId);
        deliveries[index] =
            deliveries[index].copyWith(expanded: !deliveries[index].expanded);
        state = AsyncValue.data(deliveries);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
      },
      loading: () {
        state = const AsyncValue.error("Cannot toggle expanded while loading");
      },
    );
  }
}

final deliveryListProvider =
    StateNotifierProvider<DeliveryListNotifier, AsyncValue<List<Delivery>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  DeliveryListNotifier orderListNotifier = DeliveryListNotifier(token: token);
  orderListNotifier.loadDeliveriesList();
  return orderListNotifier;
});

final deliveryList = Provider<List<Delivery>>((ref) {
  final deliveryProvider = ref.watch(deliveryListProvider);
  return deliveryProvider.when(data: (orders) {
    return orders;
  }, error: (error, stackTrace) {
    return [];
  }, loading: () {
    return [];
  });
});
