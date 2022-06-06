import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/repositories/delivery_list_repository.dart';

class DeliveryListNotifier extends StateNotifier<AsyncValue<List<Delivery>>> {
  final DeliveryListRepository _deliveriesListRepository =
      DeliveryListRepository();
  DeliveryListNotifier() : super(const AsyncValue.loading());

  void loadDeliveriesList() {
    state = const AsyncValue.loading();
    _deliveriesListRepository.getDeliveryList().then((deliveries) {
      state = AsyncValue.data(deliveries);
    }).catchError((e) {
      state = AsyncValue.error(e);
    });
  }

  void addDelivery(Delivery delivery) async {
    try {
      state.when(
        data: (deliveries) async {
          if (await _deliveriesListRepository.createDelivery(delivery)) {
            deliveries.add(delivery);
            state = AsyncValue.data(deliveries);
          } else {
            state = AsyncValue.error(Exception("Failed to add delivery"));
          }
        },
        error: (error, stackTrace) {
          state = AsyncValue.error(error);
        },
        loading: () {
          state = const AsyncValue.error("Cannot add delivery while loading");
        },
      );
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  void updateDelivery(String deliveryId, Delivery delivery) async {
    try {
      state.when(
        data: (deliveries) async {
          if (await _deliveriesListRepository.updateDelivery(
              deliveryId, delivery)) {
            deliveries.replaceRange(
                deliveries.indexOf(deliveries
                    .firstWhere((element) => element.id == deliveryId)),
                1,
                [delivery]);
            state = AsyncValue.data(deliveries);
          } else {
            state = AsyncValue.error(Exception("Failed to update delivery"));
          }
        },
        error: (error, stackTrace) {
          state = AsyncValue.error(error);
        },
        loading: () {
          state =
              const AsyncValue.error("Cannot update delivery while loading");
        },
      );
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  void deleteDelivery(String deliveryId) async {
    try {
      state.when(
        data: (deliveries) async {
          if (await _deliveriesListRepository.deleteDelivery(deliveryId)) {
            deliveries.remove(
                deliveries.firstWhere((element) => element.id == deliveryId));
            state = AsyncValue.data(deliveries);
          } else {
            state = AsyncValue.error(Exception("Failed to delete delivery"));
          }
        },
        error: (error, stackTrace) {
          state = AsyncValue.error(error);
        },
        loading: () {
          state =
              const AsyncValue.error("Cannot delete delivery while loading");
        },
      );
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }
}


final deliveryListProvider = StateNotifierProvider<DeliveryListNotifier,
    AsyncValue<List<Delivery>>>((ref) {
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
