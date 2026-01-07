import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/structure_provider.dart';
import 'package:titan/mypayment/providers/invoice_list_provider.dart';
import 'package:titan/mypayment/providers/structure_list_provider.dart';
import 'package:titan/mypayment/ui/pages/invoices_admin_page/invoice_card.dart';
import 'package:titan/mypayment/ui/mypayment.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/bottom_modal_template.dart';
import 'package:titan/tools/ui/layouts/button.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:tuple/tuple.dart';

class InvoicesAdminPage extends HookConsumerWidget {
  const InvoicesAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = useState(1);
    final pageSize = useState(20);
    final invoices = ref.watch(invoiceListProvider);
    final structures = ref.watch(structureListProvider);
    final structureNotifier = ref.watch(structureProvider.notifier);
    final invoicesNotifier = ref.read(invoiceListProvider.notifier);

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
                        color: Colors.white,
                        disabledColor: ColorConstants.deactivated1,
                      ),
                      DropdownButton<int>(
                        items: [10, 20, 50, 100]
                            .map(
                              (size) => DropdownMenuItem<int>(
                                value: size,
                                child: Text("$size par page"),
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
                        color: Colors.white,
                        disabledColor: ColorConstants.deactivated1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Button.secondary(
                    onPressed: () => showCustomBottomModal(
                      context: context,
                      modal: Consumer(
                        builder: (context, ref, _) {
                          final structure = ref.watch(structureProvider);
                          return BottomModalTemplate(
                            title: "Créer une nouvelle facture",
                            child: Column(
                              children: [
                                Text(
                                  "Sélectionnez une structure",
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
                                              vertical: true,
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
                                  onPressed: () async {
                                    if (structure.id == "") return;
                                    Navigator.pop(context);
                                    await tokenExpireWrapper(ref, () async {
                                      final value = await invoicesNotifier
                                          .createInvoice(structure);
                                      if (value) {
                                        displayToastWithContext(
                                          TypeMsg.msg,
                                          "Facture créée avec succès",
                                        );
                                        refreshInvoices();
                                      } else {
                                        displayToastWithContext(
                                          TypeMsg.error,
                                          "Aucune facture à générer pour cette structure",
                                        );
                                      }
                                    });
                                  },
                                  text: "Créer la facture",
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    text: "Créer une nouvelle facture",
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
