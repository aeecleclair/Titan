import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/produit.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/index_commande_provider.dart';
import 'package:myecl/amap/providers/list_commande_provider.dart';
import 'package:myecl/amap/providers/list_produit_provider.dart';
import 'package:myecl/amap/providers/prix_commande_provider.dart';
import 'package:myecl/amap/tools/constants.dart';


/// **Remet les quantités des produits et le prix à 0**
///
/// Paramètre :
/// * ref (WidgetRef) permet d'accéder aux providers
void clearCmd(WidgetRef ref) {
  // On récupère les providers nécessaires
  final produits = ref.watch(listeProduitprovider);
  final produitsNotifier = ref.watch(listeProduitprovider.notifier);
  final prixNotofier = ref.watch(prixProvider.notifier);
  // Pour chaque produit
  for (Produit p in produits) {
    // On met la quantité à 0
    produitsNotifier.setQuantity(p.id, 0);
  }
  // On met le prix à 0
  prixNotofier.setPrix(0.0);
}


/// **Remet les quantités des produits et le prix à 0, renvoie vers la page des commandes et supprime, si nécessaire la commande**
///
/// Paramètre :
/// * ref (WidgetRef) permet d'accéder aux providers
void cancelCmd(WidgetRef ref) {
  // On récupère les providers nécessaires
  final indexCmd = ref.watch(indexCmdProvider);
  final pageNotifier = ref.watch(amapPageProvider.notifier);
  pageNotifier.setAmapPage(1);
  clearCmd(ref);
  if (indexCmd != -1) {
    deleteCmd(ref, indexCmd);
  }
}


/// **Supprime la commande**
///
/// Paramètres :
/// * ref (WidgetRef) permet d'accéder aux providers
/// * i (int) l'indice de la commande à supprimer
void deleteCmd(WidgetRef ref, int i) {
  // On récupère les providers nécessaires
  final indexCmdNotifier = ref.watch(indexCmdProvider.notifier);
  final cmdsNotifier = ref.watch(listCommandeProvider.notifier);
  indexCmdNotifier.setIndex(-1);
  cmdsNotifier.removeCommande(i);
}

/// **Les différents type de message**
enum TypeMsg { msg, error }


/// **Affiche un message en haut de la page avec le texte donné**
///
/// Paramètres :
/// * context (BuildContext) le contexte, nécessaire pour la création du Toast
/// * type (TypeMsg) le type de toast à afficher
/// * text (String) le message à afficher
void displayToast(BuildContext context, TypeMsg type, String text) {
  LinearGradient linearGradient;
  HeroIcons icon;

  // On change la couleur et l'icône en fonction du type de message
  switch (type) {
    case TypeMsg.msg:
      linearGradient = const LinearGradient(
          colors: [ColorConstants.gradient1, ColorConstants.gradient2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight);
      icon = HeroIcons.check;
      break;
    case TypeMsg.error:
      linearGradient = const LinearGradient(
          colors: [ColorConstants.redGradient1, ColorConstants.redGradient2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight);
      icon = HeroIcons.exclamation;
      break;
  }

  showFlash(
      context: context,
      duration: const Duration(milliseconds: 1500),
      builder: (context, controller) {
        return Flash.dialog(
          controller: controller,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          backgroundGradient: linearGradient,
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: HeroIcon(icon,
                      color: ColorConstants.background),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.background),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}