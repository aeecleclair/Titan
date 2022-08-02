import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/repositories/delivery_list_repository.dart';

class DeliveryListNotifier extends StateNotifier<AsyncValue<List<Delivery>>> {
  final DeliveryListRepository _deliveriesListRepository =
      DeliveryListRepository();
  DeliveryListNotifier() : super(const AsyncValue.loading());

  Future<AsyncValue<List<Delivery>>> loadDeliveriesList() async {
    try {
      final deliveriesList = await _deliveriesListRepository.getDeliveryList();
      state = AsyncValue.data(deliveriesList);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<bool> addDelivery(Delivery delivery) async {
    return state.when(
      data: (deliveries) async {
        try {
          Delivery newDelivery = await _deliveriesListRepository.createDelivery(
            delivery,
          );
          deliveries.add(newDelivery);
          state = AsyncValue.data(deliveries);
          return true;
        } catch (e) {
          state = AsyncValue.data(deliveries);
          return false;
        }
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot add delivery while loading");
        return false;
      },
    );
  }

  Future<bool> updateDelivery(Delivery delivery) async {
    return state.when(
      data: (deliveries) async {
        try {
          await _deliveriesListRepository.updateDelivery(delivery);
          var index = deliveries.indexWhere((p) => p.id == delivery.id);
          deliveries[index] = delivery;
          state = AsyncValue.data(deliveries);
          return true;
        } catch (e) {
          state = AsyncValue.data(deliveries);
          return false;
        }
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot update delivery while loading");
        return false;
      },
    );
  }

  Future<bool> deleteDelivery(String deliveryId) async {
    return state.when(
      data: (deliveries) async {
        try {
          await _deliveriesListRepository.deleteDelivery(deliveryId);
          deliveries.removeWhere((e) => e.id == deliveryId);
          state = AsyncValue.data(deliveries);
          return true;
        } catch (e) {
          state = AsyncValue.data(deliveries);
          return false;
        }
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot delete delivery while loading");
        return false;
      },
    );
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
  DeliveryListNotifier _orderListNotifier = DeliveryListNotifier();
  _orderListNotifier.loadDeliveriesList();
  return _orderListNotifier;
});

final deliveryList = Provider((ref) {
  final deliveryProvider = ref.watch(deliveryListProvider);
  return deliveryProvider.when(data: (orders) {
    return orders;
  }, error: (error, stackTrace) {
    return [];
  }, loading: () {
    return [];
  });
});
