import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/amap/adapters/delivery.dart';

class DeliveryListNotifier extends ListNotifierAPI<DeliveryReturn> {
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
        body: delivery.toDeliveryUpdate(),
      ),
      (delivery) => delivery.id,
      delivery,
    );
  }

  Future<bool> openDelivery(DeliveryReturn delivery) async {
    return await update(
      () => deliveriesListRepository.amapDeliveriesDeliveryIdOpenorderingPost(
        deliveryId: delivery.id,
      ),
      (delivery) => delivery.id,
      delivery.copyWith(status: DeliveryStatusType.orderable),
    );
  }

  Future<bool> lockDelivery(DeliveryReturn delivery) async {
    return await update(
      () => deliveriesListRepository.amapDeliveriesDeliveryIdLockPost(
        deliveryId: delivery.id,
      ),
      (delivery) => delivery.id,
      delivery.copyWith(status: DeliveryStatusType.locked),
    );
  }

  Future<bool> deliverDelivery(DeliveryReturn delivery) async {
    return await update(
      () => deliveriesListRepository.amapDeliveriesDeliveryIdDeliveredPost(
        deliveryId: delivery.id,
      ),
      (delivery) => delivery.id,
      delivery.copyWith(status: DeliveryStatusType.delivered),
    );
  }

  Future<bool> archiveDelivery(DeliveryReturn delivery) async {
    return await delete(
      () => deliveriesListRepository.amapDeliveriesDeliveryIdArchivePost(
        deliveryId: delivery.id,
      ),
      (d) => d.id,
      delivery.id,
    );
  }

  Future<bool> deleteDelivery(String deliveryId) async {
    return await delete(
      () => deliveriesListRepository.amapDeliveriesDeliveryIdDelete(
        deliveryId: deliveryId,
      ),
      (d) => d.id,
      deliveryId,
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
