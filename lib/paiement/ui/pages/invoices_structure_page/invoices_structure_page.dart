import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/providers/invoice_list_provider.dart';
import 'package:titan/paiement/providers/selected_structure_provider.dart';
import 'package:titan/paiement/ui/pages/invoices_admin_page/invoice_card.dart';
import 'package:titan/paiement/ui/paiement.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';

class StructureInvoicesPage extends HookConsumerWidget {
  const StructureInvoicesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController();
    final page = useState(1);
    final pageSize = useState(20);

    final selectedStructure = ref.watch(selectedStructureProvider);
    final invoices = ref.watch(invoiceListProvider);
    final invoicesNotifier = ref.watch(invoiceListProvider.notifier);

    void refreshInvoices() {
      tokenExpireWrapper(
        ref,
        () => invoicesNotifier.getStructureInvoices(
          selectedStructure.id,
          page: page.value,
          pageLimit: pageSize.value,
        ),
      );
    }

    return PaymentTemplate(
      child: Refresher(
        controller: controller,
        onRefresh: () async {
          refreshInvoices();
        },
        child: AsyncChild(
          value: invoices,
          builder: (context, invoices) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
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
                                child: Text(size.toString()),
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
                  ...invoices.map(
                    (invoice) => InvoiceCard(invoice: invoice, isAdmin: false),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
