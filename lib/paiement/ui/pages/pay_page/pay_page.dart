import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/paiement/providers/my_wallet_provider.dart';
import 'package:titan/paiement/providers/pay_amount_provider.dart';
import 'package:titan/paiement/ui/pages/pay_page/confirm_button.dart';
import 'package:titan/paiement/ui/components/digit_fade_in_animation.dart';
import 'package:titan/paiement/ui/components/keyboard.dart';

class PayPage extends ConsumerWidget {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payAmount = ref.watch(payAmountProvider);
    final payAmountNotifier = ref.watch(payAmountProvider.notifier);
    final myWallet = ref.watch(myWalletProvider);
    final currentAmount = myWallet.maybeWhen(
      orElse: () => 0,
      data: (wallet) => wallet.balance / 100,
    );
    final formatter = NumberFormat("#,##0.00", "fr_FR");

    final amountToSub = double.tryParse(payAmount.replaceAll(",", ".")) ?? 0;

    final isValid = currentAmount - amountToSub >= 0;
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
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Paiement',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Solde après paiement : ${formatter.format(currentAmount - amountToSub)} €',
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...payAmount.characters.map((e) {
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
                    if (payAmount.isNotEmpty)
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
                if (e != "," || !payAmount.contains(",")) {
                  if (payAmount.contains(",") &&
                      payAmount.substring(payAmount.indexOf(",")).length < 3) {
                    payAmountNotifier.setPayAmount(payAmount + e.toString());
                  } else if (!payAmount.contains(",")) {
                    if (e == "," && payAmount.isEmpty) {
                      payAmountNotifier.setPayAmount("0,");
                    } else {
                      payAmountNotifier.setPayAmount(payAmount + e.toString());
                    }
                  }
                }
              },
              rightButtonFn: () {
                if (payAmount == "0,") {
                  payAmountNotifier.setPayAmount("");
                } else if (payAmount.isNotEmpty) {
                  payAmountNotifier.setPayAmount(
                    payAmount.substring(0, payAmount.length - 1),
                  );
                }
              },
            ),
            const Expanded(child: Center(child: ConfirmButton())),
          ],
        ),
      ),
    );
  }
}
