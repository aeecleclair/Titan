import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
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
import 'package:myecl/amap/ui/green_btn.dart';
import 'package:uuid/uuid.dart';

class Boutons extends HookConsumerWidget {
  const Boutons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryId = ref.watch(deliveryIdProvider);
    final products = ref.watch(productListProvider(deliveryId).notifier).lastLoadedProducts;
    final cmdsNotifier = ref.watch(orderListProvider(deliveryId).notifier);
    final indexCmd = ref.watch(orderIndexProvider);
    final pageNotifier = ref.read(amapPageProvider.notifier);
    final price = ref.watch(priceProvider);
    return SizedBox(
        height: 90,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          GestureDetector(
              child: GreenBtn(
                  text: "Confirmer (" + price.toStringAsFixed(2) + "€)"),
              onTap: () {
                if (price != 0.0) {
                  List<Product> prod = [];
                  for (var p in products) {
                    if (p.quantity != 0) {
                      prod.add(p.copyWith());
                    }
                  }
                  if (indexCmd == -1) {
                    Order newOrder = Order(
                        products: prod,
                        date: DateTime.now(),
                        id: const Uuid().v4(),);
                    cmdsNotifier.addOrder(newOrder);
                  } else {
                    cmdsNotifier.setProducts(indexCmd, prod);
                  }
                  pageNotifier.setAmapPage(0);
                  clearCmd(ref);
                } else {
                  displayToast(context, TypeMsg.error, "Pas de Product");
                }
              }),
          GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 70,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  ColorConstants.redGradient1,
                  ColorConstants.redGradient2
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                      color: ColorConstants.redGradient2.withOpacity(0.4),
                      offset: const Offset(2, 3),
                      blurRadius: 5)
                ],
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              alignment: Alignment.center,
              child: HeroIcon(
                HeroIcons.x,
                size: 35,
                color: ColorConstants.background,
              ),
            ),
            onTap: () {
              if (price != 0.0 || indexCmd != -1) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialogBox(
                        descriptions: "Supprimer la Order ?",
                        title: "Suppression",
                        onYes: () {
                          cancelCmd(ref);
                        }));
              } else {
                pageNotifier.setAmapPage(0);
                ref.watch(orderIndexProvider.notifier).setIndex(-1);
              }
            },
          ),
        ]));
  }
}
