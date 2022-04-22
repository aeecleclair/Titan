import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/modified_product_index_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/tools/dialog.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';

class ProductUi extends ConsumerWidget {
  final Product p;
  final int i;
  const ProductUi({Key? key, required this.p, required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: 55,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 20,
            ),
            Expanded(
              child: Text(
                p.nom,
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 15,
                ),
                Container(
                  width: 40,
                  alignment: Alignment.centerRight,
                  child: Text(
                    p.prix.toStringAsFixed(2) + "€",
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                Container(
                  width: 15,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [ColorConstants.l1, ColorConstants.textLight],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color: ColorConstants.textLight.withOpacity(0.4),
                            offset: const Offset(2, 3),
                            blurRadius: 5)
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const HeroIcon(
                      HeroIcons.pencilAlt,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    final productModif =
                        ref.watch(modifiedProductProvider.notifier);
                    final pageNotifier = ref.watch(amapPageProvider.notifier);
                    productModif.setModifiedProduct(i);
                    pageNotifier.setAmapPage(4);
                  },
                ),
                Container(
                  width: 15,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        ColorConstants.redGradient1,
                        ColorConstants.redGradient2
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color: ColorConstants.redGradient2.withOpacity(0.4),
                            offset: const Offset(2, 3),
                            blurRadius: 5)
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const HeroIcon(
                      HeroIcons.trash,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialogBox(
                            descriptions: "Supprimer le Product ?",
                            title: "Suppression",
                            onYes: () {
                              ref
                                  .watch(productListProvider.notifier)
                                  .deleteProduct(p.id);
                              displayToast(
                                  context, TypeMsg.msg, "Product supprimé");
                            }));
                  },
                )
              ],
            ),
            Container(
              width: 15,
            ),
          ],
        ));
  }
}
