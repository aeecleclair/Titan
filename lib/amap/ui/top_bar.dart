import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(amapPageProvider);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: Builder(
                builder: (BuildContext appBarContext) {
                  return IconButton(
                      onPressed: () {
                        switch (page) {
                          case AmapPage.main:
                            controllerNotifier.toggle();
                            break;
                          case AmapPage.pres:
                            pageNotifier.setAmapPage(AmapPage.main);
                            break;
                          case AmapPage.addProducts:
                            pageNotifier.setAmapPage(AmapPage.main);
                            break;
                          case AmapPage.admin:
                            pageNotifier.setAmapPage(AmapPage.main);
                            break;
                          case AmapPage.addEditProduct:
                            pageNotifier.setAmapPage(AmapPage.admin);
                            break;
                          case AmapPage.addEditDelivery:
                            pageNotifier.setAmapPage(AmapPage.admin);
                            break;
                          case AmapPage.detailPage:
                            pageNotifier.setAmapPage(AmapPage.main);
                            break;
                        }
                      },
                      icon: HeroIcon(
                        page == AmapPage.main
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: Colors.black,
                        size: 30,
                      ));
                },
              ),
            ),
            const Text(
              AMAPTextConstants.amap,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 70,
              child: page == AmapPage.main
                  ? IconButton(
                      onPressed: () {
                        pageNotifier.setAmapPage(AmapPage.pres);
                      },
                      icon: const HeroIcon(
                        HeroIcons.informationCircle,
                        color: Colors.black,
                        size: 40,
                      ))
                  : Container(),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
