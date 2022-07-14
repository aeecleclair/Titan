import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/order_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/cmd_page/add_button.dart';
import 'package:myecl/amap/ui/pages/cmd_page/commade_ui.dart';

class ListeOrders extends HookConsumerWidget {
  const ListeOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryId = ref.watch(deliveryIdProvider);
    final orderList = ref.watch(orderListProvider(deliveryId));
    List<Widget> listWidgetOrder = [];
    orderList.when(data: (orders) {
      if (orders.isNotEmpty) {
        for (Order c in orders) {
          listWidgetOrder.add(OrderUi(c: c, i: orders.indexOf(c)));
        }
      } else {
        listWidgetOrder.add(Column(
          children: [
            Container(
              height: 70,
              alignment: Alignment.center,
              child: Text(
                "Pas de commandes actuellement",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ));
      }
    }, error: (error, s) {
      listWidgetOrder.add(Column(
        children: [
          Container(
            height: 70,
            alignment: Alignment.center,
            child: Text(
              "Pas de commandes actuellement",
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ));
    }, loading: () {
      listWidgetOrder.add(Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 70,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                ColorConstants.textDark,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ));
    });

    listWidgetOrder.add(const AddButton());
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(children: listWidgetOrder),
    );
  }
}
