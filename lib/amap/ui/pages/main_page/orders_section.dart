import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/class/delivery.dart';
import 'package:titan/amap/class/order.dart';
import 'package:titan/amap/providers/delivery_id_provider.dart';
import 'package:titan/amap/providers/delivery_list_provider.dart';
import 'package:titan/amap/providers/order_provider.dart';
import 'package:titan/amap/providers/user_order_list_provider.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/amap/ui/components/order_ui.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';

class OrderSection extends HookConsumerWidget {
  final VoidCallback onTap, addOrder, onEdit;
  const OrderSection({
    super.key,
    required this.onTap,
    required this.addOrder,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(userOrderListProvider);
    final orderNotifier = ref.read(orderProvider.notifier);
    final deliveryIdNotifier = ref.read(deliveryIdProvider.notifier);
    final deliveries = ref.watch(deliveryListProvider);
    final availableDeliveries = deliveries.maybeWhen<List<Delivery>>(
      data: (data) => data
          .where((element) => element.status == DeliveryStatus.available)
          .toList(),
      orElse: () => [],
    );

    return Column(
      children: [
        const AlignLeftText(
          AMAPTextConstants.orders,
          padding: EdgeInsets.symmetric(horizontal: 30),
          color: AMAPColorConstants.textDark,
        ),
        const SizedBox(height: 10),
        HorizontalListView(
          height: 196,
          children: [
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                final e = Order.empty();
                deliveryIdNotifier.setId(e.deliveryId);
                orderNotifier.setOrder(e);
                addOrder();
              },
              child: const CardLayout(
                width: 100,
                height: 150,
                colors: [
                  AMAPColorConstants.lightGradient1,
                  AMAPColorConstants.greenGradient1,
                ],
                child: Center(
                  child: HeroIcon(
                    HeroIcons.plus,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
            AsyncChild(
              value: orders,
              builder: (context, data) {
                data.sort((a, b) => a.deliveryDate.compareTo(b.deliveryDate));
                return Row(
                  children: data.map((e) {
                    final canEdit = availableDeliveries.any(
                      (element) => element.id == e.deliveryId,
                    );
                    return OrderUI(
                      order: e,
                      onTap: onTap,
                      onEdit: () {
                        deliveryIdNotifier.setId(e.deliveryId);
                        orderNotifier.setOrder(e);
                        onEdit();
                      },
                      showButton: canEdit,
                    );
                  }).toList(),
                );
              },
              loaderColor: AMAPColorConstants.greenGradient2,
            ),
            const SizedBox(width: 25),
          ],
        ),
      ],
    );
  }
}
