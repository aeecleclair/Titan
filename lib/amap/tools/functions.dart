import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';
import 'package:myecl/amap/providers/order_index_provider.dart';
import 'package:myecl/amap/providers/order_list_provider.dart';
import 'package:myecl/amap/providers/order_price_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

void clearCmd(WidgetRef ref) {
  final deliveryId = ref.watch(deliveryIdProvider);
  final productsNotifier =
      ref.watch(deliveryProductListProvider(deliveryId).notifier);
  final priceNotofier = ref.watch(priceProvider.notifier);
  productsNotifier.resetQuantity();
  priceNotofier.setOrderPrice(0.0);
}

void cancelCmd(WidgetRef ref) {
  final indexCmd = ref.watch(orderIndexProvider);
  final pageNotifier = ref.watch(amapPageProvider.notifier);
  pageNotifier.setAmapPage(AmapPage.main);
  clearCmd(ref);
  if (indexCmd != -1) {
    deleteCmd(ref, indexCmd);
  }
}

void deleteCmd(WidgetRef ref, int i) {
  final deliveryId = ref.watch(deliveryIdProvider);
  final indexCmdNotifier = ref.watch(orderIndexProvider.notifier);
  final cmdsNotifier = ref.watch(orderListProvider(deliveryId).notifier);
  final cmds = ref.watch(orderListProvider(deliveryId));
  indexCmdNotifier.setIndex(-1);
  cmdsNotifier.deleteOrder(cmds.value![i]);
}
