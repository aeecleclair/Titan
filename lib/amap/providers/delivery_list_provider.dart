import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class DeliveryListNotifier extends ListNotifier2<DeliveryReturn> {
  final Openapi deliveriesListRepository;
  DeliveryListNotifier({required this.deliveriesListRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<DeliveryReturn>>> loadDeliveriesList() async {
    return await loadList(deliveriesListRepository.amapDeliveriesGet);
  }

  Future<bool> addDelivery(DeliveryBase delivery) async {
    return await add(
      () => deliveriesListRepository.amapDeliveriesPost(body: delivery),
      delivery,
    );
  }

  Future<bool> updateDelivery(DeliveryReturn delivery) async {
    return await update(
      () => deliveriesListRepository.amapDeliveriesDeliveryIdPatch(
        deliveryId: delivery.id,
        body: DeliveryUpdate(deliveryDate: delivery.deliveryDate),
      ),
      (deliveries, delivery) => deliveries
        ..[deliveries.indexWhere((d) => d.id == delivery.id)] = delivery,
      delivery,
    );
  }

  Future<bool> openDelivery(DeliveryReturn delivery) async {
    return await update(
      () => deliveriesListRepository.amapDeliveriesDeliveryIdOpenorderingPost(
        deliveryId: delivery.id,
      ),
      (deliveries, delivery) => deliveries
        ..[deliveries.indexWhere((d) => d.id == delivery.id)] =
            delivery.copyWith(status: DeliveryStatusType.orderable),
      delivery,
    );
  }

  Future<bool> lockDelivery(DeliveryReturn delivery) async {
    return await update(
      () => deliveriesListRepository.amapDeliveriesDeliveryIdLockPost(
        deliveryId: delivery.id,
      ),
      (deliveries, delivery) => deliveries
        ..[deliveries.indexWhere((d) => d.id == delivery.id)] =
            delivery.copyWith(status: DeliveryStatusType.locked),
      delivery,
    );
  }

  Future<bool> deliverDelivery(DeliveryReturn delivery) async {
    return await update(
      () => deliveriesListRepository.amapDeliveriesDeliveryIdDeliveredPost(
        deliveryId: delivery.id,
      ),
      (deliveries, delivery) => deliveries
        ..[deliveries.indexWhere((d) => d.id == delivery.id)] =
            delivery.copyWith(status: DeliveryStatusType.delivered),
      delivery,
    );
  }

  Future<bool> archiveDelivery(DeliveryReturn delivery) async {
    return await delete(
      () => deliveriesListRepository.amapDeliveriesDeliveryIdArchivePost(
        deliveryId: delivery.id,
      ),
      (deliveries, delivery) =>
          deliveries..removeWhere((i) => i.id == delivery.id),
      delivery,
    );
  }

  Future<bool> deleteDelivery(DeliveryReturn delivery) async {
    return await delete(
      () => deliveriesListRepository.amapDeliveriesDeliveryIdDelete(
        deliveryId: delivery.id,
      ),
      (deliveries, delivery) =>
          deliveries..removeWhere((i) => i.id == delivery.id),
      delivery,
    );
  }

  Future<List<DeliveryReturn>> copy() async {
    return state.maybeWhen(
      data: (deliveries) => List.from(deliveries),
      orElse: () => [],
    );
  }
}

final deliveryListProvider = StateNotifierProvider<DeliveryListNotifier,
    AsyncValue<List<DeliveryReturn>>>((ref) {
  final deliveryListRepository = ref.read(repositoryProvider);
  DeliveryListNotifier orderListNotifier =
      DeliveryListNotifier(deliveriesListRepository: deliveryListRepository);
  tokenExpireWrapperAuth(ref, () async {
    await orderListNotifier.loadDeliveriesList();
  });
  return orderListNotifier;
});

final deliveryList = Provider<List<DeliveryReturn>>((ref) {
  final state = ref.watch(deliveryListProvider);
  return state.maybeWhen(
    data: (deliveries) => deliveries,
    orElse: () => [],
  );
});
