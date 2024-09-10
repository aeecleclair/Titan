import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/purchases/class/ticket_generator.dart';
import 'package:myecl/purchases/providers/scanner_provider.dart';
import 'package:myecl/purchases/providers/tag_provider.dart';
import 'package:myecl/purchases/providers/ticket_list_provider.dart';
import 'package:myecl/purchases/tools/constants.dart';
import 'package:myecl/purchases/ui/pages/scan_page/qr_code_scanner.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class ScanDialog extends HookConsumerWidget {
  final String sellerId;
  final String productId;
  final TicketGenerator ticket;
  const ScanDialog({
    super.key,
    required this.ticket,
    required this.sellerId,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scannerNotifier = ref.watch(scannerProvider.notifier);
    final scanner = ref.watch(scannerProvider);

    final tag = ref.watch(tagProvider);
    final tagNotifier = ref.read(tagProvider.notifier);
    final ticketListNotifier = ref.read(ticketListProvider.notifier);
    final shouldSetTag = useState(true);
    final shouldScan = useState(true);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return CardLayout(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: shouldSetTag.value
          ? Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Ajouter un tag pour les scans",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Material(
                    child: TextField(
                  onChanged: (value) async {
                    tagNotifier.setTag(value);
                  },
                  cursorColor: PurchasesColorConstants.textDark,
                  decoration: const InputDecoration(
                    isDense: true,
                    label: Text(
                      PurchasesTextConstants.tag,
                      style: TextStyle(
                        color: PurchasesColorConstants.textDark,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.gradient1),
                    ),
                  ),
                )),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    shouldSetTag.value = false;
                    scannerNotifier.reset();
                  },
                  child: const AddEditButtonLayout(
                    child: Text(
                      "Scanner",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    ticket.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tag.isNotEmpty ? "Tag : $tag" : "Aucun tag",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CardButton(
                        color: Colors.black,
                        child: GestureDetector(
                          onTap: () {
                            shouldSetTag.value = true;
                          },
                          child: const HeroIcon(
                            HeroIcons.pencil,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    height: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: QRCodeScannerScreen(
                        scanner: scanner,
                        onScan: (secret) async {
                          await scannerNotifier.scanTicket(
                            sellerId,
                            productId,
                            secret,
                            ticket.id,
                          );
                          scanner.when(
                            data: (data) {
                              scannerNotifier.setScanner(
                                data.copyWith(
                                  qrCodeSecret: secret,
                                ),
                              );
                              shouldScan.value = false;
                            },
                            error: (error, stack) {
                              displayToastWithContext(
                                TypeMsg.error,
                                error.toString(),
                              );
                              Future.delayed(
                                const Duration(seconds: 2),
                                () {
                                  scannerNotifier.reset();
                                },
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
                          Text(
                            user.getName(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Variant : ${data.productVariant.nameFR}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${data.scanLeft.toString()} / ${ticket.maxUse} ${PurchasesTextConstants.leftScan}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    scannerNotifier.reset();
                                    shouldScan.value = true;
                                  },
                                  child: const SizedBox(
                                    width: 100,
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
                                    final value =
                                        await ticketListNotifier.consumeTicket(
                                      sellerId,
                                      data,
                                      ticket.id,
                                      tag,
                                    );
                                    shouldScan.value = true;
                                    if (value) {
                                      displayToastWithContext(
                                        TypeMsg.msg,
                                        "Scan validé",
                                      );
                                      scannerNotifier.reset();
                                    } else {
                                      displayToastWithContext(
                                        TypeMsg.error,
                                        "Erreur lors de la validation",
                                      );
                                    }
                                  },
                                  child: const SizedBox(
                                    width: 100,
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
                        const Text(
                          "Erreur",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          error.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
