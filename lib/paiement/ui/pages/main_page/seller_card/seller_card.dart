import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_button.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_template.dart';

class SellerCard extends StatelessWidget {
  const SellerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonGradient = [
      const Color.fromARGB(255, 0, 68, 68),
      const Color.fromARGB(255, 6, 75, 75),
    ];
    return MainCardTemplate(
      colors: const [
        Color.fromARGB(255, 6, 75, 75),
        Color.fromARGB(255, 0, 68, 68),
        Color.fromARGB(255, 0, 29, 29)
      ],
      title: 'Solde associatif',
      topRightWidget: GestureDetector(
        onTap: () {
          // QR.to(PaymentRouter.root + PaymentRouter.stats);
        },
        child: const HeroIcon(
          HeroIcons.chartPie,
          color: Colors.white,
          size: 30,
        ),
      ),
      value: "WEI",
      actionButtons: [
        MainCardButton(
          colors: buttonGradient,
          icon: HeroIcons.cog,
          onPressed: () async {},
          title: 'Gestion',
        ),
        MainCardButton(
          colors: buttonGradient,
          icon: HeroIcons.plus,
          onPressed: () async {},
          title: 'Ajouter',
        ),
        MainCardButton(
          colors: buttonGradient,
          icon: HeroIcons.wallet,
          onPressed: () async {},
          title: 'Stats',
        ),
      ],
    );
  }
}
