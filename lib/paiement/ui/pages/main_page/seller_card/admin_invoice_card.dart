import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/providers/invoice_list_provider.dart';
import 'package:titan/paiement/router.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class InvoiceAdminCard extends ConsumerWidget {
  const InvoiceAdminCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoicesNotifier = ref.watch(invoiceListProvider.notifier);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            CircleAvatar(
              radius: 27,
              backgroundColor: Color.fromARGB(255, 6, 75, 75),
              child: HeroIcon(
                HeroIcons.documentCurrencyEuro,
                color: ColorConstants.background,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: AutoSizeText(
                AppLocalizations.of(context)!.paiementBillingSpace,
                maxLines: 1,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 29, 29),
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(width: 10),
            HeroIcon(
              HeroIcons.arrowRight,
              color: Color.fromARGB(255, 0, 29, 29),
              size: 25,
            ),
          ],
        ),
      ),
      onTap: () {
        tokenExpireWrapper(ref, () => invoicesNotifier.getInvoices());
        QR.to(PaymentRouter.root + PaymentRouter.invoicesAdmin);
      },
    );
  }
}
