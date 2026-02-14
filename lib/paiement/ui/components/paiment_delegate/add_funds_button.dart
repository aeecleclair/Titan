import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/providers/fund_amount_provider.dart';
import 'package:titan/paiement/ui/pages/fund_page/fund_page.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';

class AddFundsButton extends ConsumerWidget {
  const AddFundsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundAmountNotifier = ref.watch(fundAmountProvider.notifier);
    final localizeWithContext = AppLocalizations.of(context)!;

    void showFundModal() async {
      Navigator.of(context).pop(); // Close current modal
      await showCustomBottomModal(
        context: context,
        modal: const FundPage(),
        ref: ref,
        onCloseCallback: () => fundAmountNotifier.setFundAmount(""),
      );
    }

    return GestureDetector(
      onTap: showFundModal,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff017f80), Color.fromARGB(255, 4, 84, 84)],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_card, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              localizeWithContext.paiementAddFunds,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
