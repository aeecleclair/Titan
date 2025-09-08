import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/providers/scroll_provider.dart';
import 'package:titan/amap/providers/sorted_delivery_product.dart';
import 'package:titan/amap/providers/page_controller_provider.dart';
import 'package:titan/amap/providers/scroll_controller_provider.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/amap/ui/pages/list_products_page/category_page.dart';
import 'package:titan/amap/ui/pages/list_products_page/web_page_navigation_button.dart';
import 'package:titan/drawer/providers/is_web_format_provider.dart';

class ListProducts extends HookConsumerWidget {
  const ListProducts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hideAnimation = useAnimationController(
      duration: const Duration(milliseconds: 200),
      initialValue: 1,
    );
    final scrollController = ref.watch(scrollControllerProvider(hideAnimation));
    final sortedDeliveryProductsList = ref.watch(
      sortedByCategoryDeliveryProductsProvider,
    );
    final scrollNotifier = ref.watch(scrollProvider.notifier);
    final pageController = ref.watch(amapPageControllerProvider);
    final isWebFormat = ref.watch(isWebFormatProvider);
    pageController.addListener(() {
      scrollNotifier.setScroll(pageController.page!);
    });

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
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
                      .map(
                        (c) => CategoryPage(
                          index: sortedDeliveryProductsList.keys
                              .toList()
                              .indexOf(c),
                          hideAnimation: hideAnimation,
                          category: c,
                        ),
                      )
                      .toList(),
          ),
        ),
        if (isWebFormat)
          Positioned(
            right: 20,
            bottom: 0,
            child: WebPageNavigationButton(
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
              },
              icon: HeroIcons.arrowRight,
            ),
          ),
        if (isWebFormat)
          Positioned(
            left: 20,
            bottom: 0,
            child: WebPageNavigationButton(
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
              },
              icon: HeroIcons.arrowLeft,
            ),
          ),
      ],
    );
  }
}
