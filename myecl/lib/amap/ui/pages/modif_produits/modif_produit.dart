import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/categorie_selectionnee_provider.dart';
import 'package:myecl/amap/providers/index_produit_modifie_provider.dart';
import 'package:myecl/amap/providers/list_categorie_provider.dart';
import 'package:myecl/amap/providers/list_produit_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/amap/ui/green_btn.dart';
import 'package:myecl/amap/ui/pages/modif_produits/text_entry.dart';

// La page pour modifier un produit (ou le crée)
class ModifProduit extends HookConsumerWidget {
  const ModifProduit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Garde l'état du Form
    final _formKey = GlobalKey<FormState>();
    final produitsNotifier = ref.watch(listeProduitprovider.notifier);
    final produits = ref.watch(listeProduitprovider);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final produitModif = ref.watch(produitModifProvider);
    final modifProduit = produitModif != -1;

    /// Le nom du produit (on le remplit si on doit modifier un produit, donc si produitModif est différent de -1)
    final nomController = useTextEditingController(
        text: modifProduit ? produits[produitModif].nom : "");

    /// Le prix du produit (on le remplit si on doit modifier un produit, donc si produitModif est différent de -1)
    final prixController = useTextEditingController(
        text: modifProduit ? produits[produitModif].prix.toString() : "");

    /// La catégorie du produit (on le remplit si on doit modifier un produit, donc si produitModif est différent de -1)
    final beginState = modifProduit
        ? produits[produitModif].categorie
        : TextConstants.creerCategorie;
    final categorieController = ref.watch(cateSelectionneeProvider(beginState));
    final categorieNotifier =
        ref.watch(cateSelectionneeProvider(beginState).notifier);

    ///
    final nouvelleCategorie = useTextEditingController(text: "");
    final categorie = ref.watch(listeCategorieProvider);
    return Column(
      children: [
        const SizedBox(
          height: 35,
        ),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                  color: ColorConstants.background2.withOpacity(0.5)),
              child: Form(
                  key: _formKey,
                  child: Container(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      // new line
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Le nom
                                const Text(
                                  "Nom",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: ColorConstants.gradient2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                // Le zone pour entrer le texte
                                TextEntry(
                                  // La fonction à valider pour pouvoir ajouter le produit
                                  validator: (value) {
                                    // S'il y a un texte
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez remplir ce champ';
                                    }
                                    return null;
                                  },
                                  enabled: true,
                                  onChanged: (_) {},
                                  // Le texte entrer dans cette zone est stockée dans le controlleur
                                  textEditingController: nomController,
                                  // Le type de clavier, ici classique
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                // Le prix
                                const Text(
                                  "Prix",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: ColorConstants.gradient2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                // Le zone pour entrer le texte
                                TextEntry(
                                    // La fonction à valider pour pouvoir ajouter le produit
                                    validator: (value) {
                                      // S'il y a un texte
                                      if (value == null || value.isEmpty) {
                                        return 'Veuillez remplir ce champ';
                                        // Si ce n'est pas un nombre (faut quand même copier coller un texte, faut le vouloir)
                                      } else if (double.tryParse(value) ==
                                          null) {
                                        return 'Un nombre est attendu';
                                      }
                                      return null;
                                    },
                                    enabled: true,
                                    onChanged: (_) {},
                                    // Le type de clavier, ici le pavé numérique
                                    keyboardType: TextInputType.number,
                                    // Le texte entrer dans cette zone est stockée dans le controlleur
                                    textEditingController: prixController),
                                const SizedBox(
                                  height: 30,
                                ),

                                // La catégorie
                                const Text(
                                  "Catégorie",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: ColorConstants.gradient2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                Container(
                                  alignment: Alignment.center,
                                  child: DropdownButtonFormField<String>(
                                    value: categorieController,
                                    validator: ((value) {
                                      if ((value == null ||
                                              value ==
                                                  TextConstants
                                                      .creerCategorie) &&
                                          nouvelleCategorie.text.isEmpty) {
                                        return 'Veuillez créer une catégorie ou en choisir une';
                                      }
                                      return null;
                                    }),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      // La forme de la bordure de la zone
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      // La couleur de la bordure
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(
                                              color: ColorConstants.enabled)),
                                      // La couleur de la bordure en cas d'erreur
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(
                                              color: ColorConstants.red)),
                                      // La couleur de la bordure quand on sélectionne la zone
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(
                                            color: ColorConstants.gradient2,
                                          )),
                                    ),
                                    items: [
                                      TextConstants.creerCategorie,
                                      ...categorie
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      categorieNotifier.setText(value ??
                                          TextConstants.creerCategorie);
                                      nouvelleCategorie.text = "";
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Créer une catégorie",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: ColorConstants.gradient2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                // Le zone pour entrer le texte
                                TextEntry(
                                  // La fonction à valider pour pouvoir ajouter le produit, ici rien
                                  validator: ((value) {
                                    if ((value == null || value.isEmpty) &&
                                        categorieController ==
                                            TextConstants.creerCategorie) {
                                      return 'Veuillez choisir une catégorie ou en créer une';
                                    }
                                    return null;
                                  }),
                                  enabled: categorieController ==
                                      TextConstants.creerCategorie,
                                  onChanged: (value) {
                                    nouvelleCategorie.text = value ?? "";
                                  },
                                  // Le texte entrer dans cette zone est stockée dans le controlleur
                                  textEditingController: nouvelleCategorie,
                                  // Le type de clavier, ici classique
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),

                                // Le bouton de validation
                                GestureDetector(
                                  child: GreenBtn(
                                    text: modifProduit ? "Modifier" : "Ajouter",
                                  ),
                                  onTap: () {
                                    // Si tous les champs sont valides
                                    if (_formKey.currentState!.validate()) {
                                      String cate = categorieController ==
                                              TextConstants.creerCategorie
                                          ? nouvelleCategorie.text
                                          : categorieController;
                                      // Si on doit ajouter un produit
                                      if (modifProduit) {
                                        // On modifie le produit
                                        produitsNotifier.updateProduit(
                                            produits[produitModif].id,
                                            nomController.text,
                                            double.parse(prixController.text),
                                            cate);
                                        // On affiche le message de validation
                                        displayToast(context, TypeMsg.msg,
                                            "Produit modifié");
                                        // Sinon, on doit changer un produit
                                      } else {
                                        // On ajoute un produit
                                        produitsNotifier.addProduit(
                                            nomController.text,
                                            double.parse(prixController.text),
                                            cate);
                                        // On affiche le message de validation
                                        displayToast(context, TypeMsg.msg,
                                            "Produit ajouté");
                                      }
                                      // On change de page
                                      pageNotifier.setAmapPage(3);
                                      // On enlève les textes
                                      nomController.clear();
                                      prixController.clear();
                                      categorieNotifier.setText(
                                          TextConstants.creerCategorie);
                                      nouvelleCategorie.clear();
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))),
        ),
      ],
    );
  }
}
