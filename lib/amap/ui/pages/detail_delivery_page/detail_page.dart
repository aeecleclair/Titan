import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/cash_provider.dart';
import 'package:myecl/amap/providers/delivery_order_list_provider.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';
import 'package:myecl/amap/providers/delivery_provider.dart';
import 'package:myecl/amap/providers/sorted_delivery_product.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/detail_delivery_page/order_detail_ui.dart';
import 'package:myecl/amap/ui/pages/detail_delivery_page/product_detail_ui.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/refresher.dart';

class DetailDeliveryPage extends HookConsumerWidget {
  const DetailDeliveryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final delivery = ref.watch(deliveryProvider);
    final deliveryOrders = ref.watch(adminDeliveryOrderListProvider);
    final deliveryProductListNotifier =
        ref.watch(deliveryProductListProvider.notifier);
    final sortedByCategoryDeliveryProducts =
        ref.watch(sortedByCategoryDeliveryProductsProvider);
    final cash = ref.watch(cashProvider);
    return Refresher(
      onRefresh: () async {
        await deliveryProductListNotifier.loadProductList(delivery.products);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  "Date de livraison : ${processDate(delivery.deliveryDate)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Produits :",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AMAPColorConstants.textDark)),
                ),
              ],
            ),
          ),
          ...sortedByCategoryDeliveryProducts
              .map((key, value) {
                Map<String, int> productsQuantity = {};
                deliveryOrders.when(
                    data: (orderMap) {
                      final deliveryOrderList = orderMap[delivery.id];
                      if (deliveryOrderList != null) {
                        deliveryOrderList.item1.when(
                            data: (listOrders) {
                              for (Order o in listOrders) {
                                for (Product p in o.products) {
                                  if (!productsQuantity.containsKey(p.id)) {
                                    productsQuantity
                                        .addEntries({p.id: 0}.entries);
                                  }
                                  productsQuantity[p.id] =
                                      productsQuantity[p.id]! + 1;
                                }
                              }
                            },
                            error: (e, s) {},
                            loading: () {});
                      }
                    },
                    error: (Object error, StackTrace stackTrace) {},
                    loading: () {});
                return MapEntry(
                  key,
                  Column(
                    children: [
                      Text(
                        key,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        children: value
                            .map((e) => Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: ProductDetailCard(
                                    product: e,
                                    quantity: productsQuantity[e.id] ?? 0,
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              })
              .values
              .toList(),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 30),
            child: const Text("Commandes :",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AMAPColorConstants.textDark)),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: deliveryOrders.when(
              data: (data) {
                final orders = data[delivery.id];
                if (orders == null) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AMAPColorConstants.greenGradient2,
                  ));
                }
                return orders.item1.when(
                  data: (data) {
                    if (data.isEmpty) {
                      return Container(
                          margin: const EdgeInsets.only(bottom: 50),
                          child: const Center(child: Text("Aucune commande")));
                    } else {
                      return cash.when(
                        data: (cash) {
                          return Column(
                            children: data.map((e) {
                              final userCash = cash.firstWhere(
                                  (element) => element.user.id == e.user.id);
                              return DetailOrderUI(
                                order: e,
                                userCash: userCash,
                              );
                            }).toList(),
                          );
                        },
                        loading: () => const Center(
                            child: CircularProgressIndicator(
                          color: AMAPColorConstants.greenGradient2,
                        )),
                        error: (error, stack) => Text(error.toString()),
                      );
                    }
                  },
                  loading: () => const Center(
                      child: CircularProgressIndicator(
                    color: AMAPColorConstants.greenGradient2,
                  )),
                  error: (error, stack) => Text(error.toString()),
                );
              },
              loading: () => const Center(
                  child: CircularProgressIndicator(
                color: AMAPColorConstants.greenGradient2,
              )),
              error: (error, stack) => Text(error.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
