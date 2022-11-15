import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/delivery_id_provider.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';
import 'package:myecl/amap/providers/modified_product_index_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ProductUi extends ConsumerWidget {
  final Product p;
  final int i;
  const ProductUi({Key? key, required this.p, required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryId = ref.watch(deliveryIdProvider);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

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
                p.name,
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
                    "${p.price.toStringAsFixed(2)}€",
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
                      gradient: const LinearGradient(colors: [
                        AMAPColorConstants.green1,
                        AMAPColorConstants.textLight
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color:
                                AMAPColorConstants.textLight.withOpacity(0.4),
                            offset: const Offset(2, 3),
                            blurRadius: 5)
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const HeroIcon(
                      HeroIcons.pencilSquare,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    final productModif =
                        ref.watch(modifiedProductProvider.notifier);
                    final pageNotifier = ref.watch(amapPageProvider.notifier);
                    productModif.setModifiedProduct(i);
                    pageNotifier.setAmapPage(AmapPage.modif);
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
                        AMAPColorConstants.redGradient1,
                        AMAPColorConstants.redGradient2
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            color: AMAPColorConstants.redGradient2
                                .withOpacity(0.4),
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
                            descriptions: AMAPTextConstants.deletingProduct,
                            title: AMAPTextConstants.deleting,
                            onYes: () async {
                              tokenExpireWrapper(ref, () async {
                                await ref
                                    .watch(
                                        deliveryProductListProvider(deliveryId)
                                            .notifier)
                                    .deleteProduct(p);
                                displayToastWithContext(TypeMsg.msg,
                                    AMAPTextConstants.deletedProduct);
                              });
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
