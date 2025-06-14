import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/providers/order_provider.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/amap/ui/amap.dart';
import 'package:titan/amap/ui/components/order_ui.dart';
import 'package:titan/amap/ui/components/product_ui.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider);
    return AmapTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade50,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        const AlignLeftText(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          AMAPTextConstants.products,
                          fontSize: 25,
                        ),
                        const SizedBox(height: 10),
                        if (order.products.isNotEmpty)
                          Wrap(
                            children: order.products
                                .map(
                                  (product) => ProductCard(
                                    product: product,
                                    showButton: false,
                                  ),
                                )
                                .toList(),
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: OrderUI(order: order, showButton: false, isDetail: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
