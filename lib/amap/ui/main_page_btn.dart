import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/scroll_controller_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/top_button.dart';
import 'package:myecl/amap/providers/is_amap_admin_provider.dart';

class MainPageBtn extends HookConsumerWidget {
  const MainPageBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(amapPageProvider);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final isAdmin = ref.watch(isAmapAdminProvider);
    final hideAnimation = useAnimationController(
        duration: const Duration(milliseconds: 200), initialValue: 1);

    final scrollController = ref.watch(scrollControllerProvider(hideAnimation));
    List<Widget> btns = [
      TopButton(
          text: AMAPTextConstants.myOrders,
          selected: page == AmapPage.main,
          onclick: () {
            pageNotifier.setAmapPage(AmapPage.main);
          }),
      TopButton(
          text: AMAPTextConstants.presentation,
          selected: page == AmapPage.pres,
          onclick: () {
            pageNotifier.setAmapPage(AmapPage.pres);
          }),
    ];

    if (isAdmin) {
      btns.add(TopButton(
          text: AMAPTextConstants.admin,
          selected: page == AmapPage.admin,
          onclick: () {
            pageNotifier.setAmapPage(AmapPage.admin);
          }));
    }
    return isAdmin
        ? Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 100,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 100,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: btns,
                    ),
                  ),
                ),
                Positioned(
                  top: 35,
                  right: -5,
                  child: FadeTransition(
                      opacity: hideAnimation,
                      child: ScaleTransition(
                        scale: hideAnimation,
                        child: GestureDetector(
                            onTap: (() {
                              hideAnimation.animateTo(0);
                              scrollController.animateTo(200,
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.decelerate);
                            }),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: const [
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                              ),
                              alignment: Alignment.center,
                              child: HeroIcon(
                                HeroIcons.chevronDoubleRight,
                                size: 15,
                                color: AMAPColorConstants.background,
                              ),
                            )),
                      )),
                ),
              ],
            ))
        : Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 100,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: btns,
              ),
            ));
  }
}
