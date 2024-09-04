import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/purchases/class/product.dart';
import 'package:myecl/purchases/providers/scanner_provider.dart';
import 'package:myecl/purchases/providers/tag_provider.dart';
import 'package:myecl/purchases/providers/ticket_list_provider.dart';
import 'package:myecl/purchases/tools/constants.dart';
import 'package:myecl/purchases/ui/pages/scan_page/qr_code_scanner.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class ScanDialog extends HookConsumerWidget {
  final Product product;
  const ScanDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scannerNotifier = ref.watch(scannerProvider.notifier);
    final scanner = ref.watch(scannerProvider);
    final tag = ref.watch(tagProvider);
    final ticketListNotifier = ref.read(ticketListProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return CardLayout(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            product.nameFR,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: QRCodeScannerScreen(
                product: product,
                onScan: (secret) async {
                  await scannerNotifier.scanTicket(product.id, secret);
                  scanner.when(
                    data: (data) {
                      scannerNotifier.setScanner(
                        data.copyWith(
                          secret: secret,
                        ),
                      );
                    },
                    error: (error, stack) {
                      displayToastWithContext(
                        TypeMsg.error,
                        error.toString(),
                      );
                    },
                    loading: () {},
                  );
                },
              ),
            ),
          ),
          scanner.when(
            data: (data) {
              final user = data.user;
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const HeroIcon(
                      HeroIcons.check,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    user.getName(),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${data.ticket.scanLeft.toString()} / ${product.ticketMaxUse} ${PurchasesTextConstants.leftScan}",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: scannerNotifier.reset,
                          child: const Flexible(
                            flex: 2,
                            child: AddEditButtonLayout(
                              color: Colors.red,
                              child: Text(
                                "Annuler",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            final value = await ticketListNotifier
                                .consumeTicket(data, tag);
                            if (value) {
                              displayToastWithContext(
                                  TypeMsg.msg, "Scan validé");
                              scannerNotifier.reset();
                            } else {
                              displayToastWithContext(TypeMsg.error,
                                  "Erreur lors de la validation");
                            }
                          },
                          child: const Flexible(
                            flex: 2,
                            child: AddEditButtonLayout(
                              color: Colors.green,
                              child: Text(
                                "Valider",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            loading: () => const Text(
              PurchasesTextConstants.loading,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            error: (error, stack) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.red[800],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const HeroIcon(
                    HeroIcons.check,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Erreur",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  error.toString(),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
