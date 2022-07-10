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
          if (await _deliveriesListRepository.createDelivery(delivery)) {
            deliveries.add(delivery);
            state = AsyncValue.data(deliveries);
            return true;
          } else {
            state = AsyncValue.error(Exception("Failed to add delivery"));
            return false;
          }
        } catch (e) {
          state = AsyncValue.error(e);
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

  Future<bool> updateDelivery(String deliveryId, Delivery delivery) async {
    return state.when(
      data: (deliveries) async {
        try {
          if (await _deliveriesListRepository.updateDelivery(
              deliveryId, delivery)) {
            var index = deliveries.indexWhere((p) => p.id == deliveryId);
            deliveries.remove(deliveries.firstWhere((e) => e.id == deliveryId));
            deliveries.insert(index, delivery);
            state = AsyncValue.data(deliveries);
            return true;
          } else {
            state = AsyncValue.error(Exception("Failed to update delivery"));
            return false;
          }
        } catch (e) {
          state = AsyncValue.error(e);
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
          if (await _deliveriesListRepository.deleteDelivery(deliveryId)) {
            deliveries.removeWhere((e) => e.id == deliveryId);
            state = AsyncValue.data(deliveries);
            return true;
          } else {
            state = AsyncValue.error(Exception("Failed to delete delivery"));
            return false;
          }
        } catch (e) {
          state = AsyncValue.error(e);
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
