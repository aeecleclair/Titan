import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/constants.dart';

class PresentationPage extends StatelessWidget {
  const PresentationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(bottom: 30, left: 20, right: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "L'AMAP (association pour le maintien d'une agriculture paysanne) est un service proposé par l'association Planet&Co de l'ECL. Vous pouvez ainsi recevoir des produits (paniers de fruits et légumes, jus, confitures...) directement sur le campus !\n\nLes commandes doivent être passées avant le vendredi 21h et sont livrées sur le campus le mardi de 13h à 13h45 (ou de 18h15 à 18h30 si vous ne pouvez pas passer le midi) dans le hall du M16.\n\nVous ne pouvez commander que si votre solde le permet. Vous pouvez recharger votre solde via la collecte Lydia ou bien avec un chèque que vous pouvez nous transmettre lors des permanences.\n\nLien vers la collecte Lydia pour le rechargement : Collecte\n\nN’hésitez pas à nous contacter en cas de problème !",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    foreground: Paint()
                      ..shader = const RadialGradient(
                        colors: [
                          AMAPColorConstants.greenGradient1,
                          AMAPColorConstants.textDark,
                        ],
                        center: Alignment.topLeft,
                        radius: 10,
                      ).createShader(
                          const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
              ),
              Container(
                height: 15,
              ),
              const Text(
                "Contact asso : ...",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AMAPColorConstants.textDark),
              ),
            ],
          ),
        ));
  }
}
