import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/cash_provider.dart';
import 'package:myecl/amap/providers/modified_product_index_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/green_btn.dart';
import 'package:myecl/amap/ui/pages/admin_page/produit_ui.dart';
import 'package:myecl/amap/ui/refresh_indicator.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsList = ref.watch(productListProvider);
    final productsListNotifier = ref.watch(productListProvider.notifier);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final productModif = ref.watch(modifiedProductProvider.notifier);
    ref.watch(cashProvider);
    final products = [];
    final categories = [];
    productsList.when(
      data: (list) => products.addAll(list),
      error: (e, s) {},
      loading: () {},
    );

    products.map((e) {
      if (!categories.contains(e.category)) {
        categories.add(e.category);
      }
    }).toList();

    Map<String, List<Widget>> dictCateListWidget = {
      for (var item in categories) item: []
    };

    for (Product p in products) {
      dictCateListWidget[p.category]!
          .add(ProductUi(p: p, i: products.indexOf(p)));
    }

    List<Widget> listWidget = [];

    for (String c in categories) {
      listWidget.add(Container(
          height: 70,
          alignment: Alignment.centerLeft,
          child: Container(
            height: 50,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              c,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          )));

      listWidget += dictCateListWidget[c] ?? [];
    }

    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstants.background2.withOpacity(0.5)),
            child: Refresh(
              keyRefresh: GlobalKey<RefreshIndicatorState>(),
              onRefresh: () async {
                productsListNotifier.loadProductList();
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    GestureDetector(
                        child: const GreenBtn(text: "Ajouter une commande"),
                        onTap: () {
                          productModif.setModifiedProduct(-1);
                          pageNotifier.setAmapPage(AmapPage.addCmd);
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                        child: const GreenBtn(text: "Gérer les comptes"),
                        onTap: () {
                          productModif.setModifiedProduct(-1);
                          pageNotifier.setAmapPage(AmapPage.solde);
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                        child: const GreenBtn(text: "Ajouter un produit"),
                        onTap: () {
                          productModif.setModifiedProduct(-1);
                          pageNotifier.setAmapPage(AmapPage.modif);
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    ...listWidget
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
