import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/is_admin.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/providers/is_advert_admin_provider.dart';
import 'package:myecl/advert/ui/pages/advert.dart';
import 'package:myecl/advert/ui/router.dart';
import 'package:myecl/advert/ui/tools/announcer_bar.dart';
import 'package:myecl/advert/ui/tools/advert_card.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/advert/tools/constants.dart';

class AdvertMainPage extends HookConsumerWidget {
  const AdvertMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertNotifier = ref.watch(advertProvider.notifier);
    final advertList = ref.watch(advertListProvider);
    final advertListNotifier = ref.watch(advertListProvider.notifier);
    final selected = ref.watch(announcerProvider);
    final selectedNotifier = ref.watch(announcerProvider.notifier);
    final isAdmin = ref.watch(isAdminProvider);
    final isAdvertAdmin = ref.watch(isAdvertAdminProvider);
    return AdvertTemplate(
      child: Stack(
        children: [
          Refresher(
            onRefresh: () async {
              await advertListNotifier.loadAdverts();
            },
            child: advertList.when(
              data: (advertData) {
                final sortedAdvertData =
                    advertData.sortedBy((element) => element.date).reversed;
                final filteredSortedadvertData = sortedAdvertData.where(
                    (advert) =>
                        selected
                            .where((e) => advert.announcer.name == e.name)
                            .isNotEmpty ||
                        selected.isEmpty);
                return Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (isAdvertAdmin)
                            GestureDetector(
                              onTap: () {
                                selectedNotifier.clearAnnouncer();
                                QR.to(AdvertRouter.root + AdvertRouter.admin);
                              },
                              child: Container(
                                width: 120,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade200
                                              .withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5))
                                    ]),
                                child: const Row(
                                  children: [
                                    HeroIcon(HeroIcons.userGroup,
                                        color: Colors.white, size: 20),
                                    SizedBox(width: 10),
                                    Text(AdvertTextConstants.admin,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          if (isAdmin)
                            GestureDetector(
                              onTap: () {
                                QR.to(AdvertRouter.root +
                                    AdvertRouter.addRemAnnoucer);
                              },
                              child: Container(
                                width: 130,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade200
                                              .withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5))
                                    ]),
                                child: const Row(
                                  children: [
                                    HeroIcon(HeroIcons.userGroup,
                                        color: Colors.white, size: 20),
                                    SizedBox(width: 10),
                                    Text(AdvertTextConstants.management,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const AnnouncerBar(
                        useUserAnnouncers: false, multipleSelect: true),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(children: [
                          ...filteredSortedadvertData.map(
                            (advert) => AdvertCard(
                                onTap: () {
                                  advertNotifier.setAdvert(advert);
                                  QR.to(
                                      AdvertRouter.root + AdvertRouter.detail);
                                },
                                advert: advert),
                          ),
                        ])),
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
        ],
      ),
    );
  }
}
