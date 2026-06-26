import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class DeliveryListNotifier extends ListNotifierAPI<DeliveryReturn> {
  Openapi get deliveryListRepository => ref.read(repositoryProvider);

  @override
  AsyncValue<List<DeliveryReturn>> build() {
    loadDeliveriesList();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<DeliveryReturn>>> loadDeliveriesList() async {
    return await loadList(deliveryListRepository.amapDeliveriesGet);
  }

  Future<bool> addDelivery(DeliveryBase delivery) async {
    return await add(
      () => deliveryListRepository.amapDeliveriesPost(body: delivery),
      delivery,
    );
  }

  Future<bool> updateDelivery(DeliveryReturn delivery) async {
    return await update(
      () => deliveryListRepository.amapDeliveriesDeliveryIdPatch(
        deliveryId: delivery.id,
        body: DeliveryUpdate(deliveryDate: delivery.deliveryDate),
      ),
      (delivery) => delivery.id,
      delivery,
    );
  }

  Future<bool> openDelivery(DeliveryReturn delivery) async {
    return await update(
      () => deliveryListRepository.amapDeliveriesDeliveryIdOpenorderingPost(
        deliveryId: delivery.id,
      ),
      (delivery) => delivery.id,
      delivery.copyWith(status: DeliveryStatusType.orderable),
    );
  }

  Future<bool> lockDelivery(DeliveryReturn delivery) async {
    return await update(
      () => deliveryListRepository.amapDeliveriesDeliveryIdLockPost(
        deliveryId: delivery.id,
      ),
      (delivery) => delivery.id,
      delivery.copyWith(status: DeliveryStatusType.locked),
    );
  }

  Future<bool> deliverDelivery(DeliveryReturn delivery) async {
    return await update(
      () => deliveryListRepository.amapDeliveriesDeliveryIdDeliveredPost(
        deliveryId: delivery.id,
      ),
      (delivery) => delivery.id,
      delivery.copyWith(status: DeliveryStatusType.delivered),
    );
  }

  Future<bool> archiveDelivery(DeliveryReturn delivery) async {
    return await delete(
      () => deliveryListRepository.amapDeliveriesDeliveryIdArchivePost(
        deliveryId: delivery.id,
      ),
      (delivery) => delivery.id,
      delivery.id,
    );
  }

  Future<bool> deleteDelivery(DeliveryReturn delivery) async {
    return await delete(
      () => deliveryListRepository.amapDeliveriesDeliveryIdDelete(
        deliveryId: delivery.id,
      ),
      (delivery) => delivery.id,
      delivery.id,
    );
  }

  Future<List<DeliveryReturn>> copy() async {
    return state.maybeWhen(
      data: (deliveries) => List.from(deliveries),
      orElse: () => [],
    );
  }
}

final deliveryListProvider =
    NotifierProvider<DeliveryListNotifier, AsyncValue<List<DeliveryReturn>>>(
      DeliveryListNotifier.new,
    );

final deliveryList = Provider<List<DeliveryReturn>>((ref) {
  final state = ref.watch(deliveryListProvider);
  return state.maybeWhen(data: (deliveries) => deliveries, orElse: () => []);
});
