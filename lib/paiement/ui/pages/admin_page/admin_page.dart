import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/stores_list_provider.dart';
import 'package:myecl/paiement/ui/pages/admin_page/add_store_card.dart';
import 'package:myecl/paiement/ui/pages/admin_page/admin_store_card.dart';
import 'package:myecl/paiement/ui/paiement.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeList = ref.watch(storeListProvider);
    return PaymentTemplate(
      child: Refresher(
        onRefresh: () async {},
        child: Column(
          children: [
            const SizedBox(height: 10),
            const AlignLeftText(
              "Gestion des associations",
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              padding: EdgeInsets.only(left: 30),
            ),
            const SizedBox(height: 10),
            const AddStoreCard(),
            AsyncChild(
              value: storeList,
              builder: (context, stores) => Column(
                children: stores
                    .map((store) => AdminStoreCard(store: store))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
