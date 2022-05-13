import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/page_controller_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Dots extends HookConsumerWidget {
  const Dots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider.notifier).lastLoadedProducts;
    final pageController = ref.watch(amapPageControllerProvider);
    int len = {...products.map((e) => e.categorie)}.length;
    return SmoothPageIndicator(
      controller: pageController,
      count: len,
      effect: WormEffect(
          dotColor: ColorConstants.background3,
          activeDotColor: ColorConstants.enabled,
          dotWidth: 7,
          dotHeight: 7),
      onDotClicked: (index) {
        pageController.animateToPage(index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate);
      },
    );
  }
}
