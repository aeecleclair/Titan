import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/cinema/providers/cinema_page_provider.dart';
import 'package:myecl/cinema/tools/constants.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(cinemaPageProvider);
    final pageNotifier = ref.watch(cinemaPageProvider.notifier);
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
                          case CinemaPage.main:
                            controllerNotifier.toggle();
                            break;
                          case CinemaPage.admin:
                            pageNotifier.setCinemaPage(CinemaPage.main);
                            break;
                          case CinemaPage.detailFromMainPage:
                            pageNotifier.setCinemaPage(CinemaPage.main);
                            break;
                          case CinemaPage.detailFromAdminPage:
                            pageNotifier.setCinemaPage(CinemaPage.admin);
                            break;
                          case CinemaPage.addEditSession:
                            pageNotifier.setCinemaPage(CinemaPage.admin);
                            break;
                        }
                      },
                      icon: HeroIcon(
                        page == CinemaPage.main
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: Colors.black,
                        size: 30,
                      ));
                },
              ),
            ),
            const Text(CinemaTextConstants.cinema,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            const SizedBox(
              width: 70,
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
