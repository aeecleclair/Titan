import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/category_list_provider.dart';
import 'package:myecl/amap/providers/product_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/providers/selected_category_provider.dart';
import 'package:myecl/amap/providers/selected_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/green_btn.dart';
import 'package:myecl/amap/ui/pages/product_pages/text_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class AddEditProduct extends HookConsumerWidget {
  const AddEditProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final product = ref.watch(productProvider);
    final isEdit = product.id != Product.empty().id;
    final products = ref.watch(productListProvider);
    final productsNotifier = ref.watch(productListProvider.notifier);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final categories = ref.watch(categoryListProvider);
    final nameController = useTextEditingController(text: product.name);
    final priceController = useTextEditingController(
        text: isEdit
            ? product.price.toStringAsFixed(2).replaceAll('.', ',')
            : "");
    final beginState =
        isEdit ? product.category : AMAPTextConstants.createCategory;
    final categoryController = ref.watch(selectedCategoryProvider(beginState));
    final categoryNotifier =
        ref.watch(selectedCategoryProvider(beginState).notifier);
    final nouvellecategory = useTextEditingController(text: "");

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isEdit
                        ? AMAPTextConstants.editProduct
                        : AMAPTextConstants.addProduct,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: AMAPColorConstants.green2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
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
                            return AMAPTextConstants.expectingNumber;
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
                                  value == AMAPTextConstants.createCategory) &&
                              nouvellecategory.text.isEmpty) {
                            return AMAPTextConstants.pickChooseCategory;
                          }
                          return null;
                        }),
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AMAPColorConstants.enabled)),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 201, 23, 23))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: AMAPColorConstants.greenGradient2,
                          )),
                        ),
                        items: [AMAPTextConstants.createCategory, ...categories]
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          categoryNotifier.setText(
                              value ?? AMAPTextConstants.createCategory);
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
                          return AMAPTextConstants.pickChooseCategory;
                        }
                        return null;
                      }),
                      enabled: categoryController ==
                          AMAPTextConstants.createCategory,
                      onChanged: (value) {
                        nouvellecategory.text = value ?? "";
                        nouvellecategory.selection = TextSelection.fromPosition(
                            TextPosition(offset: nouvellecategory.text.length));
                      },
                      textEditingController: nouvellecategory,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ShrinkButton(
                      waitChild: const GreenBtn(
                        text: AMAPTextConstants.waiting,
                      ),
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          String cate = categoryController ==
                                  AMAPTextConstants.createCategory
                              ? nouvellecategory.text
                              : categoryController;
                          Product newProduct = Product(
                            id: isEdit ? product.id : "",
                            name: nameController.text,
                            price: double.parse(
                                priceController.text.replaceAll(',', '.')),
                            category: cate,
                            quantity: 0,
                          );
                          await tokenExpireWrapper(ref, () async {
                            final value = isEdit
                                ? await productsNotifier
                                    .updateProduct(newProduct)
                                : await productsNotifier.addProduct(newProduct);
                            if (value) {
                              if (isEdit) {
                                formKey.currentState!.reset();
                                displayToastWithContext(TypeMsg.msg,
                                    AMAPTextConstants.updatedProduct);
                              } else {
                                ref.watch(selectedListProvider.notifier).rebuild(
                                  products.when(data: (data) => data, error: (e, s) => [], loading: () =>[])
                                );
                                displayToastWithContext(TypeMsg.msg,
                                    AMAPTextConstants.addedProduct);
                              }
                            } else {
                              if (isEdit) {
                                displayToastWithContext(TypeMsg.error,
                                    AMAPTextConstants.updatingError);
                              } else {
                                displayToastWithContext(TypeMsg.error,
                                    AMAPTextConstants.addingError);
                              }
                            }
                            pageNotifier.setAmapPage(AmapPage.admin);
                          });
                        }
                      },
                      child: GreenBtn(
                        text: isEdit
                            ? AMAPTextConstants.update
                            : AMAPTextConstants.add,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
