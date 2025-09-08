import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/providers/scroll_controller_provider.dart';
import 'package:titan/amap/providers/scroll_provider.dart';
import 'package:titan/amap/providers/sorted_delivery_product.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/amap/ui/pages/list_products_page/product_ui_list.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';

class CategoryPage extends HookConsumerWidget {
  final String category;
  final int index;
  final AnimationController hideAnimation;
  const CategoryPage({
    super.key,
    required this.index,
    required this.hideAnimation,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortedDeliveryProductsList = ref.watch(
      sortedByCategoryDeliveryProductsProvider,
    );
    final scrollController = ref.watch(scrollControllerProvider(hideAnimation));

    final scroll = ref.watch(scrollProvider);

    double minScale = 0.8;
    double scale = 1;
    double maxHeight = MediaQuery.of(context).size.height - 295;
    double height = 0;

    if (index == scroll.floor()) {
      scale = 1 - (scroll - index) * (1 - minScale);
      height = maxHeight * (1 - scale) / 2;
    } else if (index == scroll.floor() + 1) {
      scale = minScale + (scroll - index + 1) * (1 - minScale);
      height = maxHeight * (1 - scale) / 2;
    } else if (index == scroll.floor() - 1) {
      scale = minScale + (scroll - index - 1) * (1 - minScale);
      height = maxHeight * (1 - scale) / 2;
    } else {
      scale = minScale;
      height = maxHeight * (1 - minScale) / 2;
    }

    double h =
        MediaQuery.of(context).size.height -
        270 -
        50 * (sortedDeliveryProductsList[category]!.length + 1);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: height),
          SizedBox(
            height: maxHeight * scale,
            child: Builder(
              builder: (BuildContext context) {
                List<Widget> listWidgetProduct = [
                  SizedBox(
                    height: 50,
                    child: AlignLeftText(
                      capitalize(category),
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 20,
                        right: 20,
                      ),
                      color: AMAPColorConstants.textDark,
                      fontSize: 25,
                    ),
                  ),
                ];

                listWidgetProduct += sortedDeliveryProductsList[category]!
                    .map((e) => ProductUiInList(p: e))
                    .toList();

                if (h < 0) {
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: scrollController,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10.0,
                              sigmaY: 10.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AMAPColorConstants.background2
                                    .withValues(alpha: 0.5),
                              ),
                              child: Column(children: listWidgetProduct),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height - 350,
                        left: (MediaQuery.of(context).size.width - 150) / 2,
                        child: FadeTransition(
                          opacity: hideAnimation,
                          child: ScaleTransition(
                            scale: hideAnimation,
                            child: GestureDetector(
                              onTap: () {
                                hideAnimation.animateTo(0);

                                scrollController.animateTo(
                                  -h + 5,
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.decelerate,
                                );
                              },
                              child: Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AMAPColorConstants.green1,
                                      AMAPColorConstants.green2,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AMAPColorConstants.green2
                                          .withValues(alpha: 0.4),
                                      offset: const Offset(2, 3),
                                      blurRadius: 5,
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    HeroIcon(
                                      HeroIcons.chevronDoubleDown,
                                      size: 15,
                                      color: AMAPColorConstants.background,
                                    ),
                                    Text(
                                      AMAPTextConstants.seeMore,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AMAPColorConstants.background,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AMAPColorConstants.background2.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        child: Column(children: listWidgetProduct),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
