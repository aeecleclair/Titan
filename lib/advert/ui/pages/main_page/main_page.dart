import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/advert_page_provider.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/advert/ui/pages/main_page/advert_card.dart';
import 'package:myecl/cinema/providers/main_page_index_provider.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(advertPageProvider.notifier);
    final initialPageNotifier = ref.watch(mainPageIndexProvider.notifier);
    final initialPage = ref.watch(mainPageIndexProvider);
    int currentPage = initialPage;
    final entries = [
      AdvertCard(onTap: () {
        pageNotifier.setAdvertPage(AdvertPage.detailFromMainPage);
      }),
      AdvertCard(onTap: () {
        pageNotifier.setAdvertPage(AdvertPage.detailFromMainPage);
      }),
      AdvertCard(onTap: () {
        pageNotifier.setAdvertPage(AdvertPage.detailFromMainPage);
      }),
      AdvertCard(onTap: () {
        pageNotifier.setAdvertPage(AdvertPage.detailFromMainPage);
      }),
      AdvertCard(onTap: () {
        pageNotifier.setAdvertPage(AdvertPage.detailFromMainPage);
      }),
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height - 117.4,
      child: Stack(
        children: [
          Refresher(
            onRefresh: () async {
              //await sessionListNotifier.loadSessions();
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ...entries,
              ],
            ),
          ),
          if (true)
            Positioned(
              bottom: 30,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  pageNotifier.setAdvertPage(AdvertPage.admin);
                  initialPageNotifier.setMainPageIndex(currentPage);
                },
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.orange, width: 1),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.orange.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5))
                      ]),
                  child: Row(
                    children: const [
                      HeroIcon(HeroIcons.userGroup,
                          color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      Text("Admin",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
