import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/fund_amount_provider.dart';
import 'package:myecl/paiement/ui/components/digit_fade_in_animation.dart';
import 'package:myecl/paiement/ui/components/keyboard.dart';
import 'package:myecl/paiement/ui/pages/fund_page/confirm_button.dart';

class FundPage extends ConsumerWidget {
  const FundPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundAmount = ref.watch(fundAmountProvider);
    final fundAmountNotifier = ref.watch(fundAmountProvider.notifier);
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
                    ...fundAmount.characters.map((e) {
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
                    if (fundAmount.isNotEmpty)
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
                if (e != "," || !fundAmount.contains(",")) {
                  if (fundAmount.contains(",") &&
                      fundAmount.substring(fundAmount.indexOf(",")).length < 3) {
                    fundAmountNotifier.setFundAmount(fundAmount + e.toString());
                  } else if (!fundAmount.contains(",")) {
                    fundAmountNotifier.setFundAmount(fundAmount + e.toString());
                  }
                }
              },
              rightButtonFn: () {
                fundAmountNotifier
                    .setFundAmount(fundAmount.substring(0, fundAmount.length - 1));
              },
            ),
            const Expanded(child: Center(child: ConfirmFundButton())),
          ],
        ),
      ),
    );
  }
}
