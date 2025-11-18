import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/providers/invoice_list_provider.dart';
import 'package:titan/paiement/providers/my_structures_provider.dart';
import 'package:titan/paiement/providers/selected_structure_provider.dart';
import 'package:titan/paiement/router.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/bottom_modal_template.dart';
import 'package:titan/tools/ui/layouts/button.dart';

class StructureAdminCard extends ConsumerWidget {
  const StructureAdminCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myStructures = ref.watch(myStructuresProvider);
    final selectedStructureNotifier = ref.read(
      selectedStructureProvider.notifier,
    );
    final invoicesNotifier = ref.watch(invoiceListProvider.notifier);

    return Column(
      children: myStructures.map((structure) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 27,
                  backgroundColor: Color.fromARGB(255, 6, 75, 75),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: AutoSizeText(
                    "Gestion de ${structure.name}",
                    maxLines: 2,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 29, 29),
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                HeroIcon(
                  HeroIcons.arrowRight,
                  color: Color.fromARGB(255, 0, 29, 29),
                  size: 25,
                ),
              ],
            ),
          ),
          onTap: () {
            showCustomBottomModal(
              context: context,
              modal: BottomModalTemplate(
                title: "Gestion de ${structure.name}",
                child: Column(
                  children: [
                    Button(
                      onPressed: () {
                        Navigator.of(context).pop();
                        selectedStructureNotifier.setStructure(structure);
                        QR.to(
                          PaymentRouter.root + PaymentRouter.structureStores,
                        );
                      },
                      text: "Magasins",
                    ),
                    const SizedBox(height: 10),
                    Button(
                      onPressed: () {
                        Navigator.of(context).pop();
                        tokenExpireWrapper(
                          ref,
                          () => invoicesNotifier.getStructureInvoices(
                            structure.id,
                          ),
                        );
                        QR.to(
                          PaymentRouter.root + PaymentRouter.invoicesStructure,
                        );
                      },
                      text: "Factures",
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
