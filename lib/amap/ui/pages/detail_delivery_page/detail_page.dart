import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/cash_list_provider.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/delivery_order_list_provider.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';
import 'package:myecl/amap/providers/delivery_provider.dart';
import 'package:myecl/amap/providers/sorted_delivery_product.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/amap.dart';
import 'package:myecl/amap/ui/pages/detail_delivery_page/order_detail_ui.dart';
import 'package:myecl/amap/ui/pages/detail_delivery_page/product_detail_ui.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/widgets/loader.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class DetailDeliveryPage extends HookConsumerWidget {
  const DetailDeliveryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final delivery = ref.watch(deliveryProvider);
    final deliveryOrders = ref.watch(adminDeliveryOrderListProvider);
    final orders = deliveryOrders[delivery.id];
    final deliveryListNotifier = ref.read(deliveryListProvider.notifier);
    final deliveryProductListNotifier =
        ref.watch(deliveryProductListProvider.notifier);
    final sortedByCategoryDeliveryProducts =
        ref.watch(sortedByCategoryDeliveryProductsProvider);
    final cash = ref.watch(cashListProvider);
    return AmapTemplate(
      child: Refresher(
        onRefresh: () async {
          await deliveryProductListNotifier.loadProductList(delivery.products ?? []);
          await deliveryListNotifier.loadDeliveriesList();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Text(
                    "${AMAPTextConstants.deliveryDate} : ${processDate(delivery.deliveryDate)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const AlignLeftText(
                    "${AMAPTextConstants.products} :",
                    color: AMAPColorConstants.textDark,
                  ),
                ],
              ),
            ),
            ...sortedByCategoryDeliveryProducts.map((key, value) {
              Map<String, int> productsQuantity = {};
              final deliveryOrderList = deliveryOrders[delivery.id];
              if (deliveryOrderList != null) {
                deliveryOrderList.maybeWhen(
                  data: (listOrders) {
                    for (OrderReturn o in listOrders) {
                      for (ProductQuantity p in o.productsdetail) {
                        if (!productsQuantity.containsKey(p.product.id)) {
                          productsQuantity.addEntries({p.product.id: 0}.entries);
                        }
                        productsQuantity[p.product.id] =
                            productsQuantity[p.product.id]! + p.quantity;
                      }
                    }
                  },
                  orElse: () {},
                );
              }
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
                    const SizedBox(height: 5),
                    Wrap(
                      children: value
                          .map(
                            (e) => Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ProductDetailCard(
                                product: e,
                                quantity: productsQuantity[e.id] ?? 0,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            }).values,
            const SizedBox(height: 20),
            const AlignLeftText(
              "${AMAPTextConstants.orders} :",
              padding: EdgeInsets.only(left: 30),
              color: AMAPColorConstants.textDark,
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: orders == null
                  ? const Loader(color: AMAPColorConstants.greenGradient2)
                  : AsyncChild(
                      value: orders,
                      loaderColor: AMAPColorConstants.greenGradient2,
                      builder: (context, data) {
                        if (data.isEmpty) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 50),
                            child: const Center(
                              child: Text(AMAPTextConstants.noOrder),
                            ),
                          );
                        }
                        return AsyncChild(
                          value: cash,
                          loaderColor: AMAPColorConstants.greenGradient2,
                          builder: (context, cash) {
                            return Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: data.map((e) {
                                final userCash = cash.firstWhere(
                                  (element) => element.user.id == e.user.id,
                                );
                                return DetailOrderUI(
                                  order: e,
                                  userCash: userCash,
                                  deliveryId: delivery.id,
                                );
                              }).toList(),
                            );
                          },
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
