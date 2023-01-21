import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/scroll_controller_provider.dart';
import 'package:myecl/amap/providers/scroll_provider.dart';
import 'package:myecl/amap/providers/sorted_delivery_product.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/list_produits_page/produit_ui_list.dart';
import 'package:myecl/tools/functions.dart';

class CategoryPage extends HookConsumerWidget {
  final String category;
  final int index;
  final AnimationController hideAnimation;
  const CategoryPage(
      {Key? key,
      required this.index,
      required this.hideAnimation,
      required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortedDeliveryProductsList =
        ref.watch(sortedByCategoryDeliveryProductsProvider);
    final scrollController = ref.watch(scrollControllerProvider(hideAnimation));

    final scroll = ref.watch(scrollProvider);

    double minScale = 0.8;
    double scale = 1;
    double maxHeigth = MediaQuery.of(context).size.height - 295;
    double height = 0;

    if (index == scroll.floor()) {
      scale = 1 - (scroll - index) * (1 - minScale);
      height = maxHeigth * (1 - scale) / 2;
    } else if (index == scroll.floor() + 1) {
      scale = minScale + (scroll - index + 1) * (1 - minScale);
      height = maxHeigth * (1 - scale) / 2;
    } else if (index == scroll.floor() - 1) {
      scale = minScale + (scroll - index - 1) * (1 - minScale);
      height = maxHeigth * (1 - scale) / 2;
    } else {
      scale = minScale;
      height = maxHeigth * (1 - minScale) / 2;
    }

    double h = MediaQuery.of(context).size.height -
        270 -
        50 * (sortedDeliveryProductsList[category]!.length + 1);
    return Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: height,
            ),
            SizedBox(
              height: maxHeigth * scale,
              child: Builder(
                builder: (BuildContext context) {
                  List<Widget> listWidgetProduct = [
                    Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding:
                          const EdgeInsets.only(left: 20, top: 20, right: 20),
                      child: Text(
                        capitalize(category),
                        style: const TextStyle(
                          fontSize: 25,
                          color: AMAPColorConstants.textDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10.0, sigmaY: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AMAPColorConstants.background2
                                            .withOpacity(0.5),
                                      ),
                                      child: Column(
                                        children: listWidgetProduct,
                                      ),
                                    )))),
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

                                    scrollController.animateTo(-h + 5,
                                        duration:
                                            const Duration(milliseconds: 350),
                                        curve: Curves.decelerate);
                                  },
                                  child: Container(
                                      width: 150,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            colors: [
                                              AMAPColorConstants.green1,
                                              AMAPColorConstants.green2
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AMAPColorConstants.green2
                                                  .withOpacity(0.4),
                                              offset: const Offset(2, 3),
                                              blurRadius: 5)
                                        ],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          HeroIcon(
                                            HeroIcons.chevronDoubleDown,
                                            size: 15,
                                            color:
                                                AMAPColorConstants.background,
                                          ),
                                          Text(AMAPTextConstants.seeMore,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: AMAPColorConstants
                                                    .background,
                                              )),
                                        ],
                                      )),
                                )),
                          ),
                        )
                      ],
                    );
                  } else {
                    return ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: AMAPColorConstants.background2
                                      .withOpacity(0.5),
                                ),
                                child: Column(children: listWidgetProduct))));
                  }
                },
              ),
            ),
          ],
        ));
  }
}
