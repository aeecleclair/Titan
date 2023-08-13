import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/advert_page_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/advert/tools/constants.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(advertPageProvider);
    final pageNotifier = ref.watch(advertPageProvider.notifier);
    final selectedNotifier = ref.watch(announcerProvider.notifier);
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
                          case AdvertPage.main:
                            controllerNotifier.toggle();
                            break;
                          case AdvertPage.admin:
                            selectedNotifier.clearAnnouncer();
                            pageNotifier.setAdvertPage(AdvertPage.main);
                            break;
                          case AdvertPage.detailFromMainPage:
                            pageNotifier.setAdvertPage(AdvertPage.main);
                            break;
                          case AdvertPage.addRemAnnouncer:
                            pageNotifier.setAdvertPage(AdvertPage.main);
                            break;
                          case AdvertPage.detailFromAdminPage:
                            pageNotifier.setAdvertPage(AdvertPage.admin);
                            break;
                          case AdvertPage.addEditAdvert:
                            pageNotifier.setAdvertPage(AdvertPage.admin);
                            break;
                        }
                      },
                      icon: HeroIcon(
                        page == AdvertPage.main
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: Colors.black,
                        size: 30,
                      ));
                },
              ),
            ),
            const Text(AdvertTextConstants.advert,
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
