import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/order_index_provider.dart';
import 'package:myecl/amap/providers/order_list_provider.dart';
import 'package:myecl/amap/providers/order_price_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/tools/dialog.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';

class OrderUi extends ConsumerWidget {
  final Order c;
  const OrderUi({Key? key, required this.c}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmds = ref.watch(orderList);
    final deliveryId = ref.watch(deliveryIdProvider);
    final cmdsNotifier = ref.watch(orderListProvider(deliveryId).notifier);
    final productsNotifier = ref.watch(productListProvider(deliveryId).notifier);
    final indexCmdNotifier = ref.watch(orderIndexProvider.notifier);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final priceNotofier = ref.watch(priceProvider.notifier);
    final i = cmds.indexOf(c);
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: Colors.grey.shade50,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.background3.withOpacity(0.4),
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
                  "Date : " +
                      c.date.day.toString().padLeft(2, "0") +
                      "/" +
                      c.date.month.toString().padLeft(2, "0") +
                      "/" +
                      c.date.year.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.l1),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 50,
                  height: 25,
                  alignment: Alignment.topCenter,
                  child: HeroIcon(
                    cmds[i].expanded
                        ? HeroIcons.chevronUp
                        : HeroIcons.chevronDown,
                    color: ColorConstants.textDark,
                  ),
                ),
                onTap: () {
                  cmdsNotifier.toggleExpanded(i);
                },
              )
            ],
          ),
          cmds[i].expanded
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
                                      " (quantité : " +
                                      p.quantity.toString() +
                                      ")",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: ColorConstants.textDark,
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
                                        color: ColorConstants.textDark,
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
                      " produit" +
                      (c.products.length != 1 ? "s" : ""),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.textLight),
                ),
              ),
              Container(
                  width: 140,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "price : " +
                        (c.products.map((p) => p.quantity * p.price))
                            .reduce((value, element) => value + element)
                            .toStringAsFixed(2) +
                        "€",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.textLight),
                  ))
            ],
          ),
          Container(
            height: 20,
          ),
          cmds[i].expanded
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
                            color: ColorConstants.background3),
                        alignment: Alignment.center,
                        child: const Text("Modifier",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.enabled)),
                      ),
                      onTap: () {
                        indexCmdNotifier.setIndex(i);
                        for (Product p
                            in cmds[i].products.where((e) => e.quantity != 0)) {
                          productsNotifier.setQuantity(p.id, p.quantity);
                        }
                        cmdsNotifier.getprice(i).then((value) {
                          priceNotofier.setOrderPrice(value);
                        });
                        pageNotifier.setAmapPage(2);
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
                            color: ColorConstants.background3),
                        alignment: Alignment.center,
                        child: const Text("Supprimer",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 144, 54, 61))),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => CustomDialogBox(
                                descriptions: "Supprimer la commande ?",
                                title: "Suppression",
                                onYes: () {
                                  deleteCmd(ref, i);
                                  displayToast(context, TypeMsg.msg,
                                      "Commande supprimée");
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
