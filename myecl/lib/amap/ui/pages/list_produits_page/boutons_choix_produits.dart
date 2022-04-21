import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/class/produit.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/index_commande_provider.dart';
import 'package:myecl/amap/providers/list_commande_provider.dart';
import 'package:myecl/amap/providers/list_produit_provider.dart';
import 'package:myecl/amap/providers/prix_commande_provider.dart';
import 'package:myecl/amap/tools/dialog.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/amap/ui/green_btn.dart';

class Boutons extends HookConsumerWidget {
  const Boutons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final produits = ref.read(listeProduitprovider);
    final cmds = ref.read(listCommandeProvider);
    final cmdsNotifier = ref.watch(listCommandeProvider.notifier);
    final indexCmd = ref.watch(indexCmdProvider);
    final pageNotifier = ref.read(amapPageProvider.notifier);
    final prix = ref.watch(prixProvider);
    return SizedBox(
        height: 90,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          GestureDetector(
              child: GreenBtn(
                  text: "Confirmer (" + prix.toStringAsFixed(2) + "€)"),
              onTap: () {
                if (prix != 0.0) {
                  List<Produit> prod = [];
                  for (var p in produits) {
                    if (p.quantite != 0) {
                      prod.add(p.copy());
                    }
                  }
                  if (indexCmd == -1) {
                    cmdsNotifier.addCommande(DateTime.now(), prod);
                  } else {
                    cmdsNotifier.setProduits(cmds[indexCmd].id, prod);
                  }
                  pageNotifier.setAmapPage(0);
                  clearCmd(ref);
                } else {
                  displayToast(context, TypeMsg.error, "Pas de produit");
                }
              }),
          GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 70,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  ColorConstants.redGradient1,
                  ColorConstants.redGradient2
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                      color: ColorConstants.redGradient2.withOpacity(0.4),
                      offset: const Offset(2, 3),
                      blurRadius: 5)
                ],
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              alignment: Alignment.center,
              child: HeroIcon(
                HeroIcons.x,
                size: 35,
                color: ColorConstants.background,
              ),
            ),
            onTap: () {
              if (prix != 0.0 || indexCmd != -1) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialogBox(
                        descriptions: "Supprimer la commande ?",
                        title: "Suppression",
                        onYes: () {
                          cancelCmd(ref);
                        }));
              } else {
                pageNotifier.setAmapPage(0);
                ref.watch(indexCmdProvider.notifier).setIndex(-1);
              }
            },
          ),
        ]));
  }
}
