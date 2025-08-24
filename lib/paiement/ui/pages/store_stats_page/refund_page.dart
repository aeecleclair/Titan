import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/class/history.dart';
import 'package:titan/paiement/class/refund.dart';
import 'package:titan/paiement/providers/refund_amount_provider.dart';
import 'package:titan/paiement/providers/selected_store_history.dart';
import 'package:titan/paiement/providers/transaction_provider.dart';
import 'package:titan/paiement/ui/components/digit_fade_in_animation.dart';
import 'package:titan/paiement/ui/components/keyboard.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/locale_notifier.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';

class ReFundPage extends ConsumerWidget {
  final History history;
  const ReFundPage({super.key, required this.history});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final refundAmount = ref.watch(refundAmountProvider);
    final refundAmountNotifier = ref.watch(refundAmountProvider.notifier);
    final transactionNotifier = ref.watch(transactionProvider.notifier);
    final formatter = NumberFormat.currency(locale: locale.toString(), symbol: "€");

    final isValid =
        double.tryParse(refundAmount.replaceAll(",", ".")) != null &&
        double.parse(refundAmount.replaceAll(",", ".")) <= history.total / 100;

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

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
              AppLocalizations.of(context)!.paiementRefund,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${history.otherWalletName} (max: ${formatter.format(history.total / 100)})',
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...refundAmount.characters.map((e) {
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
                    if (refundAmount.isNotEmpty)
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
                if (e != "," || !refundAmount.contains(",")) {
                  if (refundAmount.contains(",") &&
                      refundAmount.substring(refundAmount.indexOf(",")).length <
                          3) {
                    refundAmountNotifier.setRefundAmount(
                      refundAmount + e.toString(),
                    );
                  } else if (!refundAmount.contains(",")) {
                    if (e == "," && refundAmount.isEmpty) {
                      refundAmountNotifier.setRefundAmount("0,");
                    } else {
                      refundAmountNotifier.setRefundAmount(
                        refundAmount + e.toString(),
                      );
                    }
                  }
                }
              },
              rightButtonFn: () {
                if (refundAmount == "0,") {
                  refundAmountNotifier.setRefundAmount("");
                } else if (refundAmount.isNotEmpty) {
                  refundAmountNotifier.setRefundAmount(
                    refundAmount.substring(0, refundAmount.length - 1),
                  );
                }
              },
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: WaitingButton(
                    onTap: () async {
                      final value = await transactionNotifier.refundTransaction(
                        history.id,
                        Refund(
                          completeRefund: false,
                          amount:
                              (double.parse(refundAmount.replaceAll(",", ".")) *
                                  100) ~/
                              1,
                        ),
                      );
                      value.when(
                        data: (value) {
                          displayToastWithContext(
                            TypeMsg.msg,
                            AppLocalizations.of(
                              context,
                            )!.paiementDoneTransaction,
                          );
                          ref.invalidate(sellerHistoryProvider);
                          Navigator.of(context).pop();
                        },
                        loading: () {},
                        error: (error, _) {
                          displayToastWithContext(
                            TypeMsg.error,
                            error.toString(),
                          );
                        },
                      );
                    },
                    waitingColor: Colors.black,
                    builder: (child) => AddEditButtonLayout(
                      colors: [Colors.grey.shade100, Colors.grey.shade200],
                      child: child,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.paiementRefundAction,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
