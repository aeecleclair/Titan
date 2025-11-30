import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/mypayment/class/user_store.dart';
import 'package:titan/mypayment/providers/is_payment_admin.dart';
import 'package:titan/mypayment/providers/my_stores_provider.dart';
import 'package:titan/mypayment/ui/pages/main_page/seller_card/admin_invoice_card.dart';
import 'package:titan/mypayment/ui/pages/main_page/seller_card/store_divider.dart';
import 'package:titan/mypayment/ui/pages/main_page/seller_card/store_seller_card.dart';
import 'package:titan/mypayment/ui/pages/main_page/seller_card/structure_admin_card.dart';
import 'package:titan/tools/ui/builders/async_child.dart';

class StoreList extends ConsumerWidget {
  final double maxHeight;
  const StoreList({required this.maxHeight, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stores = ref.watch(myStoresProvider);
    final isStructureAdmin = ref.watch(isStructureAdminProvider);
    final isBankAccountHolder = ref.watch(isBankAccountHolderProvider);
    return SizedBox(
      height: maxHeight,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
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
            const SizedBox(height: 15),
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
                    if (isStructureAdmin) ...[
                      if (isBankAccountHolder) const InvoiceAdminCard(),
                      const StoreDivider(name: "Administrateur"),
                      const StructureAdminCard(),
                    ],
                    ...sortedByMembership.map((membership, stores) {
                      final List<UserStore> alphabeticallyOrderedStores = stores
                        ..sort((a, b) => a.name.compareTo(b.name));
                      return MapEntry(
                        membership,
                        Column(
                          children: [
                            StoreDivider(name: membership),
                            for (var store in alphabeticallyOrderedStores)
                              StoreSellerCard(store: store),
                          ],
                        ),
                      );
                    }).values,
                  ],
                );
              },
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
