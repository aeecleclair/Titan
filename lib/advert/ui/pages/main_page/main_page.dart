import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/advert/providers/advert_page_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/providers/is_user_admin_provider.dart';
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
    final selectedNotifier = ref.watch(announcerProvider.notifier);
    final isAdmin = ref.watch(isUserAdmin);
    return Expanded(
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
                    const AnnouncerBar(useUserAnnouncers: false),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                            children: data
                                .map((advert) => selected
                                            .where((e) => advert.announcer
                                                .contains(e.name))
                                            .isNotEmpty ||
                                        selected.isEmpty
                                    ? AdvertCard(
                                        onTap: () {
                                          advertNotifier.setAdvert(advert);
                                          pageNotifier.setAdvertPage(
                                              AdvertPage.detailFromMainPage);
                                        },
                                        advert: advert)
                                    : Container())
                                .toList())),
                    const SizedBox(
                      height: 20,
                    ),
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
          if (isAdmin)
            Positioned(
              bottom: 20,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  selectedNotifier.clearAnnounce();
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
                      border: Border.all(color: Colors.white, width: 1),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5))
                      ]),
                  child: const Row(
                    children: [
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
