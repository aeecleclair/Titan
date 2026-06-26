import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class OrderByDeliveryListNotifier extends ListNotifierAPI<OrderReturn> {
  Openapi get orderListRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<OrderReturn>> build() {
    return const AsyncValue.loading();
  }

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

final orderByDeliveryListProvider =
    NotifierProvider<
      OrderByDeliveryListNotifier,
      AsyncValue<List<OrderReturn>>
    >(OrderByDeliveryListNotifier.new);
