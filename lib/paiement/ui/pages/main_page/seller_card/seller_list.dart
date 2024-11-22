import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/store.dart';
import 'package:myecl/paiement/providers/is_payment_admin.dart';
import 'package:myecl/paiement/providers/my_stores_provider.dart';
import 'package:myecl/paiement/ui/pages/main_page/seller_card/store_admin_card.dart';
import 'package:myecl/paiement/ui/pages/main_page/seller_card/store_divider.dart';
import 'package:myecl/paiement/ui/pages/main_page/seller_card/store_seller_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class SellerList extends ConsumerWidget {
  const SellerList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stores = ref.watch(myStoresProvider);
    final isAdmin = ref.watch(isPaymentAdmin);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Mes stores",
            style: TextStyle(
              color: Color.fromARGB(255, 0, 29, 29),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        AsyncChild(
          value: stores,
          builder: (context, stores) {
            final Map<String, List<Store>> sortedByMembership = {};
            for (var store in stores) {
              final membership = store.membership;
              if (sortedByMembership[membership.name] == null) {
                sortedByMembership[membership.name] = [];
              }
              sortedByMembership[membership.name]!.add(store);
            }
            return Column(
              children: [
                if (isAdmin) ...[
                  const StoreDivider(
                    name: "Admin",
                  ),
                  const StoreAdminCard()
                ],
                ...sortedByMembership.map((membership, stores) {
                  final List<Store> alphabeticallyOrderedStores = stores
                    ..sort((a, b) => a.name.compareTo(b.name));
                  return MapEntry(
                    membership,
                    Column(
                      children: [
                        StoreDivider(
                          name: membership,
                        ),
                        for (var store in alphabeticallyOrderedStores)
                          StoreSellerCard(
                            store: store,
                          ),
                      ],
                    ),
                  );
                }).values,
              ],
            );
          },
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
