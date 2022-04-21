import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/class/commande.dart';
import 'package:myecl/amap/class/produit.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/index_commande_provider.dart';
import 'package:myecl/amap/providers/list_commande_provider.dart';
import 'package:myecl/amap/providers/list_produit_provider.dart';
import 'package:myecl/amap/providers/prix_commande_provider.dart';
import 'package:myecl/amap/tools/dialog.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';

class CommandeUi extends ConsumerWidget {
  final Commande c;
  const CommandeUi({Key? key, required this.c}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmds = ref.watch(listCommandeProvider);
    final cmdsNotifier = ref.watch(listCommandeProvider.notifier);
    final produitsNotifier = ref.watch(listeProduitprovider.notifier);
    final indexCmdNotifier = ref.watch(indexCmdProvider.notifier);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final prixNotofier = ref.watch(prixProvider.notifier);
    final i = cmds.indexOf(c);
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: Colors.grey.shade50,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.background3.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(2, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 30,
                height: 60,
              ),

              // La date de la commande
              Expanded(
                child: Text(
                  "Date : " +
                      c.date.day.toString() +
                      "/" +
                      c.date.month.toString().padLeft(2, "0") +
                      "/" +
                      c.date.year.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.l1),
                ),
              ),

              // Le bouton pour dérouler les produits de la commande
              GestureDetector(
                child: Container(
                  width: 50,
                  height: 25,
                  alignment: Alignment.topCenter,
                  child: HeroIcon(
                    cmds[i].expanded
                        ? HeroIcons.chevronUp
                        : HeroIcons.chevronDown,
                    color: ColorConstants.textDark,
                  ),
                ),
                onTap: () {
                  // On change la valeur de expanded de la commande
                  cmdsNotifier.toggleExpanded(cmds[i].id);
                },
              )
            ],
          ),

          // Disjonction de cas en fonction de la valeur de expanded de la commande
          cmds[i].expanded
              // Si il faut tout afficher
              ? Column(
                  // Pour chaque produit
                  children: c.produits
                      .map((p) => Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          alignment: Alignment.center,
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 20,
                              ),

                              // Le nom et la quantité
                              Expanded(
                                child: Text(
                                  p.nom +
                                      " (quantité : " +
                                      p.quantite.toString() +
                                      ")",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: ColorConstants.textDark,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                width: 15,
                              ),
                              Row(
                                children: [
                                  // Le prix du produit multiplié par la quantité commandée
                                  Container(
                                    width: 40,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      (p.quantite * p.prix).toStringAsFixed(2) +
                                          "€",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: ColorConstants.textDark,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                ],
                              )
                            ],
                          )))
                      .toList())
              // Sinon on n'affiche rien
              : Container(),
          Container(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 25,
              ),

              // Le nombre de produit
              Container(
                width: 140,
                alignment: Alignment.centerLeft,
                child: Text(
                  c.produits.length.toString() +
                      " produit" +
                      (c.produits.length != 1 ? "s" : ""),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.textLight),
                ),
              ),

              // Le prix du produit
              Container(
                  width: 140,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Prix : " +
                        (c.produits.map((p) => p.quantite * p.prix))
                            .reduce((value, element) => value + element)
                            .toStringAsFixed(2) +
                        "€",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.textLight),
                  ))
            ],
          ),
          Container(
            height: 20,
          ),

          // Si on affiche tout, on ajoute les boutons
          cmds[i].expanded
              ? Row(
                  children: [
                    // Le bouton pour modifier le produit
                    GestureDetector(
                      child: Container(
                        height: 70,
                        width: (MediaQuery.of(context).size.width - 40) / 2,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(23),
                                topLeft: Radius.circular(23)),
                            color: ColorConstants.background2),
                        alignment: Alignment.center,
                        child: const Text("Modifier",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.enabled)),
                      ),
                      onTap: () {
                        indexCmdNotifier.setIndex(i);
                        for (Produit p
                            in cmds[i].produits.where((e) => e.quantite != 0)) {
                          produitsNotifier.setQuantity(p.id, p.quantite);
                        }
                        prixNotofier.setPrix(cmdsNotifier.getPrix(i));
                        pageNotifier.setAmapPage(2);
                      },
                    ),

                    // le bouton pour supprimer le produit
                    GestureDetector(
                      child: Container(
                        height: 70,
                        width: (MediaQuery.of(context).size.width - 40) / 2,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(23),
                                topRight: Radius.circular(23)),
                            color: ColorConstants.background2),
                        alignment: Alignment.center,
                        child: const Text("Supprimer",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.redGradient1)),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                // Crée la fenêtre de confirmation
                                CustomDialogBox(
                                    descriptions: "Supprimer la commande ?",
                                    title: "Suppression",
                                    onYes: () {
                                      deleteCmd(ref, i);
                                      displayToast(context, TypeMsg.msg,
                                          "Commande supprimée");
                                    }));
                      },
                    )
                  ],
                )
              // Sinon on affiche rien
              : Container()
        ],
      ),
    );
  }
}
