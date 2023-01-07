import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/main_page/delivery_ui.dart';

class DeliverySection extends HookConsumerWidget {
  final bool showSelected;
  const DeliverySection({super.key, this.showSelected = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryIdNotifier = ref.watch(deliveryIdProvider.notifier);
    final deliveries = ref.watch(deliveryListProvider);
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
              if (data.isEmpty) {
                return const Center(
                  child: Text('Aucune livraison prévue'),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    for (var i = 0; i < data.length; i++)
                      if (!data[i].locked)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: DeliveryUi(
                            delivery: data[i],
                            onTap: () {
                              if (showSelected) {
                                deliveryIdNotifier.setId(data[i].id);
                              }
                            },
                            showSelected: showSelected,
                          ),
                        ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text(error.toString()),
          ),
        ),
      ],
    );
  }
}
