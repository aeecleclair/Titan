import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/category_list_provider.dart';
import 'package:myecl/amap/providers/product_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/providers/selected_category_provider.dart';
import 'package:myecl/amap/providers/selected_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/amap.dart';
import 'package:myecl/amap/ui/components/amap_button.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:myecl/tools/ui/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditProduct extends HookConsumerWidget {
  const AddEditProduct({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final product = ref.watch(productProvider);
    final isEdit = product.id != Product.empty().id;
    final products = ref.watch(productListProvider);
    final productsNotifier = ref.watch(productListProvider.notifier);
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
    final newCategory = useTextEditingController(text: "");

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AmapTemplate(
      child: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
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
                      Center(
                        child: TextEntry(
                          label:
                          AMAPTextConstants.name,
                          controller: nameController,
                          color: AMAPColorConstants.greenGradient2,
                          enabledColor: AMAPColorConstants.enabled,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: TextEntry(
                            label: AMAPTextConstants.price,
                            isDouble: true,
                            color: AMAPColorConstants.greenGradient2,
                            enabledColor: AMAPColorConstants.enabled,
                            keyboardType: TextInputType.number,
                            controller: priceController),
                      ),
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
                      Center(
                        child: DropdownButtonFormField<String>(
                          value: categoryController,
                          validator: ((value) {
                            if ((value == null ||
                                    value ==
                                        AMAPTextConstants.createCategory) &&
                                newCategory.text.isEmpty) {
                              return AMAPTextConstants.pickChooseCategory;
                            }
                            return null;
                          }),
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AMAPColorConstants.enabled)),
                            errorBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AMAPColorConstants.red)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
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
                            categoryNotifier.setText(
                                value ?? AMAPTextConstants.createCategory);
                            newCategory.text = "";
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: TextEntry(
                          label: AMAPTextConstants.createCategory,
                          validator: ((value) {
                            if (categoryController ==
                                AMAPTextConstants.createCategory) {
                              return AMAPTextConstants.pickChooseCategory;
                            }
                            return null;
                          }),
                          enabled: categoryController ==
                              AMAPTextConstants.createCategory,
                          onChanged: (value) {
                            newCategory.text = value;
                            newCategory.selection = TextSelection.fromPosition(
                                TextPosition(offset: newCategory.text.length));
                          },
                          color: AMAPColorConstants.greenGradient2,
                          enabledColor: AMAPColorConstants.enabled,
                          controller: newCategory,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ShrinkButton(
                        waitingColor: AMAPColorConstants.background,
                        builder: (child) => GreenBtn(child: child),
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            String cate = categoryController ==
                                    AMAPTextConstants.createCategory
                                ? newCategory.text
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
                                  : await productsNotifier
                                      .addProduct(newProduct);
                              if (value) {
                                if (isEdit) {
                                  formKey.currentState!.reset();
                                  displayToastWithContext(TypeMsg.msg,
                                      AMAPTextConstants.updatedProduct);
                                } else {
                                  ref
                                      .watch(selectedListProvider.notifier)
                                      .rebuild(products.when(
                                          data: (data) => data,
                                          error: (e, s) => [],
                                          loading: () => []));
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
                              QR.back();
                            });
                          }
                        },
                        child: Text(
                          isEdit
                              ? AMAPTextConstants.update
                              : AMAPTextConstants.add,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AMAPColorConstants.background),
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
          )),
    );
  }
}
