import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/providers/selected_store_provider.dart';
import 'package:myecl/paiement/providers/store_admin_list_provider.dart';
import 'package:myecl/paiement/ui/pages/store_admin_page/seller_right_card.dart';
import 'package:myecl/paiement/ui/paiement.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class StoreAdminPage extends ConsumerWidget {
  const StoreAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(selectedStoreProvider);
    final storeSellers = ref.watch(storeAdminListProvider);
    return PaymentTemplate(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Les vendeurs de ${store.name}",
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 29, 29),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          AsyncChild(
            value: storeSellers,
            builder: (context, storeSellers) {
              return Column(
                children: [
                  ...storeSellers.map(
                    (storeSeller) {
                      return SellerRightCard(storeSeller: storeSeller);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
