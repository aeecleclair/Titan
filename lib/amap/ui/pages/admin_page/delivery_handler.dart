import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/class/delivery.dart';
import 'package:titan/amap/providers/delivery_id_provider.dart';
import 'package:titan/amap/providers/delivery_list_provider.dart';
import 'package:titan/amap/providers/selected_list_provider.dart';
import 'package:titan/amap/router.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/amap/ui/pages/admin_page/delivery_ui.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:qlevar_router/qlevar_router.dart';

class DeliveryHandler extends HookConsumerWidget {
  const DeliveryHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveries = ref.watch(deliveryListProvider);
    final deliveryIdNotifier = ref.watch(deliveryIdProvider.notifier);
    final selectedNotifier = ref.watch(selectedListProvider.notifier);
    return Column(
      children: [
        const AlignLeftText(
          AMAPTextConstants.deliveries,
          padding: EdgeInsets.symmetric(horizontal: 30),
          color: AMAPColorConstants.textDark,
        ),
        const SizedBox(height: 10),
        HorizontalListView(
          height: 200,
          children: [
            const SizedBox(width: 15, height: 195),
            GestureDetector(
              onTap: () {
                selectedNotifier.clear();
                deliveryIdNotifier.setId(Delivery.empty().id);
                QR.to(
                  AmapRouter.root +
                      AmapRouter.admin +
                      AmapRouter.addEditDelivery,
                );
              },
              child: CardLayout(
                height: 160,
                width: 100,
                shadowColor: AMAPColorConstants.textDark.withValues(alpha: 0.2),
                child: const Center(
                  child: HeroIcon(
                    HeroIcons.plus,
                    color: AMAPColorConstants.textDark,
                    size: 50,
                  ),
                ),
              ),
            ),
            AsyncChild(
              value: deliveries,
              builder: (context, data) {
                data.sort((a, b) => a.deliveryDate.compareTo(b.deliveryDate));
                return Row(
                  children: data.map((e) => DeliveryUi(delivery: e)).toList(),
                );
              },
              loaderColor: AMAPColorConstants.greenGradient2,
            ),
            const SizedBox(width: 5),
          ],
        ),
      ],
    );
  }
}
