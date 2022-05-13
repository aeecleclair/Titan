import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/order_index_provider.dart';
import 'package:myecl/amap/providers/order_list_provider.dart';
import 'package:myecl/amap/providers/order_price_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/tools/dialog.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/amap/ui/green_btn.dart';

class Boutons extends HookConsumerWidget {
  const Boutons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider.notifier).lastLoadedProducts;
    final cmds = ref.read(orderListProvider);
    final cmdsNotifier = ref.watch(orderListProvider.notifier);
    final indexCmd = ref.watch(orderIndexProvider);
    final pageNotifier = ref.read(amapPageProvider.notifier);
    final prix = ref.watch(prixProvider);
    return SizedBox(
        height: 90,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          GestureDetector(
              child: GreenBtn(
                  text: "Confirmer (" + prix.toStringAsFixed(2) + "€)"),
              onTap: () {
                if (prix != 0.0) {
                  List<Product> prod = [];
                  for (var p in products) {
                    if (p.quantite != 0) {
                      prod.add(p.copy());
                    }
                  }
                  if (indexCmd == -1) {
                    cmdsNotifier.addOrder(DateTime.now(), prod);
                  } else {
                    cmdsNotifier.setProducts(cmds[indexCmd].id, prod);
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
              if (prix != 0.0 || indexCmd != -1) {
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
