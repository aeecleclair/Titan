import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/pay_amount_provider.dart';
import 'package:myecl/paiement/ui/pages/pay_page/confirm_button.dart';
import 'package:myecl/paiement/ui/pages/pay_page/digit_fade_in_animation.dart';
import 'package:myecl/paiement/ui/pages/pay_page/keyboard.dart';

class PayPage extends ConsumerWidget {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payAmount = ref.watch(payAmountProvider);
    final payAmountNotifier = ref.watch(payAmountProvider.notifier);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff017f80),
              Color.fromARGB(255, 9, 103, 103),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...payAmount.characters.map((e) {
                      return DigitFadeInAnimation(
                        child: Text(
                          e,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                    if (payAmount.isNotEmpty)
                      const Text(
                        ' €',
                        style: TextStyle(
                          color: Colors.white,
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
                    payAmountNotifier.setPayAmount(payAmount + e.toString());
                  }
                }
              },
              rightButtonFn: () {
                payAmountNotifier
                    .setPayAmount(payAmount.substring(0, payAmount.length - 1));
              },
            ),
            const Expanded(child: Center(child: ConfirmButton())),
          ],
        ),
      ),
    );
  }
}
