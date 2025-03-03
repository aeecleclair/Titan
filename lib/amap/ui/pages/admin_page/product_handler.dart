import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/providers/product_provider.dart';
import 'package:myecl/amap/providers/sorted_by_category_products.dart';
import 'package:myecl/amap/router.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/components/product_ui.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
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
        const AlignLeftText(
          padding: EdgeInsets.symmetric(horizontal: 30),
          AMAPTextConstants.products,
          color: AMAPColorConstants.textDark,
        ),
        const SizedBox(height: 10),
        HorizontalListView(
          height: 185,
          children: [
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                productNotifier.setProduct(
                  EmptyModels.empty<AppModulesAmapSchemasAmapProductComplete>(),
                );
                QR.to(
                  AmapRouter.root +
                      AmapRouter.admin +
                      AmapRouter.addEditProduct,
                );
              },
              child: CardLayout(
                height: 155,
                width: 100,
                colors: const [
                  AMAPColorConstants.lightGradient1,
                  AMAPColorConstants.lightGradient2,
                ],
                shadowColor: AMAPColorConstants.textDark.withValues(alpha: 0.3),
                child: const Center(
                  child: HeroIcon(
                    HeroIcons.plus,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
            products.isEmpty
                ? const Center(child: Text(AMAPTextConstants.noProduct))
                : Row(
                    children: products
                        .map(
                          (e) => ProductCard(
                            product: e,
                            quantity: 0,
                            onDelete: () async {
                              await showDialog(
                                context: context,
                                builder: (context) => CustomDialogBox(
                                  title: AMAPTextConstants.deleteProduct,
                                  descriptions: AMAPTextConstants
                                      .deleteProductDescription,
                                  onYes: () {
                                    tokenExpireWrapper(ref, () async {
                                      final value = await productsNotifier
                                          .deleteProduct(e.id);
                                      if (value) {
                                        displayToastWithContext(
                                          TypeMsg.msg,
                                          AMAPTextConstants.deletedProduct,
                                        );
                                      } else {
                                        displayToastWithContext(
                                          TypeMsg.error,
                                          AMAPTextConstants.productInDelivery,
                                        );
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                            onEdit: () {
                              productNotifier.setProduct(e);
                              QR.to(
                                AmapRouter.root +
                                    AmapRouter.admin +
                                    AmapRouter.addEditProduct,
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
