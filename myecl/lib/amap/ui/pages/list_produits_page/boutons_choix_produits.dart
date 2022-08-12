import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/collection_slot_provider.dart';
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
import 'package:myecl/amap/ui/green_btn.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';
import 'package:uuid/uuid.dart';

class Boutons extends HookConsumerWidget {
  const Boutons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryId = ref.watch(deliveryIdProvider);
    final productsList = ref.watch(deliveryProductListProvider(deliveryId));
    final cmds = ref.watch(orderListProvider(deliveryId));
    final cmdsNotifier = ref.watch(orderListProvider(deliveryId).notifier);
    final indexCmd = ref.watch(orderIndexProvider);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final price = ref.watch(priceProvider);
    final delList = ref.watch(deliveryList);
    final collectionSlotNotifier = ref.watch(collectionSlotProvider.notifier);
    final userAmount = ref.watch(userAmountProvider);
    final userAmountNotifier = ref.watch(userAmountProvider.notifier);

    final products = [];
    productsList.when(
      data: (list) => products.addAll(list),
      error: (e, s) {},
      loading: () {},
    );

    double b = 0;
    userAmount.when(
        data: (u) {
          b = u.balance;
        },
        error: (e, s) {},
        loading: () {});

    return SizedBox(
        height: 90,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          GestureDetector(
              child: GreenBtn(
                  text: "Confirmer (" + price.toStringAsFixed(2) + "€)"),
              onTap: () {
                if (price == 0.0) {
                  displayToast(context, TypeMsg.error, "Pas de produit");
                } else if (indexCmd == -1 && price < b) {
                  List<Product> prod = [];
                  for (var p in products) {
                    if (p.quantity != 0) {
                      prod.add(p.copyWith());
                    }
                  }
                  Order newOrder = Order(
                      products: prod,
                      deliveryDate: delList
                          .firstWhere((d) => d.id == deliveryId)
                          .deliveryDate,
                      id: const Uuid().v4(),
                      amount: price,
                      deliveryId: deliveryId,
                      productsIds: prod.map((e) => e.id).toList(),
                      collectionSlot: collectionSlotNotifier.getText());
                  tokenExpireWrapper(ref, () {
                    cmdsNotifier.addOrder(newOrder).then((value) {
                      if (value) {
                        pageNotifier.setAmapPage(AmapPage.main);
                        userAmountNotifier.updateCash(-price);
                        displayToast(context, TypeMsg.msg, "Commande ajoutée");
                        clearCmd(ref);
                      } else {
                        pageNotifier.setAmapPage(AmapPage.main);
                        displayToast(
                            context, TypeMsg.error, "Echec de l'ajout");
                      }
                    });
                  });
                } else {
                  var lastPrice = 0.0;
                  cmds.when(
                    data: (c) {
                      for (var p in c[indexCmd].products) {
                        lastPrice += p.price * p.quantity;
                      }
                    },
                    error: (Object error, StackTrace? stackTrace) {},
                    loading: () {},
                  );
                  if (price < b + lastPrice) {
                    List<Product> prod = [];
                    for (var p in products) {
                      if (p.quantity != 0) {
                        prod.add(p.copyWith());
                      }
                    }
                    tokenExpireWrapper(ref, () {
                      cmdsNotifier.setProducts(indexCmd, prod).then((value) {
                        if (value) {
                          pageNotifier.setAmapPage(AmapPage.main);
                          userAmountNotifier.updateCash(lastPrice - price);
                          displayToast(
                              context, TypeMsg.msg, "Commande modifiée");
                        } else {
                          pageNotifier.setAmapPage(AmapPage.main);
                          displayToast(context, TypeMsg.error,
                              "Echec de la modification");
                        }
                      });
                    });
                    clearCmd(ref);
                  } else {
                    displayToast(context, TypeMsg.error, "Pas assez d'argent");
                  }
                }
              }),
          GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 70,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  AMAPColorConstants.redGradient1,
                  AMAPColorConstants.redGradient2
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                      color: AMAPColorConstants.redGradient2.withOpacity(0.4),
                      offset: const Offset(2, 3),
                      blurRadius: 5)
                ],
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              alignment: Alignment.center,
              child: HeroIcon(
                HeroIcons.x,
                size: 35,
                color: AMAPColorConstants.background,
              ),
            ),
            onTap: () {
              if (price != 0.0 || indexCmd != -1) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AMAPDialog(
                        descriptions: "Supprimer la commande ?",
                        title: "Suppression",
                        onYes: () {
                          cancelCmd(ref);
                        }));
              } else {
                pageNotifier.setAmapPage(AmapPage.main);
                ref.watch(orderIndexProvider.notifier).setIndex(-1);
              }
            },
          ),
        ]));
  }
}
