import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/paiement/class/store.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_button.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_template.dart';
import 'package:myecl/paiement/ui/pages/scan_page/scan_page.dart';

class SellerCard extends StatelessWidget {
  final Function? toggle;
  final Store seller;
  const SellerCard({super.key, required this.toggle, required this.seller});

  @override
  Widget build(BuildContext context) {
    final buttonGradient = [
      const Color.fromARGB(255, 6, 75, 75),
      Color.fromARGB(255, 0, 29, 29)
    ];
    return MainCardTemplate(
      toggle: toggle,
      colors: const [
        Color.fromARGB(255, 6, 75, 75),
        Color.fromARGB(255, 0, 68, 68),
        Color.fromARGB(255, 0, 29, 29)
      ],
      title: 'Solde associatif',
      value: seller.name,
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
