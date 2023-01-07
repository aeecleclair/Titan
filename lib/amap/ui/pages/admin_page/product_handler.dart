import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/providers/product_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/product_ui.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ProductHandler extends HookConsumerWidget {
  const ProductHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final productNotifier = ref.watch(productProvider.notifier);
    final products = ref.watch(productListProvider);
    final productsNotifier = ref.watch(productListProvider.notifier);
    return Column(
      children: [
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
            products.when(
              data: (data) => Row(
                children: data
                    .map(
                      (e) => ProductCard(
                        product: e,
                        onDelete: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomDialogBox(
                                    title: "Supprimer le produit",
                                    descriptions:
                                        "Voulez-vous vraiment supprimer ce produit?",
                                    onYes: () {
                                      tokenExpireWrapper(ref, () async {
                                        productsNotifier.deleteProduct(e);
                                      });
                                    },
                                  ));
                        },
                        onEdit: () {
                          productNotifier.setProduct(e);
                          pageNotifier.setAmapPage(AmapPage.addEditProduct);
                        },
                      ),
                    )
                    .toList(),
              ),
              error: (Object e, StackTrace? s) =>
                  Text("Error: ${e.toString()}"),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(
              width: 10,
            )
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
