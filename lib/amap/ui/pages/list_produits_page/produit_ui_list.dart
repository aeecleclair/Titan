import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/order_provider.dart';
import 'package:myecl/amap/tools/constants.dart';

class ProductUiInList extends ConsumerWidget {
  final Product p;
  const ProductUiInList({Key? key, required this.p}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider);
    final orderNotifier = ref.watch(orderProvider.notifier);
    final quantity = order.products
        .firstWhere((element) => element.id == p.id,
            orElse: () => Product.empty())
        .quantity;
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
                style: const TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${p.price.toStringAsFixed(2)}€",
                    style: const TextStyle(fontSize: 15),
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
                      HeroIcons.minus,
                      size: 22,
                      color: quantity > 0
                          ? AMAPColorConstants.green2.withOpacity(0.8)
                          : AMAPColorConstants.background3,
                    ),
                  ),
                  onTap: () {
                    if (quantity > 0) {
                      final newAmount = order.amount - p.price;
                      if (quantity == 1) {
                        orderNotifier.setOrder(order.copyWith(
                            products: order.products
                                .where((element) => element.id != p.id)
                                .toList(),
                            amount: newAmount));
                      } else {
                        orderNotifier.setOrder(order.copyWith(
                            products: order.products
                                .map((e) => e.id == p.id
                                    ? e.copyWith(quantity: e.quantity - 1)
                                    : e)
                                .toList(),
                            amount: newAmount));
                      }
                    }
                  },
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    quantity.toString(),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    child: HeroIcon(HeroIcons.plus,
                        size: 22,
                        color: AMAPColorConstants.green2.withOpacity(0.8)),
                  ),
                  onTap: () {
                    final newAmount = order.amount + p.price;
                    if (order.products.map((e) => e.id).contains(p.id)) {
                      orderNotifier.setOrder(order.copyWith(
                          products: order.products
                              .map((e) => e.id == p.id
                                  ? e.copyWith(quantity: e.quantity + 1)
                                  : e)
                              .toList(),
                          amount: newAmount));
                    } else {
                      orderNotifier.setOrder(order.copyWith(products: [
                        ...order.products,
                        p.copyWith(quantity: 1)
                      ], amount: newAmount));
                    }
                  },
                ),
                Container(
                  width: 20,
                ),
              ],
            )
          ],
        ));
  }
}
