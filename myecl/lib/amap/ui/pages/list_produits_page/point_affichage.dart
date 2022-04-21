import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/list_produit_provider.dart';
import 'package:myecl/amap/providers/page_controller_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// L'indicateur de page dans la lsite des produits
class Dots extends HookConsumerWidget {
  const Dots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final produits = ref.watch(listeProduitprovider);
    final pageController = ref.watch(pageControllerProvider);
    /** le nombre de catégorie
     *
     * Code équivalent :
      ```dart
      List<String> listCate = [];
        for (Produit p in produits) {
          if (!listCate.contains(p.categorie)) {
            listCate.add(p.categorie);
          }
        }
      int len = listeCate.length;
      ```
     */
    int len = {...produits.map((e) => e.categorie)}.length;
    return SmoothPageIndicator(
      controller: pageController,
      count: len,
      effect: WormEffect(
          dotColor: ColorConstants.background3,
          activeDotColor: ColorConstants.enabled,
          dotWidth: 7,
          dotHeight: 7),
      // Si on clique sur un point
      onDotClicked: (index) {
        // On anime vers la page cliquée
        pageController.animateToPage(index,
            duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
      },
    );
  }
}
