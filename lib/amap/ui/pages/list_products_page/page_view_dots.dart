import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/page_controller_provider.dart';
import 'package:myecl/amap/providers/sorted_delivery_product.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:myecl/tools/providers/theme_provider.dart';
import 'package:myecl/amap/tools/constants.dart';

class Dots extends HookConsumerWidget {
  const Dots({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(amapPageControllerProvider);
    final len = ref.watch(sortedByCategoryDeliveryProductsProvider).length;
    final isDarkTheme = ref.watch(themeProvider);
    return len > 0
        ? SmoothPageIndicator(
            controller: pageController,
            count: len,
            effect: WormEffect(
              dotColor: AMAPColors(isDarkTheme).background3,
              activeDotColor: AMAPColorConstants.enabled,
              dotWidth: 7,
              dotHeight: 7,
            ),
            onDotClicked: (index) {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate,
              );
            },
          )
        : const SizedBox();
  }
}
