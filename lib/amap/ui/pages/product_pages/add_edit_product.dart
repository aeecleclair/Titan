import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:titan/amap/class/product.dart';
import 'package:titan/amap/providers/category_list_provider.dart';
import 'package:titan/amap/providers/product_provider.dart';
import 'package:titan/amap/providers/product_list_provider.dart';
import 'package:titan/amap/providers/selected_category_provider.dart';
import 'package:titan/amap/providers/selected_list_provider.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/amap/ui/amap.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

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
      text: isEdit ? product.price.toStringAsFixed(2).replaceAll('.', ',') : "",
    );
    final beginState = isEdit
        ? product.category
        : AppLocalizations.of(context)!.amapCreateCategory;
    final categoryController = ref.watch(selectedCategoryProvider(beginState));
    final categoryNotifier = ref.watch(
      selectedCategoryProvider(beginState).notifier,
    );
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
                const SizedBox(height: 10),
                AlignLeftText(
                  isEdit
                      ? AppLocalizations.of(context)!.amapEditProduct
                      : AppLocalizations.of(context)!.amapAddProduct,
                  color: AMAPColorConstants.green2,
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    Center(
                      child: TextEntry(
                        label: AppLocalizations.of(context)!.amapName,
                        controller: nameController,
                        color: AMAPColorConstants.greenGradient2,
                        enabledColor: AMAPColorConstants.enabled,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: TextEntry(
                        label: AppLocalizations.of(context)!.amapPrice,
                        isDouble: true,
                        color: AMAPColorConstants.greenGradient2,
                        enabledColor: AMAPColorConstants.enabled,
                        keyboardType: TextInputType.number,
                        controller: priceController,
                      ),
                    ),
                    const SizedBox(height: 30),
                    AlignLeftText(
                      AppLocalizations.of(context)!.amapCategory,
                      fontSize: 20,
                      color: AMAPColorConstants.greenGradient2,
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: DropdownButtonFormField<String>(
                        initialValue: categoryController,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AMAPColorConstants.enabled,
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AMAPColorConstants.red,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AMAPColorConstants.greenGradient2,
                            ),
                          ),
                        ),
                        items:
                            [
                              AppLocalizations.of(context)!.amapCreateCategory,
                              ...categories,
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (value) {
                          categoryNotifier.setText(
                            value ??
                                AppLocalizations.of(
                                  context,
                                )!.amapCreateCategory,
                          );
                          newCategory.text = "";
                        },
                      ),
                    ),
                    if (categoryController ==
                        AppLocalizations.of(context)!.amapCreateCategory) ...[
                      const SizedBox(height: 30),
                      Center(
                        child: TextEntry(
                          label: AppLocalizations.of(
                            context,
                          )!.amapCreateCategory,
                          noValueError: AppLocalizations.of(
                            context,
                          )!.amapPickChooseCategory,
                          enabled:
                              categoryController ==
                              AppLocalizations.of(context)!.amapCreateCategory,
                          onChanged: (value) {
                            newCategory.text = value;
                            newCategory.selection = TextSelection.fromPosition(
                              TextPosition(offset: newCategory.text.length),
                            );
                          },
                          color: AMAPColorConstants.greenGradient2,
                          enabledColor: AMAPColorConstants.enabled,
                          controller: newCategory,
                        ),
                      ),
                    ],
                    const SizedBox(height: 40),
                    WaitingButton(
                      waitingColor: AMAPColorConstants.background,
                      builder: (child) => AddEditButtonLayout(
                        colors: const [
                          AMAPColorConstants.greenGradient1,
                          AMAPColorConstants.greenGradient2,
                        ],
                        child: child,
                      ),
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          String cate =
                              categoryController ==
                                  AppLocalizations.of(
                                    context,
                                  )!.amapCreateCategory
                              ? newCategory.text
                              : categoryController;
                          Product newProduct = Product(
                            id: isEdit ? product.id : "",
                            name: nameController.text,
                            price: double.parse(
                              priceController.text.replaceAll(',', '.'),
                            ),
                            category: cate,
                            quantity: 0,
                          );
                          await tokenExpireWrapper(ref, () async {
                            final updatedProductMsg = isEdit
                                ? AppLocalizations.of(
                                    context,
                                  )!.amapUpdatedProduct
                                : AppLocalizations.of(
                                    context,
                                  )!.amapAddedProduct;
                            final addingErrorMsg = isEdit
                                ? AppLocalizations.of(
                                    context,
                                  )!.amapUpdatingError
                                : AppLocalizations.of(context)!.amapAddingError;
                            final value = isEdit
                                ? await productsNotifier.updateProduct(
                                    newProduct,
                                  )
                                : await productsNotifier.addProduct(newProduct);
                            if (value) {
                              if (isEdit) {
                                formKey.currentState!.reset();
                              } else {
                                ref
                                    .watch(selectedListProvider.notifier)
                                    .rebuild(
                                      products.maybeWhen(
                                        data: (data) => data,
                                        orElse: () => [],
                                      ),
                                    );
                              }
                              displayToastWithContext(
                                TypeMsg.msg,
                                updatedProductMsg,
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                addingErrorMsg,
                              );
                            }
                            QR.back();
                          });
                        }
                      },
                      child: Text(
                        isEdit
                            ? AppLocalizations.of(context)!.amapUpdate
                            : AppLocalizations.of(context)!.amapAdd,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AMAPColorConstants.background,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
