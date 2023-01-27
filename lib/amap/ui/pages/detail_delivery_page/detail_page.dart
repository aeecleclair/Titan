import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/delivery_order_list_provider.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';
import 'package:myecl/amap/providers/delivery_provider.dart';
import 'package:myecl/amap/providers/sorted_delivery_product.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/command_ui.dart';
import 'package:myecl/tools/functions.dart';

class DetailDeliveryPage extends HookConsumerWidget {
  const DetailDeliveryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final delivery = ref.watch(deliveryProvider);
    final deliveryOrders = ref.watch(adminDeliveryOrderListProvider);
    final deliveryProductListNotifier =
        ref.watch(deliveryProductListProvider.notifier);
    deliveryProductListNotifier.loadProductList(delivery.products);
    final sortedByCategoryDeliveryProducts =
        ref.watch(sortedByCategoryDeliveryProductsProvider);
    return Container(
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
          const SizedBox(
            height: 30,
          ),
          ...sortedByCategoryDeliveryProducts
              .map((key, value) {
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
                        height: 10,
                      ),
                      ...value.map((e) => Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text("- ${e.name}"),
                          )),
                    ],
                  ),
                );
              })
              .values
              .toList(),
          const SizedBox(
            height: 50,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Commandes :",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AMAPColorConstants.textDark)),
          ),
          const SizedBox(
            height: 30,
          ),
          deliveryOrders.when(
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
                    return const Center(child: Text("Aucune commande"));
                  } else {
                    return Column(
                      children: [
                        ...data.map((e) => Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: AutoSizeText(
                                            e.user.getName(),
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ...e.products.map((e) => Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Text("- ${e.name}"))),
                                    ],
                                  ),
                                ),
                                CommandeUI(
                                  order: e,
                                  onTap: () {},
                                  onEdit: () {},
                                  showButton: false,
                                ),
                              ],
                            )),
                      ],
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
        ],
      ),
    );
  }
}
