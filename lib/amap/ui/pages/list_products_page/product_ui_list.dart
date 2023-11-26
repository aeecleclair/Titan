import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/providers/order_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class ProductUiInList extends ConsumerWidget {
  final ProductComplete p;
  const ProductUiInList({super.key, required this.p});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider);
    final orderNotifier = ref.watch(orderProvider.notifier);
    final quantity = order.productsdetail
        .firstWhere((element) => element.product.id == p.id,
            orElse: () => ProductQuantity.fromJson({}))
        .quantity;
    return Container(
        height: 50,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: AutoSizeText(
                p.name,
                maxLines: 2,
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
                const SizedBox(width: 10),
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
                            productsdetail: order.productsdetail
                                .where((element) => element.product.id != p.id)
                                .toList(),
                            amount: newAmount));
                      } else {
                        orderNotifier.setOrder(order.copyWith(
                            productsdetail: order.productsdetail
                                .map((e) => e.product.id == p.id
                                    ? e.copyWith(quantity: e.quantity - 1)
                                    : e)
                                .toList(),
                            amount: newAmount));
                      }
                    }
                  },
                ),
                const SizedBox(width: 3),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    quantity.toString(),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 3),
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
                    if (order.productsdetail
                        .map((e) => e.product.id)
                        .contains(p.id)) {
                      orderNotifier.setOrder(order.copyWith(
                          productsdetail: order.productsdetail
                              .map((e) => e.product.id == p.id
                                  ? e.copyWith(quantity: e.quantity + 1)
                                  : e)
                              .toList(),
                          amount: newAmount));
                    } else {
                      orderNotifier.setOrder(order.copyWith(productsdetail: [
                        ...order.productsdetail,
                        ProductQuantity(product: p, quantity: 1)
                      ], amount: newAmount));
                    }
                  },
                ),
                const SizedBox(width: 20),
              ],
            )
          ],
        ));
  }
}
