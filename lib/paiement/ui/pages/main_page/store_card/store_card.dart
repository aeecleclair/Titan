import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_button.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_template.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonGradient = [
      Color.fromARGB(255, 255, 119, 7),
      Color.fromARGB(255, 199, 90, 1),
    ];
    return MainCardTemplate(
      colors: const [
        Color.fromARGB(255, 230, 103, 0),
        Color.fromARGB(255, 255, 119, 7),
        Color.fromARGB(255, 199, 90, 1),
      ],
      title: 'Administrateur',
      topRightWidget: GestureDetector(
        onTap: () {
          // QR.to(PaymentRouter.root + PaymentRouter.stats);
        },
        child: const HeroIcon(
          HeroIcons.userGroup,
          color: Colors.white,
          size: 30,
        ),
      ),
      value: "10 Stores",
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
