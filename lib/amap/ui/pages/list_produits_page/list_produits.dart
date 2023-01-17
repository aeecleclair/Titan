import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/scroll_provider.dart';
import 'package:myecl/amap/providers/sorted_delivery_product.dart';
import 'package:myecl/amap/providers/page_controller_provider.dart';
import 'package:myecl/amap/providers/scroll_controller_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/list_produits_page/category_page.dart';

class ListProducts extends HookConsumerWidget {
  const ListProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hideAnimation = useAnimationController(
        duration: const Duration(milliseconds: 200), initialValue: 1);
    final scrollController = ref.watch(scrollControllerProvider(hideAnimation));
    final sortedDeliveryProductsList =
        ref.watch(sortedByCategoryDeliveryProductsProvider);
    final scrollNotifier = ref.watch(scrollProvider.notifier);
    final pageController = ref.watch(amapPageControllerProvider);
    pageController.addListener(() {
      scrollNotifier.setScroll(pageController.page!);
    });

    return SizedBox(
      height: MediaQuery.of(context).size.height - 275,
      child: PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        onPageChanged: (index) {
          if (scrollController.positions.isNotEmpty) {
            scrollController.jumpTo(0);
          }

          hideAnimation.animateTo(1);
        },
        physics: const BouncingScrollPhysics(),
        children: sortedDeliveryProductsList.isEmpty
            ? [
                const Center(
                  child: Text(
                    AMAPTextConstants.noProduct,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]
            : sortedDeliveryProductsList.keys
                .map((c) => CategoryPage(
                    index: sortedDeliveryProductsList.keys.toList().indexOf(c),
                    hideAnimation: hideAnimation,
                    category: c))
                .toList(),
      ),
    );
  }
}
