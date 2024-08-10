import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/purchases/providers/purchase_list_provider.dart';
import 'package:myecl/purchases/providers/purchase_provider.dart';
import 'package:myecl/purchases/router.dart';
import 'package:myecl/purchases/tools/constants.dart';
import 'package:myecl/purchases/ui/pages/history_page/purchase_card.dart';
import 'package:myecl/purchases/ui/purchases.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class HistoryPage extends HookConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchasesList = ref.watch(purchaseListProvider);
    final purchasesListNotifier = ref.watch(purchaseListProvider.notifier);
    final purchaseNotifier = ref.watch(purchaseProvider.notifier);

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
            for (int year in years) {
              children.add(
                ExpansionTile(
                  title: Text(year.toString()),
                  children: purchases.map((purchase) {
                    if (purchase.purchasedOn.year == year) {
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
                  }).toList(),
                ),
              );
            }
            if (children.isEmpty) {
              children.add(
                const Center(
                  child: Text(PurchasesTextConstants.noPurchases),
                ),
              );
            }
            return Column(
              children: children,
            );
          },
          errorBuilder: (error, stack) => const Center(
            child: Text(PurchasesTextConstants.purchasesError),
          ),
        ),
      ),
    );
  }
}
