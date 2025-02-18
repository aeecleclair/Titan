import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/pay_amount_provider.dart';
import 'package:myecl/paiement/ui/pages/pay_page/keyboard.dart';
// import 'package:myecl/paiement/ui/pages/pay_page/qrcode.dart';

class PayPage extends ConsumerWidget {
  const PayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payAmount = ref.watch(payAmountProvider);
    final payAmountNotifier = ref.watch(payAmountProvider.notifier);
    return Expanded(
      child: Column(
        children: [
          Expanded(
              child: Center(
            child: Text(
              '$payAmount ${payAmount.isNotEmpty ? '€' : ''}',
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
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
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
