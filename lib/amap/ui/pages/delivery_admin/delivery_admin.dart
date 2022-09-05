import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/admin_delivery_order_list.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/is_amap_admin_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/delivery_admin/admin_delivery_ui.dart';
import 'package:myecl/amap/ui/refresh_indicator.dart';

class DeliveryAdminPage extends HookConsumerWidget {
  const DeliveryAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryList = ref.watch(deliveryListProvider);
    final deliveryListNotifier = ref.watch(deliveryListProvider.notifier);
    final isAmapAdmin = ref.watch(isAmapAdminProvider);
    final deliveryOrderList = ref.watch(adminDeliveryOrderList);
    List<Widget> listWidgetOrder = [];
    deliveryOrderList.when(
      data: (deliveries) {
        final deliveryList = deliveries.keys.toList();
        deliveryList.sort((a, b) => a.deliveryDate.compareTo(b.deliveryDate));
        if (deliveries.isNotEmpty) {
          final historyIndex = deliveryList.lastIndexWhere(
              (element) => element.deliveryDate.isBefore(DateTime.now()));
          final history = deliveryList.sublist(0, historyIndex + 1);
          final current = deliveryList.sublist(historyIndex + 1);
          if (current.isNotEmpty) {
            listWidgetOrder.addAll([
              const SizedBox(
                height: 30,
              ),
              const Text(
                AMAPTextConstants.deliveryList,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AMAPColorConstants.textDark,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ]);
            for (Delivery c in current) {
              listWidgetOrder
                  .add(DeliveryAdminUi(c: c, i: c.id, orders: deliveries[c]!));
            }
          }
          if (history.isNotEmpty) {
            listWidgetOrder.addAll([
              const SizedBox(
                height: 30,
              ),
              const Text(
                AMAPTextConstants.deliveryHistory,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AMAPColorConstants.textDark,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ]);
            for (Delivery c in history) {
              listWidgetOrder
                  .add(DeliveryAdminUi(c: c, i: c.id, orders: deliveries[c]!));
            }
          }
        } else {
          listWidgetOrder.add(Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                child: Text(
                  AMAPTextConstants.notPlannedDelivery,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ));
        }
      },
      error: (error, s) {
        listWidgetOrder.add(Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 70,
              alignment: Alignment.center,
              child: Text(
                error.toString(),
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ));
      },
      loading: () {
        listWidgetOrder.add(
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AMAPColorConstants.textDark,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        );
      },
    );

    return AmapRefresher(
        onRefresh: () async {
          await deliveryListNotifier.loadDeliveriesList();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(children: listWidgetOrder),
        ));
  }
}
