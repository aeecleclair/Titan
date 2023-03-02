import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(tombolaPageProvider);
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
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
                          case TombolaPage.main:
                            controllerNotifier.toggle();
                            break;
                          case TombolaPage.addEditLots:
                            pageNotifier.setTombolaPage(TombolaPage.addEdit);
                            break;
                          case TombolaPage.tombola:
                            pageNotifier.setTombolaPage(TombolaPage.main);
                            break;
                          case TombolaPage.achats:
                            pageNotifier.setTombolaPage(TombolaPage.tombola);
                            break;
                          case TombolaPage.admin:
                            pageNotifier.setTombolaPage(TombolaPage.main);
                            break;
                          case TombolaPage.addEditTypeTickets:
                            pageNotifier.setTombolaPage(TombolaPage.addEdit);
                            break;
                          case TombolaPage.simuTombola:
                            pageNotifier.setTombolaPage(TombolaPage.simuTombola);
                            break;
                          case TombolaPage.addEdit:
                            pageNotifier.setTombolaPage(TombolaPage.create);
                            break;
                          case TombolaPage.create:
                            pageNotifier.setTombolaPage(TombolaPage.main);
                            break;
                        }
                      },
                      icon: HeroIcon(
                        page == TombolaPage.main
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: Colors.black,
                        size: 30,
                      ));
                },
              ),
            ),
            const Text(TombolaTextConstants.raffle,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
      ],
    );
  }
}
