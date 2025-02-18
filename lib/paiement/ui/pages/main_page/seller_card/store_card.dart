import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/selected_month_provider.dart';
import 'package:myecl/paiement/providers/selected_store_provider.dart';
import 'package:myecl/paiement/router.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_button.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_template.dart';
import 'package:myecl/paiement/ui/pages/scan_page/scan_page.dart';
import 'package:qlevar_router/qlevar_router.dart';

class StoreCard extends HookConsumerWidget {
  final Function? toggle;
  const StoreCard({super.key, required this.toggle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(selectedStoreProvider);
    // final selectedStructure = ref.read(selectedStructureProvider);
    // final storeAdminListNotifier = ref.read(storeAdminListProvider.notifier);
    final selectedMonthNotifier = ref.watch(selectedMonthProvider.notifier);
    final buttonGradient = [
      const Color.fromARGB(255, 6, 75, 75),
      const Color.fromARGB(255, 0, 29, 29),
    ];
    final isEditing = useState(false);
    final storeNameController = useTextEditingController(text: store.name);

    // Reset the editing state when the store changes
    useEffect(
      () {
        isEditing.value = false;
        return null;
      },
      [store],
    );

    return MainCardTemplate(
      toggle: toggle,
      colors: const [
        Color.fromARGB(255, 3, 58, 58),
        Color.fromARGB(255, 0, 68, 68),
        Color.fromARGB(255, 0, 29, 29),
      ],
      title: 'Solde associatif',
      actionButtons: [
        if (store.canBank || store.storeAdmin)
          MainCardButton(
            colors: buttonGradient,
            icon: HeroIcons.viewfinderCircle,
            title: "Scanner",
            onPressed: () async {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                scrollControlDisabledMaxHeightRatio:
                    (1 - 80 / MediaQuery.of(context).size.height),
                builder: (context) => const ScanPage(),
              );
            },
          ),
        if (store.canManageSellers || store.storeAdmin)
          MainCardButton(
            colors: buttonGradient,
            icon: HeroIcons.userGroup,
            onPressed: () async {
              // storeAdminListNotifier.getStoreAdminList(store.id);
              QR.to(PaymentRouter.root + PaymentRouter.storeAdmin);
            },
            title: 'Gestion',
          ),
        // if (store.canManageSellers || store.storeAdmin)
        //   MainCardButton(
        //     colors: buttonGradient,
        //     icon: HeroIcons.pencilSquare,
        //     onPressed: () async {
        //       isEditing.value = !isEditing.value;
        //     },
        //     title: 'Editer',
        //   ),
        if (store.canSeeHistory || store.storeAdmin)
          MainCardButton(
            colors: buttonGradient,
            icon: HeroIcons.wallet,
            onPressed: () async {
              selectedMonthNotifier.clearSelectedMonth();
              QR.to(PaymentRouter.root + PaymentRouter.storeStats);
            },
            title: 'Historique',
          ),
      ],
      child: isEditing.value
          ? Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      labelText: 'Nouveau nom',
                      labelStyle: TextStyle(color: Colors.white),
                      focusColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    controller: storeNameController,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    isEditing.value = false;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const HeroIcon(
                      HeroIcons.check,
                      color: Color.fromARGB(255, 0, 29, 29),
                      size: 30,
                    ),
                  ),
                ),
              ],
            )
          : Text(
              store.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
            ),
    );
  }
}
