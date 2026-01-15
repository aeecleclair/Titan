import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/amap/class/product.dart';
import 'package:titan/amap/providers/order_provider.dart';
import 'package:titan/amap/tools/constants.dart';

class ProductUiInList extends ConsumerWidget {
  final Product p;
  const ProductUiInList({super.key, required this.p});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider);
    final orderNotifier = ref.watch(orderProvider.notifier);
    final quantity = order.products
        .firstWhere(
          (element) => element.id == p.id,
          orElse: () => Product.empty(),
        )
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
                  "${(p.price / 100).toStringAsFixed(2)}€",
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
                        ? AMAPColorConstants.green2.withValues(alpha: 0.8)
                        : AMAPColorConstants.background3,
                  ),
                ),
                onTap: () {
                  if (quantity > 0) {
                    final newAmount = order.amount - p.price;
                    if (quantity == 1) {
                      orderNotifier.setOrder(
                        order.copyWith(
                          products: order.products
                              .where((element) => element.id != p.id)
                              .toList(),
                          amount: newAmount,
                        ),
                      );
                    } else {
                      orderNotifier.setOrder(
                        order.copyWith(
                          products: order.products
                              .map(
                                (e) => e.id == p.id
                                    ? e.copyWith(quantity: e.quantity - 1)
                                    : e,
                              )
                              .toList(),
                          amount: newAmount,
                        ),
                      );
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
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              GestureDetector(
                child: Container(
                  width: 25,
                  height: 25,
                  alignment: Alignment.center,
                  child: HeroIcon(
                    HeroIcons.plus,
                    size: 22,
                    color: AMAPColorConstants.green2.withValues(alpha: 0.8),
                  ),
                ),
                onTap: () {
                  final newAmount = order.amount + p.price;
                  if (order.products.map((e) => e.id).contains(p.id)) {
                    orderNotifier.setOrder(
                      order.copyWith(
                        products: order.products
                            .map(
                              (e) => e.id == p.id
                                  ? e.copyWith(quantity: e.quantity + 1)
                                  : e,
                            )
                            .toList(),
                        amount: newAmount,
                      ),
                    );
                  } else {
                    orderNotifier.setOrder(
                      order.copyWith(
                        products: [...order.products, p.copyWith(quantity: 1)],
                        amount: newAmount,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}
