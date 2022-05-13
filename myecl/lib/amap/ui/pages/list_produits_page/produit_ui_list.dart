import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/order_price_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';

class ProductUiInList extends ConsumerWidget {
  final int i;
  const ProductUiInList({Key? key, required this.i}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider.notifier).lastLoadedProducts;
    final productsNotifier = ref.watch(productListProvider.notifier);
    final prix = ref.watch(prixProvider);
    final prixNotofier = ref.watch(prixProvider.notifier);
    Product p = products[i];
    return Container(
        height: 50,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 20,
            ),
            Expanded(
              child: Text(
                p.nom,
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 40,
                  alignment: Alignment.centerRight,
                  child: Text(
                    p.prix.toStringAsFixed(2) + "€",
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                Container(
                  width: 10,
                ),
                GestureDetector(
                  child: Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    child: HeroIcon(
                      HeroIcons.minusSm,
                      size: 20,
                      color: p.quantite > 0
                          ? ColorConstants.l2.withOpacity(0.8)
                          : ColorConstants.background3,
                    ),
                  ),
                  onTap: () {
                    if (p.quantite > 0) {
                      productsNotifier.setQuantity(p.id, p.quantite - 1);
                      prixNotofier.setOrderPrice(
                          double.parse((prix - p.prix).toStringAsFixed(2)));
                    }
                  },
                ),
                Container(
                  width: 15,
                  alignment: Alignment.center,
                  child: Text(
                    p.quantite.toString(),
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    child: HeroIcon(
                      HeroIcons.plusSm,
                      size: 20,
                      color: p.quantite < 5
                          ? ColorConstants.l2.withOpacity(0.8)
                          : ColorConstants.background3,
                    ),
                  ),
                  onTap: () {
                    if (p.quantite < 5) {
                      productsNotifier.setQuantity(p.id, p.quantite + 1);
                      prixNotofier.setOrderPrice(
                          double.parse((prix + p.prix).toStringAsFixed(2)));
                    }
                  },
                ),
                Container(
                  width: 10,
                ),
              ],
            )
          ],
        ));
  }
}
