import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';
import 'package:myecl/amap/providers/order_index_provider.dart';
import 'package:myecl/amap/providers/order_list_provider.dart';
import 'package:myecl/amap/providers/order_price_provider.dart';
import 'package:myecl/amap/providers/user_amount_provider.dart';
import 'package:myecl/amap/tools/dialog.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/tools/functions.dart';

class OrderUi extends ConsumerWidget {
  final Order c;
  final int i;
  final bool isAdmin;
  const OrderUi({Key? key, required this.c, required this.i, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryList = ref.watch(deliveryListProvider);
    final deliveryId = ref.watch(deliveryIdProvider);
    final cmdsNotifier = ref.watch(orderListProvider(deliveryId).notifier);
    final productsNotifier =
        ref.watch(deliveryProductListProvider(deliveryId).notifier);
    final indexCmdNotifier = ref.watch(orderIndexProvider.notifier);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final priceNotofier = ref.watch(priceProvider.notifier);
    final userAmountNotifier = ref.watch(userAmountProvider.notifier);
    var locked = false;
    deliveryList.when(
        data: (deliveries) {
          if (deliveries.isNotEmpty) {
            for (Delivery d in deliveries) {
              if (d.id == c.deliveryId) {
                locked = d.locked;
              }
            }
          }
        },
        error: (error, s) {},
        loading: () {});
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: Colors.grey.shade50,
        boxShadow: [
          BoxShadow(
            color: AMAPColorConstants.background3.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(2, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 30,
                height: 60,
              ),
              Expanded(
                child: Text(
                  !isAdmin ? "Le " +
                      processDate(c.deliveryDate) : c.user.getName() +
                      " (" +
                      c.collectionSlot +
                      ")",
                  style: TextStyle(
                      fontSize: !isAdmin ? 20: 16,
                      fontWeight: FontWeight.w700,
                      color: AMAPColorConstants.green1),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 50,
                  height: 25,
                  alignment: Alignment.topCenter,
                  child: HeroIcon(
                    c.expanded ? HeroIcons.chevronUp : HeroIcons.chevronDown,
                    color: AMAPColorConstants.textDark,
                  ),
                ),
                onTap: () {
                  cmdsNotifier.toggleExpanded(i);
                },
              )
            ],
          ),
          c.expanded
              ? Column(
                  children: c.products
                      .map((p) => Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          alignment: Alignment.center,
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  p.name +
                                      " (" +
                                      AMAPTextConstants.quantity +
                                      " : " +
                                      p.quantity.toString() +
                                      ")",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AMAPColorConstants.textDark,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                width: 15,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      (p.quantity * p.price)
                                              .toStringAsFixed(2) +
                                          "€",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AMAPColorConstants.textDark,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                ],
                              )
                            ],
                          )))
                      .toList())
              : Container(),
          Container(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 25,
              ),
              Container(
                width: 140,
                alignment: Alignment.centerLeft,
                child: Text(
                  c.products.length.toString() +
                      " " +
                      AMAPTextConstants.product +
                      (c.products.length != 1 ? "s" : ""),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AMAPColorConstants.textLight),
                ),
              ),
              Container(
                  width: 140,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AMAPTextConstants.price +
                        " : " +
                        (c.products.map((p) => p.quantity * p.price))
                            .reduce((value, element) => value + element)
                            .toStringAsFixed(2) +
                        "€",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AMAPColorConstants.textLight),
                  ))
            ],
          ),
          Container(
            height: 20,
          ),
          c.expanded && !locked && !isAdmin
              ? Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 70,
                        width: (MediaQuery.of(context).size.width - 40) / 2,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(23),
                                topLeft: Radius.circular(23)),
                            color: AMAPColorConstants.background3),
                        alignment: Alignment.center,
                        child: const Text(AMAPTextConstants.update,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AMAPColorConstants.enabled)),
                      ),
                      onTap: () {
                        indexCmdNotifier.setIndex(i);
                        for (Product p
                            in c.products.where((e) => e.quantity != 0)) {
                          productsNotifier.setQuantity(p, p.quantity);
                        }
                        cmdsNotifier.getprice(i).then((value) {
                          priceNotofier.setOrderPrice(value);
                        });
                        pageNotifier.setAmapPage(AmapPage.products);
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 70,
                        width: (MediaQuery.of(context).size.width - 40) / 2,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(23),
                                topRight: Radius.circular(23)),
                            color: AMAPColorConstants.background3),
                        alignment: Alignment.center,
                        child: const Text(AMAPTextConstants.delete,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 144, 54, 61))),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AMAPDialog(
                                descriptions: AMAPTextConstants.deletingOrder,
                                title: AMAPTextConstants.deleting,
                                onYes: () {
                                  deleteCmd(ref, i);
                                  final price = c.products
                                      .map((p) => p.quantity * p.price)
                                      .reduce(
                                          (value, element) => value + element);
                                  userAmountNotifier.updateCash(price);
                                  displayAMAPToast(context, TypeMsg.msg,
                                      AMAPTextConstants.deletedOrder);
                                }));
                      },
                    )
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
