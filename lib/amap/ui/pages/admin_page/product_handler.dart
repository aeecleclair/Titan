import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/providers/product_provider.dart';
import 'package:myecl/amap/providers/sorted_by_category_products.dart';
import 'package:myecl/amap/router.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/components/product_ui.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/horizontal_list_view.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ProductHandler extends HookConsumerWidget {
  const ProductHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productNotifier = ref.read(productProvider.notifier);
    final sortedByCategoryProducts =
        ref.watch(sortedByCategoryProductsProvider);
    final products = sortedByCategoryProducts.values
        .toList()
        .expand((element) => element)
        .toList();
    final productsNotifier = ref.read(productListProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text(AMAPTextConstants.products,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AMAPColorConstants.textDark)),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 185,
          child: HorizontalListView(
            child: Row(children: [
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  productNotifier.setProduct(Product.empty());
                  QR.to(AmapRouter.root +
                      AmapRouter.admin +
                      AmapRouter.addEditProduct);
                },
                child: Container(
                    height: 185,
                    margin: const EdgeInsets.only(left: 5.0, bottom: 10),
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        gradient: const RadialGradient(
                          colors: [
                            Color.fromARGB(223, 182, 212, 10),
                            Color.fromARGB(255, 108, 147, 0),
                          ],
                          center: Alignment.topLeft,
                          radius: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: AMAPColorConstants.textDark.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: HeroIcon(
                          HeroIcons.plus,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    )),
              ),
              products.isEmpty
                  ? const Center(
                      child: Text(AMAPTextConstants.noProduct),
                    )
                  : Row(
                      children: products
                          .map(
                            (e) => ProductCard(
                              product: e,
                              onDelete: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) => CustomDialogBox(
                                          title:
                                              AMAPTextConstants.deleteProduct,
                                          descriptions: AMAPTextConstants
                                              .deleteProductDescription,
                                          onYes: () {
                                            tokenExpireWrapper(ref, () async {
                                              final value =
                                                  await productsNotifier
                                                      .deleteProduct(e);
                                              if (value) {
                                                displayToastWithContext(
                                                    TypeMsg.msg,
                                                    AMAPTextConstants
                                                        .deletedProduct);
                                              } else {
                                                displayToastWithContext(
                                                    TypeMsg.error,
                                                    AMAPTextConstants
                                                        .productInDelivery);
                                              }
                                            });
                                          },
                                        ));
                              },
                              onEdit: () {
                                productNotifier.setProduct(e);
                                QR.to(AmapRouter.root +
                                    AmapRouter.admin +
                                    AmapRouter.addEditProduct);
                              },
                            ),
                          )
                          .toList(),
                    ),
              const SizedBox(
                width: 10,
              )
            ]),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
