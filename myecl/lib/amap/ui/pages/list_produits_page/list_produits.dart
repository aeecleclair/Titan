import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/produit.dart';
import 'package:myecl/amap/providers/list_categorie_provider.dart';
import 'package:myecl/amap/providers/list_produit_provider.dart';
import 'package:myecl/amap/providers/page_controller_provider.dart';
import 'package:myecl/amap/providers/scroll_controller_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/list_produits_page/produit_ui_list.dart';

/// Affichage de la liste des produits
class ListProduits extends HookConsumerWidget {
  const ListProduits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // L'animation du message "Voir plus"
    final hideAnimation = useAnimationController(
        duration: const Duration(milliseconds: 200), initialValue: 1);
    // le controlleur de défilement horizontal des liste de produits
    final scrollController = ref.watch(scrollControllerProvider(hideAnimation));
    final produits = ref.watch(listeProduitprovider);
    final pageController = ref.watch(pageControllerProvider);
    final categories = ref.watch(listeCategorieProvider);

    // On crée un dictionnaire <catégorie, liste des produits de cette catégorie>
    Map<String, List<Widget>> dictCateListWidget = {
      for (var item in categories) item: []
    };
    // Pour chaque produit
    for (Produit p in produits) {
      // On ajoute Le widget crée à partir du produit dans le dictionnaire (le ! impose que dictCateListWidget[...] existe, null-safety)
      dictCateListWidget[p.categorie]!
          .add(ProduitUiInList(i: produits.indexOf(p)));
    }

    return SizedBox(
        height: MediaQuery.of(context).size.height - 275,
        child: PageView(
          scrollDirection: Axis.horizontal,
          controller: pageController,
          // Quand on change de liste de produit (défilement horizontal)
          onPageChanged: (index) {
            // Si on peut scroller dans la liste (donc .positions existe)
            if (scrollController.positions.isNotEmpty) {
              // On scrolle vers le haut
              scrollController.jumpTo(0);
            }
            // On réaffiche le message
            hideAnimation.animateTo(1);
          },
          physics: const BouncingScrollPhysics(),

          // On itère sur chaque catégorie
          children: categories.map((c) {
            // h est la différence entre la hauteur consacrée à la liste dans l'affichage et la hauteur réelle de la liste (donc h < 0 implique qu'il faudra scroller pour tout voir)
            double h = MediaQuery.of(context).size.height -
                270 -
                50 * (dictCateListWidget[c]!.length + 1);
            return Builder(
              builder: (BuildContext context) {
                // la liste des widgets à afficher dans la liste, on y met déjà la catégorie
                List<Widget> listWidgetProduit = [
                  Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      c,
                      style: const TextStyle(
                        fontSize: 25,
                        color: ColorConstants.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ];
                // On ajoute les widgets s'ils existent, une liste vide sinon (ils existent toujours, la catégorie a été crée à partir, null-safety)
                listWidgetProduit += dictCateListWidget[c] ?? [];

                // S'il faut faire défiler la liste
                if (h < 0) {
                  return Stack(
                    children: [
                      SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 10.0, sigmaY: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorConstants.background2
                                          .withOpacity(0.5),
                                    ),
                                    child: Column(
                                      children: listWidgetProduit,
                                    ),
                                  )))),

                      // Le texte "Voir plus"
                      Positioned(
                        // On le positionne en fonction des dimensions du téléphone
                        top: MediaQuery.of(context).size.height - 350,
                        left: (MediaQuery.of(context).size.width - 150) / 2,
                        // Pour le faire disparaître
                        child: FadeTransition(
                          opacity: hideAnimation,
                          child: ScaleTransition(
                              scale: hideAnimation,
                              child: GestureDetector(
                                // Si on clique dessus
                                onTap: (() {
                                  // On fait disparaître le texte
                                  hideAnimation.animateTo(0);
                                  // On fait défiler la liste vers le bas jusqu'au dernier produit
                                  scrollController.animateTo(-h + 5,
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.decelerate);
                                }),

                                // Le texte "Voir plus"
                                child: Container(
                                    width: 150,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          colors: [
                                            ColorConstants.l1,
                                            ColorConstants.l2
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight),
                                      boxShadow: [
                                        BoxShadow(
                                            color: ColorConstants.l2
                                                .withOpacity(0.4),
                                            offset: const Offset(2, 3),
                                            blurRadius: 5)
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        HeroIcon(
                                          HeroIcons.chevronDoubleDown,
                                          size: 15,
                                          color: ColorConstants.background,
                                        ),
                                        Text("Voir Plus",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: ColorConstants.background,
                                            )),
                                      ],
                                    )),
                              )),
                        ),
                      )
                    ],
                  );
                  // Sinon, on n'as pas besoin de faire défiler la liste, on garde alors une simple colonne
                } else {
                  return ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color:
                                    ColorConstants.background2.withOpacity(0.5),
                              ),
                              child: Column(children: listWidgetProduit))));
                }
              },
            );
          }).toList(),
        ));
  }
}
