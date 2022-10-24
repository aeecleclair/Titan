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
    String error = "";
    productsList.when(
      data: (list) => products.addAll(list),
      error: (Object e, StackTrace? s) {
        error = e.toString();
      },
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

      listWidget += dictCateListWidget[c] ??
          [
            Container(
              height: 70,
              alignment: Alignment.centerLeft,
              child: Container(
                height: 50,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  error.isEmpty ? AMAPTextConstants.loading : error,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ];
    }

    return AmapRefresher(
      onRefresh: () async {
        await productsListNotifier.loadProductList();
      },
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Container(
            decoration: BoxDecoration(
                color: AMAPColorConstants.background2.withOpacity(0.5)),
            child: Column(
              children: [
                GestureDetector(
                    child:
                        const GreenBtn(text: AMAPTextConstants.handlingAccount),
                    onTap: () {
                      productModif.setModifiedProduct(-1);
                      pageNotifier.setAmapPage(AmapPage.solde);
                    }),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                    child: const GreenBtn(
                        text: AMAPTextConstants.deliveryHandling),
                    onTap: () {
                      productModif.setModifiedProduct(-1);
                      pageNotifier.setAmapPage(AmapPage.deliveryAdmin);
                    }),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                    child:
                        const GreenBtn(text: AMAPTextConstants.addingProduct),
                    onTap: () {
                      productModif.setModifiedProduct(-1);
                      pageNotifier.setAmapPage(AmapPage.modif);
                    }),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                    child:
                        const GreenBtn(text: AMAPTextConstants.addingACommand),
                    onTap: () {
                      productModif.setModifiedProduct(-1);
                      pageNotifier.setAmapPage(AmapPage.addCmd);
                    }),
                const SizedBox(
                  height: 40,
                ),
                ...listWidget
              ],
            ),
          ),
        ],
      ),
    );
  }
}
