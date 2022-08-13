import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';
import 'package:myecl/amap/providers/order_price_provider.dart';
import 'package:myecl/amap/tools/constants.dart';

class ProductUiInList extends ConsumerWidget {
  final Product p;
  const ProductUiInList({Key? key, required this.p}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryId = ref.watch(deliveryIdProvider);
    final productsNotifier = ref.watch(deliveryProductListProvider(deliveryId).notifier);
    final price = ref.watch(priceProvider);
    final priceNotifier = ref.watch(priceProvider.notifier);
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
                p.name,
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
                    p.price.toStringAsFixed(2) + "€",
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
                      color: p.quantity > 0
                          ? AMAPColorConstants.green2.withOpacity(0.8)
                          : AMAPColorConstants.background3,
                    ),
                  ),
                  onTap: () {
                    if (p.quantity > 0) {
                      productsNotifier.setQuantity(p.id, p.quantity - 1);
                      priceNotifier.setOrderPrice(
                          double.parse((price - p.price).toStringAsFixed(2)));
                    }
                  },
                ),
                Container(
                  width: 15,
                  alignment: Alignment.center,
                  child: Text(
                    p.quantity.toString(),
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
                      color: p.quantity < 5
                          ? AMAPColorConstants.green2.withOpacity(0.8)
                          : AMAPColorConstants.background3,
                    ),
                  ),
                  onTap: () {
                    if (p.quantity < 5) {
                      productsNotifier.setQuantity(p.id, p.quantity + 1);
                      priceNotifier.setOrderPrice(
                          double.parse((price + p.price).toStringAsFixed(2)));
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
