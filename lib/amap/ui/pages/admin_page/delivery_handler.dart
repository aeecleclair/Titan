import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/selected_list_provider.dart';
import 'package:myecl/amap/router.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/admin_page/delivery_ui.dart';
import 'package:myecl/tools/ui/card_layout.dart';
import 'package:myecl/tools/ui/horizontal_list_view.dart';
import 'package:myecl/tools/ui/loader.dart';
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text(AMAPTextConstants.deliveries,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AMAPColorConstants.textDark)),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: HorizontalListView(
            child: Row(
              children: [
                const SizedBox(width: 15, height: 195),
                GestureDetector(
                    onTap: () {
                      selectedNotifier.clear();
                      deliveryIdNotifier.setId(Delivery.empty().id);
                      QR.to(AmapRouter.root +
                          AmapRouter.admin +
                          AmapRouter.addEditDelivery);
                    },
                    child: CardLayout(
                      height: 160,
                      width: 100,
                      shadowColor: AMAPColorConstants.textDark.withOpacity(0.2),
                      child: const Center(
                        child: HeroIcon(
                          HeroIcons.plus,
                          color: AMAPColorConstants.textDark,
                          size: 50,
                        ),
                      ),
                    )),
                deliveries.when(
                  data: (data) {
                    data.sort(
                        (a, b) => a.deliveryDate.compareTo(b.deliveryDate));
                    return Row(
                        children: data
                            .map((e) => DeliveryUi(
                                  delivery: e,
                                ))
                            .toList());
                  },
                  error: (Object e, StackTrace? s) =>
                      Text("${AMAPTextConstants.error}: ${e.toString()}"),
                  loading: () =>
                      const Loader(color: AMAPColorConstants.greenGradient2),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
        )
      ],
    );
  }
}
