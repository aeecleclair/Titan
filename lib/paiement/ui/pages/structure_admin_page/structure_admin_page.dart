import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/providers/selected_structure_provider.dart';
import 'package:titan/paiement/providers/stores_list_provider.dart';
import 'package:titan/paiement/ui/pages/structure_admin_page/add_store_card.dart';
import 'package:titan/paiement/ui/pages/structure_admin_page/admin_store_card.dart';
import 'package:titan/paiement/ui/paiement.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';

class StructureStoresPage extends ConsumerWidget {
  const StructureStoresPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeList = ref.watch(storeListProvider);
    final storeListNotifier = ref.read(storeListProvider.notifier);
    final structure = ref.watch(selectedStructureProvider);
    return PaymentTemplate(
      child: Refresher(
        controller: ScrollController(),
        onRefresh: () async {
          await storeListNotifier.getStores();
        },
        child: Column(
          children: [
            const SizedBox(height: 10),
            AlignLeftText(
              AppLocalizations.of(
                context,
              )!.paiementStructureManagement(structure.name),
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              padding: EdgeInsets.only(left: 30),
            ),
            const SizedBox(height: 10),
            const AddStoreCard(),
            AsyncChild(
              value: storeList,
              builder: (context, stores) {
                final storeFromStructures = stores.where(
                  (store) => store.structure.id == structure.id,
                );
                return Column(
                  children: storeFromStructures
                      .map((store) => AdminStoreCard(store: store))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
