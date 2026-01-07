import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/providers/barcode_provider.dart';
import 'package:titan/mypayment/providers/ongoing_transaction.dart';
import 'package:titan/mypayment/providers/selected_store_provider.dart';
import 'package:titan/mypayment/router.dart';
import 'package:titan/mypayment/ui/pages/main_page/main_card_button.dart';
import 'package:titan/mypayment/ui/pages/main_page/main_card_template.dart';
import 'package:titan/mypayment/ui/pages/scan_page/scan_page.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class StoreCard extends HookConsumerWidget {
  final Function? toggle;
  const StoreCard({super.key, required this.toggle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(userProvider);
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
                enableDrag: false,
                backgroundColor: Colors.transparent,
                scrollControlDisabledMaxHeightRatio:
                    (1 - 80 / MediaQuery.of(context).size.height),
                builder: (context) => ScanPage(),
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
        if (store.structure.managerUser.id == me.id)
          MainCardButton(
            colors: buttonGradient,
            icon: HeroIcons.users,
            onPressed: () async {
              QR.to(PaymentRouter.root + PaymentRouter.transferStructure);
            },
            title: 'Passation',
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
