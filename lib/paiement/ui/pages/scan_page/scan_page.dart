import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/providers/barcode_provider.dart';
import 'package:titan/paiement/providers/bypass_provider.dart';
import 'package:titan/paiement/providers/ongoing_transaction.dart';
import 'package:titan/paiement/providers/selected_store_provider.dart';
import 'package:titan/paiement/providers/transaction_provider.dart';
import 'package:titan/paiement/ui/pages/scan_page/cancel_button.dart';
import 'package:titan/paiement/ui/pages/scan_page/scanner.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/ui/widgets/loader.dart';

class ScanPage extends HookConsumerWidget {
  ScanPage({super.key});

  final GlobalKey<ScannerState> scannerKey = GlobalKey<ScannerState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bypass = ref.watch(bypassProvider);
    final store = ref.watch(selectedStoreProvider);
    final bypassNotifier = ref.watch(bypassProvider.notifier);
    final barcode = ref.watch(barcodeProvider);
    final barcodeNotifier = ref.watch(barcodeProvider.notifier);
    final formatter = NumberFormat("#,##0.00", "fr_FR");
    final transactionNotifier = ref.watch(transactionProvider.notifier);
    final ongoingTransaction = ref.watch(ongoingTransactionProvider);
    final ongoingTransactionNotifier = ref.watch(
      ongoingTransactionProvider.notifier,
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final opacity = useAnimationController(duration: const Duration(seconds: 1))
      ..repeat(reverse: true);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Stack(
        children: [
          Scanner(key: scannerKey),
          store.structure.associationMembership.id != ''
              ? Positioned(
                  top: 10,
                  left: 20,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Row(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            bypassNotifier.setBypass(!bypass);
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                value: !bypass,
                                checkColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                activeColor: Colors.white,
                                onChanged: (value) {
                                  bypassNotifier.setBypass(!bypass);
                                },
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "${AppLocalizations.of(context)!.paiementLimitedTo} ${store.structure.associationMembership.name}",
                                style: TextStyle(
                                  color: bypass
                                      ? Colors.white.withValues(alpha: 0.5)
                                      : Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const HeroIcon(
                            HeroIcons.xMark,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Positioned(
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
                    const SizedBox(height: 60),
                    barcode != null
                        ? Row(
                            children: [
                              const Spacer(),
                              AsyncChild(
                                value: ongoingTransaction,
                                builder: (context, transaction) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 50,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: const RadialGradient(
                                        colors: [
                                          Color(0xff79a400),
                                          Color(0xff387200),
                                        ],
                                        center: Alignment.topLeft,
                                        radius: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.paiementAmount,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${formatter.format(barcode.tot / 100)} €',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                errorBuilder: (error, stack) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 50,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: const RadialGradient(
                                        colors: [
                                          Color(0xffa40000),
                                          Color(0xff720000),
                                        ],
                                        center: Alignment.topLeft,
                                        radius: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      (error as AppException).message,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                                loadingBuilder: (context) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 50,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                      colors: [
                                        Colors.grey.shade200,
                                        Colors.grey.shade300,
                                      ],
                                      center: Alignment.topLeft,
                                      radius: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Loader(),
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
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.paiementScanCode,
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
              SizedBox(height: MediaQuery.of(context).size.width * 0.8),
              Expanded(
                child: Column(
                  children: [
                    const Spacer(),
                    AsyncChild(
                      value: ongoingTransaction,
                      errorBuilder: (errorContext, child) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: GestureDetector(
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.paiementNext,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          onTap: () {
                            scannerKey.currentState?.resetScanner();
                            barcodeNotifier.clearBarcode();
                            ongoingTransactionNotifier
                                .clearOngoingTransaction();
                          },
                        ),
                      ),
                      builder: (context, transaction) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            CancelButton(
                              onCancel: (bool isInTime) async {
                                if (isInTime) {
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialogBox(
                                        title: AppLocalizations.of(
                                          context,
                                        )!.paiementCancelTransaction,
                                        descriptions:
                                            "${AppLocalizations.of(context)!.paiementTransactionCancelledDescription} ${formatter.format(transaction.total / 100)} € ?",
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
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.paiementTransactionCancelled,
                                                  );
                                                  ref
                                                      .read(
                                                        ongoingTransactionProvider
                                                            .notifier,
                                                      )
                                                      .clearOngoingTransaction();
                                                } else {
                                                  displayToastWithContext(
                                                    TypeMsg.error,
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.paiementTransactionCancelledError,
                                                  );
                                                }
                                                ongoingTransactionNotifier
                                                    .clearOngoingTransaction();
                                                barcodeNotifier.clearBarcode();
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
                                          scannerKey.currentState
                                              ?.resetScanner();
                                        },
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                            const SizedBox(width: 20),
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
                                  child: Text(
                                    AppLocalizations.of(context)!.paiementNext,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  scannerKey.currentState?.resetScanner();
                                  barcodeNotifier.clearBarcode();
                                  ongoingTransactionNotifier
                                      .clearOngoingTransaction();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      loadingBuilder: (context) => const SizedBox(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
