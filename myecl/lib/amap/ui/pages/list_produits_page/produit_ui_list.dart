import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/class/produit.dart';
import 'package:myecl/amap/providers/list_produit_provider.dart';
import 'package:myecl/amap/providers/prix_commande_provider.dart';
import 'package:myecl/amap/tools/constants.dart';

class ProduitUiInList extends ConsumerWidget {
  final int i;
  const ProduitUiInList({Key? key, required this.i}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final produits = ref.watch(listeProduitprovider);
    final produitsNotifier = ref.watch(listeProduitprovider.notifier);
    final prix = ref.watch(prixProvider);
    final prixNotofier = ref.watch(prixProvider.notifier);
    Produit p = produits[i];
    return Container(
        height: 50,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 20,
            ),
            Expanded(
              child: Text(
                p.nom,
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 40,
                  alignment: Alignment.centerRight,
                  child: Text(
                    p.prix.toStringAsFixed(2) + "€",
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                Container(
                  width: 10,
                ),
                GestureDetector(
                  child: Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    child: HeroIcon(
                      HeroIcons.minusSm,
                      size: 20,
                      color: p.quantite > 0
                          ? ColorConstants.l2.withOpacity(0.8)
                          : ColorConstants.background3,
                    ),
                  ),
                  onTap: () {
                    if (p.quantite > 0) {
                      produitsNotifier.setQuantity(p.id, p.quantite - 1);
                      prixNotofier.setPrix(
                          double.parse((prix - p.prix).toStringAsFixed(2)));
                    }
                  },
                ),
                Container(
                  width: 15,
                  alignment: Alignment.center,
                  child: Text(
                    p.quantite.toString(),
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    child: HeroIcon(
                      HeroIcons.plusSm,
                      size: 20,
                      color: p.quantite < 5
                          ? ColorConstants.l2.withOpacity(0.8)
                          : ColorConstants.background3,
                    ),
                  ),
                  onTap: () {
                    if (p.quantite < 5) {
                      produitsNotifier.setQuantity(p.id, p.quantite + 1);
                      prixNotofier.setPrix(
                          double.parse((prix + p.prix).toStringAsFixed(2)));
                    }
                  },
                ),
                Container(
                  width: 10,
                ),
              ],
            )
          ],
        ));
  }
}
