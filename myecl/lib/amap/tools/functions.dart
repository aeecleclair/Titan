import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';
import 'package:myecl/amap/providers/order_index_provider.dart';
import 'package:myecl/amap/providers/order_list_provider.dart';
import 'package:myecl/amap/providers/order_price_provider.dart';
import 'package:myecl/amap/tools/constants.dart';

void clearCmd(WidgetRef ref) {
  final deliveryId = ref.watch(deliveryIdProvider);
  final productsNotifier = ref.watch(deliveryProductListProvider(deliveryId).notifier);
  final priceNotofier = ref.watch(priceProvider.notifier);
  productsNotifier.resetQuantity();
  priceNotofier.setOrderPrice(0.0);
}

void cancelCmd(WidgetRef ref) {
  final indexCmd = ref.watch(orderIndexProvider);
  final pageNotifier = ref.watch(amapPageProvider.notifier);
  pageNotifier.setAmapPage(1);
  clearCmd(ref);
  if (indexCmd != -1) {
    deleteCmd(ref, indexCmd);
  }
}

void deleteCmd(WidgetRef ref, int i) {
  final deliveryId = ref.watch(deliveryIdProvider);
  final indexCmdNotifier = ref.watch(orderIndexProvider.notifier);
  final cmdsNotifier = ref.watch(orderListProvider(deliveryId).notifier);
  indexCmdNotifier.setIndex(-1);
  cmdsNotifier.deleteOrder(i);
}

enum TypeMsg { msg, error }

void displayToast(BuildContext context, TypeMsg type, String text) {
  LinearGradient linearGradient;
  HeroIcons icon;

  switch (type) {
    case TypeMsg.msg:
      linearGradient = const LinearGradient(
          colors: [ColorConstants.gradient1, ColorConstants.gradient2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight);
      icon = HeroIcons.check;
      break;
    case TypeMsg.error:
      linearGradient = const LinearGradient(
          colors: [ColorConstants.redGradient1, ColorConstants.redGradient2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight);
      icon = HeroIcons.exclamation;
      break;
  }

  showFlash(
      context: context,
      duration: const Duration(milliseconds: 1500),
      builder: (context, controller) {
        return Flash.dialog(
          controller: controller,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          backgroundGradient: linearGradient,
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: HeroIcon(icon, color: ColorConstants.background),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.background),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}