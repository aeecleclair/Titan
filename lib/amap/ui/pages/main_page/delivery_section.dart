import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/main_page/delivery_ui.dart';

class DeliverySection extends HookConsumerWidget {
  final bool showSelected;
  final bool editable;
  const DeliverySection({super.key, this.showSelected = true, this.editable = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryIdNotifier = ref.watch(deliveryIdProvider.notifier);
    final deliveries = ref.watch(deliveryListProvider);
    final orderableDeliveries = deliveries.when<List<Delivery>>(
        data: (data) => data
            .where((element) => element.status == DeliveryStatus.orderable)
            .toList(),
        loading: () => [],
        error: (_, __) => [])
      ..sort((a, b) => a.deliveryDate.compareTo(b.deliveryDate));
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Livraisons',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: showSelected
                      ? Colors.white
                      : AMAPColorConstants.textDark),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 560,
          child: deliveries.when(
            data: (data) {
              if (orderableDeliveries.isEmpty) {
                return const Center(
                  child: Text('Aucune livraison prévue'),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    for (var i = 0; i < orderableDeliveries.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: DeliveryUi(
                          delivery: orderableDeliveries[i],
                          onTap: () {
                            {if (editable && showSelected) {
                              deliveryIdNotifier
                                  .setId(orderableDeliveries[i].id);
                            }}
                          },
                          showSelected: showSelected,
                        ),
                      ),
                  ],
                ),
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
    );
  }
}
