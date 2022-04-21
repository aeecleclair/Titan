import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/constants.dart';

/// Les textes de présentation de l'AMAP
class TextPresentation extends StatelessWidget {
  const TextPresentation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorConstants.background2.withOpacity(0.5)),
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(bottom: 30, left: 20, right: 30),
            child: Column(
              children: [
                const Text(
                  "L'AMAP (association pour le maintien d'une agriculture paysanne) est un service proposé par l'association Planet&Co de l'ECL. Vous pouvez ainsi recevoir des produits (paniers de fruits et légumes, jus, confitures...) directement sur le campus !",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 15,
                ),
                const Text(
                  "Les commandes doivent être passées avant le vendredi 21h et sont livrées sur le campus le mardi de 13h à 13h45 (ou de 18h15 à 18h30 si vous ne pouvez pas passer le midi) dans le hall du M16.",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 15,
                ),
                const Text(
                  "Vous ne pouvez commander que si votre solde le permet. Vous pouvez recharger votre solde via la collecte Lydia ou bien avec un chèque que vous pouvez nous transmettre lors des permanences.",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 15,
                ),
                const Text(
                  "Lien vers la collecte Lydia pour le rechargement : Collecte",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 15,
                ),
                const Text(
                  "N’hésitez pas à nous contacter en cas de problème !",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 15,
                ),
                const Text(
                  "Contact asso : Marion Cornic - marion.cornic@ecl20.ec-lyon.fr",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )),
    );
  }
}
