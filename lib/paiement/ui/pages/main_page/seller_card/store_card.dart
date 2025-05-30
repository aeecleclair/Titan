import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/barcode_provider.dart';
import 'package:myecl/paiement/providers/ongoing_transaction.dart';
import 'package:myecl/paiement/providers/selected_store_provider.dart';
import 'package:myecl/paiement/router.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_button.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_template.dart';
import 'package:myecl/paiement/ui/pages/scan_page/scan_page.dart';
import 'package:qlevar_router/qlevar_router.dart';

class StoreCard extends HookConsumerWidget {
  final Function? toggle;
  const StoreCard({super.key, required this.toggle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(selectedStoreProvider);
    final ongoingTransactionNotifier = ref.read(
      ongoingTransactionProvider.notifier,
    );
    final barcodeNotifier = ref.read(barcodeProvider.notifier);
    final buttonGradient = [
      const Color.fromARGB(255, 6, 75, 75),
      const Color.fromARGB(255, 0, 29, 29),
    ];

    return MainCardTemplate(
      toggle: toggle,
      colors: const [
        Color.fromARGB(255, 3, 58, 58),
        Color.fromARGB(255, 0, 68, 68),
        Color.fromARGB(255, 0, 29, 29),
      ],
      title: 'Solde associatif',
      actionButtons: [
        if (store.canBank)
          MainCardButton(
            colors: buttonGradient,
            icon: HeroIcons.viewfinderCircle,
            title: "Scanner",
            onPressed: () async {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                scrollControlDisabledMaxHeightRatio:
                    (1 - 80 / MediaQuery.of(context).size.height),
                builder: (context) => const ScanPage(),
              ).then((_) {
                ongoingTransactionNotifier.clearOngoingTransaction();
                barcodeNotifier.clearBarcode();
              });
            },
          ),
        if (store.canManageSellers)
          MainCardButton(
            colors: buttonGradient,
            icon: HeroIcons.userGroup,
            onPressed: () async {
              // storeAdminListNotifier.getStoreAdminList(store.id);
              QR.to(PaymentRouter.root + PaymentRouter.storeAdmin);
            },
            title: 'Gestion',
          ),
        if (store.canSeeHistory)
          MainCardButton(
            colors: buttonGradient,
            icon: HeroIcons.wallet,
            onPressed: () async {
              QR.to(PaymentRouter.root + PaymentRouter.storeStats);
            },
            title: 'Historique',
          ),
      ],
      child: SizedBox.expand(
        child: AutoSizeText(
          store.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 50),
        ),
      ),
    );
  }
}
