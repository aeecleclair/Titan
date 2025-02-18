import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/user_store.dart';
import 'package:myecl/paiement/providers/is_payment_admin.dart';
import 'package:myecl/paiement/providers/my_stores_provider.dart';
import 'package:myecl/paiement/ui/pages/main_page/seller_card/store_admin_card.dart';
import 'package:myecl/paiement/ui/pages/main_page/seller_card/store_divider.dart';
import 'package:myecl/paiement/ui/pages/main_page/seller_card/store_seller_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class StoreList extends ConsumerWidget {
  const StoreList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stores = ref.watch(myStoresProvider);
    final isAdmin = ref.watch(isPaymentAdminProvider);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Associations",
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
            final Map<String, List<UserStore>> sortedByMembership = {};
            for (var store in stores) {
              final membership = store.structure.name;
              if (sortedByMembership[membership] == null) {
                sortedByMembership[membership] = [];
              }
              sortedByMembership[membership]!.add(store);
            }
            return Column(
              children: [
                if (isAdmin) ...[
                  const StoreDivider(
                    name: "Administrateur",
                  ),
                  const StoreAdminCard()
                ],
                ...sortedByMembership.map((membership, stores) {
                  final List<UserStore> alphabeticallyOrderedStores = stores
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
