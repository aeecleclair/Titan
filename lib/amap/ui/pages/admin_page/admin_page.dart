import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/providers/cash_provider.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/ui/amap.dart';
import 'package:myecl/amap/ui/pages/admin_page/account_handler.dart';
import 'package:myecl/amap/ui/pages/admin_page/delivery_handler.dart';
import 'package:myecl/amap/ui/pages/admin_page/product_handler.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cashNotifier = ref.read(cashProvider.notifier);
    final deliveryListNotifier = ref.read(deliveryListProvider.notifier);
    final productListNotifier = ref.read(productListProvider.notifier);
    return AmapTemplate(
      child: Refresher(
          onRefresh: () async {
            await cashNotifier.loadCashList();
            await deliveryListNotifier.loadDeliveriesList();
            await productListNotifier.loadProductList();
          },
          child: const Column(
            children: [
              AccountHandler(),
              SizedBox(height: 12),
              DeliveryHandler(),
              SizedBox(height: 12),
              ProductHandler(),
            ],
          )),
    );
  }
}
