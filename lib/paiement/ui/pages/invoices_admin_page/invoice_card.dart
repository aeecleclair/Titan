import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/class/invoice.dart';
import 'package:titan/paiement/providers/invoice_list_provider.dart';
import 'package:titan/paiement/providers/invoice_pdf_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/bottom_modal_template.dart';
import 'package:titan/tools/ui/layouts/button.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';

class InvoiceCard extends HookConsumerWidget {
  final Invoice invoice;
  final bool isAdmin;

  const InvoiceCard({super.key, required this.invoice, required this.isAdmin})
    : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoicesNotifier = ref.read(invoiceListProvider.notifier);
    final invoicePdf = ref.watch(invoicePdfProvider(invoice.id).future);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () => showCustomBottomModal(
          context: context,
          modal: BottomModalTemplate(
            title: invoice.reference,
            child: Column(
              children: [
                Button(
                  onPressed: () async {
                    late final Uint8List pdfBytes;
                    try {
                      pdfBytes = await invoicePdf;
                    } catch (e) {
                      displayToastWithContext(TypeMsg.error, e.toString());
                      return;
                    }
                    final path = kIsWeb
                        ? await FileSaver.instance.saveFile(
                            name: invoice.reference,
                            bytes: pdfBytes,
                            ext: "pdf",
                            mimeType: MimeType.pdf,
                          )
                        : await FileSaver.instance.saveAs(
                            name: invoice.reference,
                            bytes: pdfBytes,
                            ext: "pdf",
                            mimeType: MimeType.pdf,
                          );
                    if (path != null) {
                      displayToastWithContext(
                        TypeMsg.msg,
                        "Téléchargement réussi",
                      );
                    }
                  },
                  text: "Télécharger la facture (PDF)",
                ),
                if (!invoice.received && isAdmin) ...[
                  const SizedBox(height: 10),
                  Button(
                    onPressed: () async {
                      final value = await invoicesNotifier
                          .updateInvoicePaidStatus(invoice, !invoice.paid);
                      if (value) {
                        displayToastWithContext(
                          TypeMsg.msg,
                          "Statut mis à jour avec succès",
                        );
                      } else {
                        displayToastWithContext(
                          TypeMsg.error,
                          "Erreur lors de la mise à jour du statut",
                        );
                      }
                    },
                    text: invoice.paid
                        ? "Marquer comme impayée"
                        : "Marquer comme payée",
                  ),
                ],
                if (!isAdmin && invoice.paid && !invoice.received) ...[
                  const SizedBox(height: 10),
                  Button(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialogBox(
                          title: "Marquer comme reçue",
                          descriptions:
                              "Confirmez-vous avoir bien reçu le paiement ?",
                          onYes: () async {
                            final value = await invoicesNotifier
                                .updateInvoiceReceivedStatus(invoice, true);
                            if (value) {
                              displayToastWithContext(
                                TypeMsg.msg,
                                "Statut mis à jour avec succès",
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                "Erreur lors de la mise à jour du statut",
                              );
                            }
                          },
                        ),
                      );
                    },
                    text: "Marquer comme reçue",
                  ),
                ],
                if (!invoice.paid && isAdmin) ...[
                  const SizedBox(height: 10),
                  Button(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialogBox(
                          title: "Supprimer la facture",
                          descriptions: "Cette action est irréversible",
                          onYes: () async {
                            final value = await invoicesNotifier.deleteInvoice(
                              invoice,
                            );
                            if (value) {
                              displayToastWithContext(
                                TypeMsg.msg,
                                "Facture supprimée avec succès",
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                "Erreur lors de la suppression de la facture",
                              );
                            }
                          },
                        ),
                      );
                    },
                    text: "Supprimer la facture",
                  ),
                ],
              ],
            ),
          ),
        ),
        child: CardLayout(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          shadowColor: Colors.grey.withValues(alpha: 0.2),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoice.reference,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      invoice.structure.name,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: kIsWeb ? 2 : 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (kIsWeb)
                      Column(
                        children: [
                          Text(
                            '${(invoice.total / 100).toStringAsFixed(2)} €',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.background2,
                            ),
                          ),
                          AutoSizeText(
                            "Du ${processDate(invoice.startDate)} au ${processDate(invoice.endDate)}",
                            maxLines: 2,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    Text(
                      invoice.received
                          ? "Reçue"
                          : invoice.paid
                          ? "Payée"
                          : "En attente",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: invoice.received
                            ? Colors.green
                            : invoice.paid
                            ? Colors.blue
                            : Colors.orange,
                      ),
                    ),
                    const HeroIcon(
                      HeroIcons.chevronRight,
                      color: ColorConstants.background2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
