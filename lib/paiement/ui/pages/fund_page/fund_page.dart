import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/providers/fund_amount_provider.dart';
import 'package:titan/paiement/providers/my_wallet_provider.dart';
import 'package:titan/paiement/providers/tos_provider.dart';
import 'package:titan/paiement/ui/components/digit_fade_in_animation.dart';
import 'package:titan/paiement/ui/components/keyboard.dart';
import 'package:titan/paiement/ui/pages/fund_page/confirm_button.dart';
import 'package:titan/tools/providers/locale_notifier.dart';

class FundPage extends ConsumerWidget {
  const FundPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final fundAmount = ref.watch(fundAmountProvider);
    final fundAmountNotifier = ref.watch(fundAmountProvider.notifier);
    final myWallet = ref.watch(myWalletProvider);
    final tos = ref.watch(tosProvider);
    final maxBalanceAmount = tos.maybeWhen(
      orElse: () => 0,
      data: (tos) => tos.maxWalletBalance / 100,
    );
    final currentAmount = myWallet.maybeWhen(
      orElse: () => 0,
      data: (wallet) => wallet.balance / 100,
    );
    final formatter = NumberFormat.currency(locale: locale.toString(), symbol: "€");

    final amountToAdd = double.tryParse(fundAmount.replaceAll(",", ".")) ?? 0;

    final isValid = amountToAdd + currentAmount <= maxBalanceAmount;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff017f80), Color.fromARGB(255, 9, 103, 103)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.paiementTopUp,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${AppLocalizations.of(context)!.paiementBalanceAfterTopUp} ${formatter.format(amountToAdd + currentAmount)} (max: ${formatter.format(maxBalanceAmount)})',
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...fundAmount.characters.map((e) {
                      return DigitFadeInAnimation(
                        child: Text(
                          e,
                          style: TextStyle(
                            color: isValid
                                ? Colors.white
                                : const Color.fromARGB(255, 91, 6, 0),
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                    if (fundAmount.isNotEmpty)
                      Text(
                        ' €',
                        style: TextStyle(
                          color: isValid
                              ? Colors.white
                              : const Color.fromARGB(255, 91, 6, 0),
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            NumericKeyboard(
              onKeyboardTap: (e) {
                if (e != "," || !fundAmount.contains(",")) {
                  if (fundAmount.contains(",") &&
                      fundAmount.substring(fundAmount.indexOf(",")).length <
                          3) {
                    fundAmountNotifier.setFundAmount(fundAmount + e.toString());
                  } else if (!fundAmount.contains(",")) {
                    if (e == "," && fundAmount.isEmpty) {
                      fundAmountNotifier.setFundAmount("0,");
                    } else {
                      fundAmountNotifier.setFundAmount(
                        fundAmount + e.toString(),
                      );
                    }
                  }
                }
              },
              rightButtonFn: () {
                if (fundAmount == "0,") {
                  fundAmountNotifier.setFundAmount("");
                } else if (fundAmount.isNotEmpty) {
                  fundAmountNotifier.setFundAmount(
                    fundAmount.substring(0, fundAmount.length - 1),
                  );
                }
              },
            ),
            const Expanded(child: Center(child: ConfirmFundButton())),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
