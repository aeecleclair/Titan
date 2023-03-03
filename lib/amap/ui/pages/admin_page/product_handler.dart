import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/providers/product_provider.dart';
import 'package:myecl/amap/providers/sorted_by_category_products.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/product_ui.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ProductHandler extends HookConsumerWidget {
  const ProductHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final productNotifier = ref.watch(productProvider.notifier);
    final sortedByCategoryProducts =
        ref.watch(sortedByCategoryProductsProvider);
    final products = sortedByCategoryProducts.values
        .toList()
        .expand((element) => element)
        .toList();
    final productsNotifier = ref.watch(productListProvider.notifier);

    final outerController = useScrollController();
    final innerController = useScrollController();

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Column(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.centerLeft,
        child: const Text("Produits",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AMAPColorConstants.textDark)),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
          height: 150,
          child: ListView(
            controller: outerController,
            clipBehavior: Clip.none,
            children: [
              Listener(
                onPointerSignal: (event) {
                  if (event is PointerScrollEvent) {
                    final offset = event.scrollDelta.dy;
                    innerController.jumpTo(innerController.offset + offset);
                    outerController.jumpTo(outerController.offset - offset);
                  }
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: innerController,
                  clipBehavior: Clip.none,
                  physics: const BouncingScrollPhysics(),
                  child: Row(children: [
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        productNotifier.setProduct(Product.empty());
                        pageNotifier.setAmapPage(AmapPage.addEditProduct);
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: 5.0, bottom: 10),
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            width: 100,
                            height: 145,
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
                                  color: AMAPColorConstants.textDark
                                      .withOpacity(0.3),
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
                            child: Text("Aucun produit"),
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
                                                title: "Supprimer le produit",
                                                descriptions:
                                                    "Voulez-vous vraiment supprimer ce produit?",
                                                onYes: () {
                                                  tokenExpireWrapper(ref,
                                                      () async {
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
                                      pageNotifier
                                          .setAmapPage(AmapPage.addEditProduct);
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
          ))
    ]);
  }
}
