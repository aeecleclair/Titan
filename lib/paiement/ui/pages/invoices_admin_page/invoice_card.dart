import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/class/invoice.dart';
import 'package:titan/paiement/providers/invoice_list_provider.dart';
import 'package:titan/paiement/providers/invoice_pdf_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/confirm_modal.dart';
import 'package:titan/tools/ui/styleguide/list_item_template.dart';

class InvoiceCard extends HookConsumerWidget {
  final Invoice invoice;
  final bool isAdmin;

  const InvoiceCard({super.key, required this.invoice, required this.isAdmin})
    : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizeWithContext = AppLocalizations.of(context)!;
    final invoicesNotifier = ref.read(invoiceListProvider.notifier);
    final invoicePdf = ref.watch(invoicePdfProvider(invoice.id).future);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListItemTemplate(
        title: invoice.reference,
        subtitle: invoice.structure.name,
        onTap: () => showCustomBottomModal(
          context: context,
          modal: BottomModalTemplate(
            title: invoice.reference,
            child: Column(
              children: [
                Button(
                  text: localizeWithContext.paiementDownload,
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
                        localizeWithContext.phSuccesDowloading,
                      );
                    }
                  },
                ),
                if (!invoice.received && isAdmin) ...[
                  const SizedBox(height: 10),
                  Button(
                    text: invoice.paid
                        ? localizeWithContext.paiementMarkUnpaid
                        : localizeWithContext.paiementMarkPaid,
                    onPressed: () async {
                      final value = await invoicesNotifier
                          .updateInvoicePaidStatus(invoice, !invoice.paid);
                      if (value) {
                        displayToastWithContext(
                          TypeMsg.msg,
                          localizeWithContext.paiementModifySuccessfully,
                        );
                      } else {
                        displayToastWithContext(
                          TypeMsg.error,
                          localizeWithContext.paiementErrorUpdatingStatus,
                        );
                      }
                    },
                  ),
                ],
                if (!isAdmin && invoice.paid && !invoice.received) ...[
                  const SizedBox(height: 10),
                  Button(
                    text: localizeWithContext.paiementMarkReceived,
                    onPressed: () async {
                      Navigator.of(context).pop();
                      showCustomBottomModal(
                        context: context,
                        ref: ref,
                        modal: ConfirmModal.danger(
                          title: localizeWithContext.paiementDeleteInvoice,
                          description:
                              localizeWithContext.globalIrreversibleAction,
                          onYes: () async {
                            final value = await invoicesNotifier
                                .updateInvoiceReceivedStatus(invoice, true);
                            if (value) {
                              displayToastWithContext(
                                TypeMsg.msg,
                                localizeWithContext.paiementModifySuccessfully,
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                localizeWithContext.paiementErrorUpdatingStatus,
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ],
                if (!invoice.paid && isAdmin) ...[
                  const SizedBox(height: 10),
                  Button(
                    text: localizeWithContext.paiementDeleteInvoice,
                    onPressed: () async {
                      Navigator.of(context).pop();
                      showCustomBottomModal(
                        context: context,
                        ref: ref,
                        modal: ConfirmModal.danger(
                          title: localizeWithContext.paiementDeleteInvoice,
                          description:
                              localizeWithContext.globalIrreversibleAction,
                          onYes: () async {
                            final value = await invoicesNotifier.deleteInvoice(
                              invoice,
                            );
                            if (value) {
                              displayToastWithContext(
                                TypeMsg.msg,
                                localizeWithContext.paiementDeleteSuccessfully,
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                localizeWithContext.paiementErrorDeleting,
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
          ref: ref,
        ),
        trailing: Expanded(
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
                        color: ColorConstants.tertiary,
                      ),
                    ),
                    AutoSizeText(
                      localizeWithContext.paiementFromTo(
                        invoice.startDate,
                        invoice.endDate,
                      ),
                      maxLines: 2,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              Text(
                invoice.received
                    ? localizeWithContext.paiementReceived
                    : invoice.paid
                    ? localizeWithContext.paiementPaid
                    : localizeWithContext.paiementPending,
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
                color: ColorConstants.tertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
