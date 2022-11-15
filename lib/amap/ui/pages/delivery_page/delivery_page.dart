import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/delivery_page/delivery_ui.dart';
import 'package:myecl/tools/refresher.dart';

class DeliveryPage extends HookConsumerWidget {
  const DeliveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryList = ref.watch(deliveryListProvider);
    final deliveryListNotifier = ref.watch(deliveryListProvider.notifier);
    List<Widget> listWidgetOrder = [];
    deliveryList.when(
      data: (deliveries) {
        deliveries.sort((a, b) => a.deliveryDate.compareTo(b.deliveryDate));
        deliveries = deliveries.where((element) => !element.locked).toList();
        if (deliveries.isNotEmpty) {
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
          for (Delivery c in deliveries) {
            listWidgetOrder.add(DeliveryUi(c: c, i: c.id));
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

    return Refresher(
      onRefresh: () async {
        await deliveryListNotifier.loadDeliveriesList();
      },
      child: Column(children: listWidgetOrder),
    );
  }
}
