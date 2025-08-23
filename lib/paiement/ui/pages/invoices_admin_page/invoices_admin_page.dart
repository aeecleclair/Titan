import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/structure_provider.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/providers/invoice_list_provider.dart';
import 'package:titan/paiement/providers/structure_list_provider.dart';
import 'package:titan/paiement/ui/pages/invoices_admin_page/invoice_card.dart';
import 'package:titan/paiement/ui/paiement.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/item_chip.dart';
import 'package:titan/tools/ui/styleguide/list_item_template.dart';
import 'package:tuple/tuple.dart';

class InvoicesAdminPage extends HookConsumerWidget {
  const InvoicesAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController();
    final page = useState(1);
    final pageSize = useState(20);
    final invoices = ref.watch(invoiceListProvider);
    final structures = ref.watch(structureListProvider);
    final structureNotifier = ref.watch(structureProvider.notifier);
    final invoicesNotifier = ref.read(invoiceListProvider.notifier);

    final localizeWithContext = AppLocalizations.of(context)!;

    void refreshInvoices() {
      tokenExpireWrapper(
        ref,
        () => invoicesNotifier.getInvoices(
          page: page.value,
          pageLimit: pageSize.value,
        ),
      );
    }

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PaymentTemplate(
      child: Refresher(
        onRefresh: () async {
          refreshInvoices();
        },
        controller: controller,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Async2Children(
            values: Tuple2(invoices, structures),
            builder: (context, invoices, structures) {
              return Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: HeroIcon(HeroIcons.arrowLeft),
                        onPressed: page.value <= 1
                            ? null
                            : () {
                                page.value--;
                                refreshInvoices();
                              },
                        color: ColorConstants.onTertiary,
                        disabledColor: ColorConstants.background,
                      ),
                      DropdownButton<int>(
                        items: [10, 20, 50, 100]
                            .map(
                              (size) => DropdownMenuItem<int>(
                                value: size,
                                child: Text(
                                  localizeWithContext.paiementInvoicesPerPage(
                                    size,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            pageSize.value = value;
                            refreshInvoices();
                          }
                        },
                        value: pageSize.value,
                      ),
                      IconButton(
                        icon: HeroIcon(HeroIcons.arrowRight),
                        onPressed: invoices.length < pageSize.value
                            ? null
                            : () {
                                page.value++;
                                refreshInvoices();
                              },
                        color: ColorConstants.onTertiary,
                        disabledColor: ColorConstants.background,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListItemTemplate(
                    title: localizeWithContext.paiementCreateInvoice,
                    onTap: () => showCustomBottomModal(
                      context: context,
                      modal: Consumer(
                        builder: (context, ref, _) {
                          final structure = ref.watch(structureProvider);
                          return BottomModalTemplate(
                            title: localizeWithContext.paiementCreateInvoice,
                            child: Column(
                              children: [
                                Text(
                                  localizeWithContext.paiementSelectStructure,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: min(
                                    structures.length * 50,
                                    MediaQuery.of(context).size.height * 0.8,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: structures
                                          .map(
                                            (e) => ItemChip(
                                              scrollDirection: Axis.vertical,
                                              onTap: () => structureNotifier
                                                  .setStructure(e),
                                              selected: structure.id == e.id,
                                              child: Text(
                                                e.name,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: structure.id == e.id
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ),
                                Button(
                                  text: localizeWithContext.paiementCreate,
                                  onPressed: () async {
                                    if (structure.id == "") return;
                                    Navigator.pop(context);
                                    await tokenExpireWrapper(ref, () async {
                                      final value = await invoicesNotifier
                                          .createInvoice(structure);
                                      if (value) {
                                        displayToastWithContext(
                                          TypeMsg.msg,
                                          localizeWithContext
                                              .paiementInvoiceCreatedSuccessfully,
                                        );
                                        refreshInvoices();
                                      } else {
                                        displayToastWithContext(
                                          TypeMsg.error,
                                          localizeWithContext
                                              .paiementNoInvoiceToCreate,
                                        );
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      ref: ref,
                    ),
                    trailing: HeroIcon(
                      HeroIcons.plus,
                      color: ColorConstants.onTertiary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...invoices.map(
                    (invoice) => InvoiceCard(invoice: invoice, isAdmin: true),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
