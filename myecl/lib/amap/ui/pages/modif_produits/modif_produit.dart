import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/modified_product_index_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/providers/selected_category_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/amap/ui/green_btn.dart';
import 'package:myecl/amap/ui/pages/modif_produits/text_entry.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';
import 'package:uuid/uuid.dart';

class ModifProduct extends HookConsumerWidget {
  const ModifProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final productsNotifier = ref.watch(productListProvider.notifier);
    final productsList = ref.watch(productListProvider);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final productModif = ref.watch(modifiedProductProvider);
    final modifProduct = productModif != -1;
    final products = [];
    final List<String> categories = [];
    productsList.when(
      data: (list) => products.addAll(list),
      error: (e, s) {},
      loading: () {},
    );

    final nameController = useTextEditingController(
        text: modifProduct ? products[productModif].name : "");

    final priceController = useTextEditingController(
        text: modifProduct ? products[productModif].price.toString() : "");

    final beginState = modifProduct
        ? products[productModif].category
        : AMAPTextConstants.createCategory;
    final categoryController = ref.watch(selectedCategoryProvider(beginState));
    final categoryNotifier =
        ref.watch(selectedCategoryProvider(beginState).notifier);

    final nouvellecategory = useTextEditingController(text: "");

    products.map((e) {
      if (!categories.contains(e.category)) {
        categories.add(e.category);
      }
    }).toList();

    return Column(
      children: [
        const SizedBox(
          height: 35,
        ),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                  color: AMAPColorConstants.background2.withOpacity(0.5)),
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
                                  AMAPTextConstants.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: AMAPColorConstants.greenGradient2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextEntry(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AMAPTextConstants.fillField;
                                    }
                                    return null;
                                  },
                                  enabled: true,
                                  onChanged: (_) {},
                                  textEditingController: nameController,
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  AMAPTextConstants.price,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: AMAPColorConstants.greenGradient2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextEntry(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AMAPTextConstants.fillField;
                                      } else if (double.tryParse(
                                              value.replaceAll(',', '.')) ==
                                          null) {
                                        return AMAPTextConstants
                                            .expectingNumber;
                                      }
                                      return null;
                                    },
                                    enabled: true,
                                    onChanged: (_) {},
                                    keyboardType: TextInputType.number,
                                    textEditingController: priceController),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  AMAPTextConstants.category,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: AMAPColorConstants.greenGradient2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: DropdownButtonFormField<String>(
                                    value: categoryController,
                                    validator: ((value) {
                                      if ((value == null ||
                                              value ==
                                                  AMAPTextConstants
                                                      .createCategory) &&
                                          nouvellecategory.text.isEmpty) {
                                        return AMAPTextConstants
                                            .pickChooseCategory;
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
                                              color:
                                                  AMAPColorConstants.enabled)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(
                                              color: AMAPColorConstants.red)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: const BorderSide(
                                            color: AMAPColorConstants.greenGradient2,
                                          )),
                                    ),
                                    items: [
                                      AMAPTextConstants.createCategory,
                                      ...categories
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      categoryNotifier.setText(value ??
                                          AMAPTextConstants.createCategory);
                                      nouvellecategory.text = "";
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  AMAPTextConstants.createCategory,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: AMAPColorConstants.greenGradient2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextEntry(
                                  validator: ((value) {
                                    if ((value == null || value.isEmpty) &&
                                        categoryController ==
                                            AMAPTextConstants.createCategory) {
                                      return AMAPTextConstants
                                          .pickChooseCategory;
                                    }
                                    return null;
                                  }),
                                  enabled: categoryController ==
                                      AMAPTextConstants.createCategory,
                                  onChanged: (value) {
                                    nouvellecategory.text = value ?? "";
                                    nouvellecategory.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset:
                                                nouvellecategory.text.length));
                                  },
                                  textEditingController: nouvellecategory,
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                GestureDetector(
                                  child: GreenBtn(
                                    text: modifProduct ? AMAPTextConstants.update : AMAPTextConstants.add,
                                  ),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      String cate = categoryController ==
                                              AMAPTextConstants.createCategory
                                          ? nouvellecategory.text
                                          : categoryController;
                                      if (modifProduct) {
                                        Product newProduct = Product(
                                          id: products[productModif].id,
                                          name: nameController.text,
                                          price: double.parse(priceController
                                              .text
                                              .replaceAll(',', '.')),
                                          category: cate,
                                          quantity: 0,
                                        );
                                        tokenExpireWrapper(ref, () {
                                          productsNotifier
                                              .updateProduct(newProduct)
                                              .then((value) {
                                            if (value) {
                                              displayToast(context, TypeMsg.msg,
                                                  AMAPTextConstants.updatedProduct);
                                            } else {
                                              displayToast(
                                                  context,
                                                  TypeMsg.error,
                                                  AMAPTextConstants.updatingError);
                                            }
                                            pageNotifier
                                                .setAmapPage(AmapPage.admin);

                                            nameController.clear();
                                            priceController.clear();
                                            categoryNotifier.setText(
                                                AMAPTextConstants
                                                    .createCategory);
                                            nouvellecategory.clear();
                                          });
                                        });
                                      } else {
                                        Product newProduct = Product(
                                          id: const Uuid().v4(),
                                          name: nameController.text,
                                          price: double.parse(priceController
                                              .text
                                              .replaceAll(',', '.')),
                                          category: cate,
                                          quantity: 0,
                                        );
                                        tokenExpireWrapper(ref, () {
                                          productsNotifier
                                              .addProduct(newProduct)
                                              .then((value) {
                                            if (value) {
                                              displayToast(context, TypeMsg.msg,
                                                  AMAPTextConstants.addedProduct);
                                            } else {
                                              displayToast(
                                                  context,
                                                  TypeMsg.error,
                                                  AMAPTextConstants.addingError);
                                            }
                                            pageNotifier
                                                .setAmapPage(AmapPage.admin);

                                            nameController.clear();
                                            priceController.clear();
                                            categoryNotifier.setText(
                                                AMAPTextConstants
                                                    .createCategory);
                                            nouvellecategory.clear();
                                          });
                                        });
                                      }
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
