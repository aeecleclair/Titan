import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/providers/order_list_provider.dart';
import 'package:myecl/amap/ui/pages/cmd_page/add_button.dart';
import 'package:myecl/amap/ui/pages/cmd_page/commade_ui.dart';

class ListeOrders extends HookConsumerWidget {
  const ListeOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmds = ref.watch(orderListProvider);

    List<Widget> listWidgetOrder = [];

    if (cmds.isNotEmpty) {
      for (Order c in cmds) {
        listWidgetOrder.add(OrderUi(c: c));
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

    listWidgetOrder.add(const AddButton());
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(children: listWidgetOrder),
    );
  }
}
