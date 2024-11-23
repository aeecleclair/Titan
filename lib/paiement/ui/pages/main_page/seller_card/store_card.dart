import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/selected_store_provider.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_button.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_template.dart';
import 'package:myecl/paiement/ui/pages/scan_page/scan_page.dart';

class StoreCard extends ConsumerWidget {
  final Function? toggle;
  const StoreCard({super.key, required this.toggle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(selectedStoreProvider);
    final buttonGradient = [
      const Color.fromARGB(255, 6, 75, 75),
      const Color.fromARGB(255, 0, 29, 29)
    ];
    return MainCardTemplate(
      toggle: toggle,
      colors: const [
        Color.fromARGB(255, 3, 58, 58),
        Color.fromARGB(255, 0, 68, 68),
        Color.fromARGB(255, 0, 29, 29)
      ],
      title: 'Solde associatif',
      value: store.name,
      actionButtons: [
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
        MainCardButton(
          colors: buttonGradient,
          icon: HeroIcons.userGroup,
          onPressed: () async {},
          title: 'Gestion',
        ),
        MainCardButton(
          colors: buttonGradient,
          icon: HeroIcons.pencilSquare,
          onPressed: () async {},
          title: 'Editer',
        ),
        MainCardButton(
          colors: buttonGradient,
          icon: HeroIcons.wallet,
          onPressed: () async {},
          title: 'Historique',
        ),
      ],
    );
  }
}
