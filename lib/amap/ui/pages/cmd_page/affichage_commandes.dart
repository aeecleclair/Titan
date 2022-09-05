import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/order_list_provider.dart';
import 'package:myecl/amap/providers/user_amount_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/cmd_page/add_button.dart';
import 'package:myecl/amap/ui/commade_ui.dart';
import 'package:myecl/amap/ui/refresh_indicator.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';

class ListeOrders extends HookConsumerWidget {
  const ListeOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryId = ref.watch(deliveryIdProvider);
    final orderList = ref.watch(orderListProvider(deliveryId));
    final orderListNotifier = ref.watch(orderListProvider(deliveryId).notifier);
    final soldeNotifier = ref.watch(userAmountProvider.notifier);
    final userId = ref.watch(idProvider);
    List<Widget> listWidgetOrder = [];
    orderList.when(data: (orders) {
      if (orders.isNotEmpty) {
        for (Order c in orders) {
          listWidgetOrder.add(OrderUi(c: c, i: orders.indexOf(c), isAdmin: false,));
        }
      } else {
        listWidgetOrder.add(Column(
          children: [
            Container(
              height: 70,
              alignment: Alignment.center,
              child: Text(
                AMAPTextConstants.noCurrentOrder,
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
              error.toString(),
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
                AMAPColorConstants.textDark,
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
    return AmapRefresher(
      onRefresh: () async {
        await orderListNotifier.loadOrderList();
        await soldeNotifier.loadCashByUser(userId);
      },
      child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(children: listWidgetOrder)),
    );
  }
}
