import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/modified_product_index_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/providers/selected_category_provider.dart';
import 'package:myecl/amap/providers/category_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/amap/ui/green_btn.dart';
import 'package:myecl/amap/ui/pages/modif_produits/text_entry.dart';
import 'package:uuid/uuid.dart';

class ModifProduct extends HookConsumerWidget {
  const ModifProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final productsNotifier = ref.watch(productListProvider.notifier);
    final products = ref.watch(productListProvider.notifier).lastLoadedProducts;
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final productModif = ref.watch(modifiedProductProvider);
    final modifProduct = productModif != -1;

    final nomController = useTextEditingController(
        text: modifProduct ? products[productModif].nom : "");

    final prixController = useTextEditingController(
        text: modifProduct ? products[productModif].prix.toString() : "");

    final beginState = modifProduct
        ? products[productModif].categorie
        : TextConstants.creerCategorie;
    final categorieController = ref.watch(selectedCategoryProvider(beginState));
    final categorieNotifier =
        ref.watch(selectedCategoryProvider(beginState).notifier);

    final nouvelleCategorie = useTextEditingController(text: "");
    final categorie = ref.watch(categoryListProvider);
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
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                TextEntry(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez remplir ce champ';
                                    }
                                    return null;
                                  },
                                  enabled: true,
                                  onChanged: (_) {},
                                  textEditingController: nomController,
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
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
                                TextEntry(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Veuillez remplir ce champ';
                                      } else if (double.tryParse(value) ==
                                          null) {
                                        return 'Un nombre est attendu';
                                      }
                                      return null;
                                    },
                                    enabled: true,
                                    onChanged: (_) {},
                                    keyboardType: TextInputType.number,
                                    textEditingController: prixController),
                                const SizedBox(
                                  height: 30,
                                ),
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
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(
                                              color: ColorConstants.enabled)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(
                                              color: ColorConstants.red)),
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
                                TextEntry(
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
                                  textEditingController: nouvelleCategorie,
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                GestureDetector(
                                  child: GreenBtn(
                                    text: modifProduct ? "Modifier" : "Ajouter",
                                  ),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      String cate = categorieController ==
                                              TextConstants.creerCategorie
                                          ? nouvelleCategorie.text
                                          : categorieController;

                                        Product newProduct = Product(
                                          id: products[productModif].id,
                                          nom: nomController.text,
                                          prix: double.parse(
                                              prixController.text),
                                          categorie: cate,
                                          quantite: 0,
                                        );
                                      if (modifProduct) {
                                        productsNotifier.updateProduct(
                                            newProduct.id, newProduct);

                                        displayToast(context, TypeMsg.msg,
                                            "Product modifié");
                                      } else {
                                        newProduct.id = const Uuid().v4();
                                        productsNotifier.addProduct(newProduct);

                                        displayToast(context, TypeMsg.msg,
                                            "Product ajouté");
                                      }

                                      pageNotifier.setAmapPage(3);

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
