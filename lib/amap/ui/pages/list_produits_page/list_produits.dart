import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/sorted_delivery_product.dart';
import 'package:myecl/amap/providers/page_controller_provider.dart';
import 'package:myecl/amap/providers/scroll_controller_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/list_produits_page/produit_ui_list.dart';

class ListProducts extends HookConsumerWidget {
  const ListProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hideAnimation = useAnimationController(
        duration: const Duration(milliseconds: 200), initialValue: 1);
    final scrollController = ref.watch(scrollControllerProvider(hideAnimation));
    final sortedDeliveryProductsList =
        ref.watch(sortedByCategoryDeliveryProductsProvider);
    final pageController = ref.watch(amapPageControllerProvider);

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
            : sortedDeliveryProductsList.keys.map((c) {
                double h = MediaQuery.of(context).size.height -
                    270 -
                    50 * (sortedDeliveryProductsList[c]!.length + 1);
                return Builder(
                  builder: (BuildContext context) {
                    List<Widget> listWidgetProduct = [
                      Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          c,
                          style: const TextStyle(
                            fontSize: 25,
                            color: AMAPColorConstants.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ];

                    listWidgetProduct += sortedDeliveryProductsList[c]!
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
                                      Radius.circular(25)),
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
                );
              }).toList(),
      ),
    );
  }
}
