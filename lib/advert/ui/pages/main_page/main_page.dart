import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/advert/providers/advert_page_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/ui/tools/announcer_bar.dart';
import 'package:myecl/advert/ui/tools/advert_card.dart';
import 'package:myecl/tools/ui/refresher.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertNotifier = ref.watch(advertProvider.notifier);
    final pageNotifier = ref.watch(advertPageProvider.notifier);
    final advertList = ref.watch(advertListProvider);
    final advertListNotifier = ref.watch(advertListProvider.notifier);
    final selected = ref.watch(announcerProvider);
    return SizedBox(
      height: MediaQuery.of(context).size.height - 117.4,
      child: Stack(
        children: [
          Refresher(
            onRefresh: () async {
              await advertListNotifier.loadAdverts();
            },
            child: advertList.when(
              data: (data) {
                return Column(
                  children: [
                    const AnnouncerBar(useUserAnnouncers:false),
                    const SizedBox(
                      height: 20,
                    ),
                    ...data
                        .map((advert) => selected
                                    .where(
                                        (e) => advert.announcer.contains(e.name))
                                    .isNotEmpty ||
                                selected.isEmpty
                            ? AdvertCard(
                            onTap: () {
                              advertNotifier.setAdvert(advert);
                              pageNotifier
                                  .setAdvertPage(AdvertPage.detailFromMainPage);
                            },
                            advert: advert)
                            : Container())
                        .toList()
                  ],
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              error: (error, stackTrace) {
                return Center(
                  child: Text(error.toString()),
                );
              },
            ),
          ),
          if (true)
            Positioned(
              bottom: 30,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  pageNotifier.setAdvertPage(AdvertPage.admin);
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
