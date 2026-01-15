import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/purchases/providers/purchase_list_provider.dart';
import 'package:titan/purchases/providers/purchase_provider.dart';
import 'package:titan/purchases/router.dart';
import 'package:titan/purchases/tools/constants.dart';
import 'package:titan/purchases/ui/pages/history_page/purchase_card.dart';
import 'package:titan/purchases/ui/purchases.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class HistoryPage extends HookConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchasesList = ref.watch(purchaseListProvider);
    final purchasesListNotifier = ref.watch(purchaseListProvider.notifier);
    final purchaseNotifier = ref.watch(purchaseProvider.notifier);

    final selectedYear = useState(DateTime.now().year);

    return PurchasesTemplate(
      child: Refresher(
        onRefresh: () async {
          await purchasesListNotifier.loadPurchases();
        },
        child: AsyncChild(
          value: purchasesList,
          builder: (context, purchases) {
            List<Widget> children = [];
            List<int> years = purchasesListNotifier.getPurchasesYears();
            children.addAll(
              purchases.map((purchase) {
                if (purchase.product.year == selectedYear.value) {
                  return PurchaseCard(
                    purchase: purchase,
                    onClicked: () {
                      purchaseNotifier.setPurchase(purchase);
                      QR.to(
                        PurchasesRouter.root +
                            PurchasesRouter.history +
                            PurchasesRouter.purchase,
                      );
                    },
                  );
                }
                return const SizedBox();
              }),
            );

            if (children.isEmpty) {
              children.add(
                const Center(child: Text(PurchasesTextConstants.noPurchases)),
              );
            }
            return Column(
              children: [
                const SizedBox(height: 30),
                HorizontalListView.builder(
                  items: years,
                  itemBuilder: (context, currentYear, index) {
                    final selected = selectedYear.value == currentYear;
                    return ItemChip(
                      onTap: () {
                        selectedYear.value = currentYear;
                      },
                      selected: selected,
                      child: Text(
                        currentYear.toString(),
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  height: 40,
                ),
                const SizedBox(height: 20),
                ...children,
              ],
            );
          },
          errorBuilder: (error, stack) =>
              const Center(child: Text(PurchasesTextConstants.purchasesError)),
        ),
      ),
    );
  }
}
