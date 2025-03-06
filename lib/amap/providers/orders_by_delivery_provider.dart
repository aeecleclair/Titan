import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class OrderByDeliveryListNotifier extends ListNotifierAPI<OrderReturn> {
  final Openapi orderListRepository;
  OrderByDeliveryListNotifier({required this.orderListRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<OrderReturn>>> loadDeliveryOrderList(
    String deliveryId,
  ) async {
    return await loadList(
      () async => orderListRepository.amapDeliveriesDeliveryIdOrdersGet(
        deliveryId: deliveryId,
      ),
    );
  }
}

final orderByDeliveryListProvider = StateNotifierProvider<
    OrderByDeliveryListNotifier, AsyncValue<List<OrderReturn>>>((ref) {
  final orderListRepository = ref.watch(repositoryProvider);
  return OrderByDeliveryListNotifier(orderListRepository: orderListRepository);
});
