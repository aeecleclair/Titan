import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/paiement/providers/barcode_provider.dart';
import 'package:myecl/paiement/providers/ongoing_transaction.dart';
import 'package:myecl/paiement/providers/transaction_provider.dart';
import 'package:myecl/paiement/ui/pages/scan_page/cancel_button.dart';
import 'package:myecl/paiement/ui/pages/scan_page/scanner.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/widgets/custom_dialog_box.dart';

class ScanPage extends HookConsumerWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barcode = ref.watch(barcodeProvider);
    final barcodeNotifier = ref.watch(barcodeProvider.notifier);
    final formatter = NumberFormat("#,##0.00", "fr_FR");
    final transactionNotifier = ref.watch(transactionProvider.notifier);
    final ongoingTransaction = ref.watch(ongoingTransactionProvider);
    final ongoingTransactionNotifier =
        ref.watch(ongoingTransactionProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final opacity = useAnimationController(
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    return Stack(
      children: [
        const Scanner(),
        Positioned(
          top: 20,
          right: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const HeroIcon(
              HeroIcons.xMark,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  barcode != null
                      ? Row(
                          children: [
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 50,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    Colors.grey.shade200.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    "Montant",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    '${formatter.format(barcode.total / 100)} €',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        )
                      : SizedBox(
                          height: 100,
                          child: Center(
                            child: AnimatedBuilder(
                              animation: opacity,
                              builder: (context, child) {
                                return Opacity(
                                  opacity: opacity.value,
                                  child: const Text(
                                    'Scanner un code',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
            // Qr code scanning zone
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.8,
            ),
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  AsyncChild(
                    value: ongoingTransaction,
                    builder: (context, transaction) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                                child: const Text(
                                  'Suivant',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              onTap: () {
                                barcodeNotifier.clearBarcode();
                                ongoingTransactionNotifier
                                    .clearOngoingTransaction();
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          CancelButton(
                            onCancel: (bool isInTime) async {
                              if (isInTime) {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                      title: "Annuler la transaction",
                                      descriptions:
                                          "Voulez-vous vraiment annuler la transaction de ${formatter.format(transaction.total / 100)} € ?",
                                      onYes: () async {
                                        tokenExpireWrapper(ref, () async {
                                          final value =
                                              await transactionNotifier
                                                  .cancelTransaction(
                                            transaction.id,
                                          );
                                          value.when(
                                            data: (value) {
                                              if (value) {
                                                displayToastWithContext(
                                                  TypeMsg.msg,
                                                  "Transaction annulée",
                                                );
                                              } else {
                                                displayToastWithContext(
                                                  TypeMsg.error,
                                                  "Erreur lors de l'annulation",
                                                );
                                              }
                                            },
                                            error: (error, stack) {
                                              displayToastWithContext(
                                                TypeMsg.error,
                                                error.toString(),
                                              );
                                            },
                                            loading: () {},
                                          );
                                        });
                                      },
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
