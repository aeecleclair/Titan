import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/class/delivery.dart';
import 'package:titan/amap/providers/delivery_id_provider.dart';
import 'package:titan/amap/providers/delivery_list_provider.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/amap/ui/pages/main_page/delivery_ui.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/async_child.dart';

class DeliverySection extends HookConsumerWidget {
  final bool showSelected;
  final bool editable;
  const DeliverySection({
    super.key,
    this.showSelected = true,
    this.editable = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryIdNotifier = ref.read(deliveryIdProvider.notifier);
    final deliveries = ref.watch(deliveryListProvider);
    final availableDeliveries = deliveries.maybeWhen<List<Delivery>>(
      data: (data) => data
          .where((element) => element.status == DeliveryStatus.available)
          .toList(),
      orElse: () => [],
    )..sort((a, b) => a.deliveryDate.compareTo(b.deliveryDate));
    return Column(
      children: [
        AlignLeftText(
          AMAPTextConstants.deliveries,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          color: showSelected ? Colors.white : AMAPColorConstants.textDark,
        ),
        AsyncChild(
          value: deliveries,
          builder: (context, data) {
            if (availableDeliveries.isEmpty) {
              return const Center(
                child: Text(AMAPTextConstants.notPlannedDelivery),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  for (var i = 0; i < availableDeliveries.length; i++)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: DeliveryUi(
                        delivery: availableDeliveries[i],
                        onTap: () {
                          {
                            if (editable && showSelected) {
                              deliveryIdNotifier.setId(
                                availableDeliveries[i].id,
                              );
                            }
                          }
                        },
                        showSelected: showSelected,
                      ),
                    ),
                ],
              ),
            );
          },
          loaderColor: AMAPColorConstants.greenGradient2,
        ),
      ],
    );
  }
}
