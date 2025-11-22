import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/advert/providers/advert_list_provider.dart';
import 'package:titan/advert/providers/advert_posters_provider.dart';
import 'package:titan/advert/providers/advert_provider.dart';
import 'package:titan/advert/providers/announcer_provider.dart';
import 'package:titan/advert/providers/is_advert_admin_provider.dart';
import 'package:titan/advert/ui/pages/advert.dart';
import 'package:titan/advert/router.dart';
import 'package:titan/advert/ui/components/announcer_bar.dart';
import 'package:titan/advert/ui/components/advert_card.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/column_refresher.dart';
import 'package:titan/tools/ui/widgets/admin_button.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/advert/tools/constants.dart';

class AdvertMainPage extends HookConsumerWidget {
  const AdvertMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertNotifier = ref.watch(advertProvider.notifier);
    final advertList = ref.watch(advertListProvider);
    final advertListNotifier = ref.watch(advertListProvider.notifier);
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final selected = ref.watch(announcerProvider);
    final selectedNotifier = ref.watch(announcerProvider.notifier);
    final isAdmin = ref.watch(isAdminProvider);
    final isAdvertAdmin = ref.watch(isAdvertiserProvider);
    return AdvertTemplate(
      child: Stack(
        children: [
          AsyncChild(
            value: advertList,
            builder: (context, advertData) {
              final sortedAdvertData = advertData
                  .sortedBy((element) => element.date)
                  .reversed;
              final filteredSortedAdvertData = sortedAdvertData.where(
                (advert) =>
                    selected
                        .where((e) => advert.announcer.name == e.name)
                        .isNotEmpty ||
                    selected.isEmpty,
              );
              return ColumnRefresher(
                onRefresh: () async {
                  await advertListNotifier.loadAdverts();
                  advertPostersNotifier.resetTData();
                },
                children: [
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (isAdvertAdmin)
                          AdminButton(
                            onTap: () {
                              selectedNotifier.clearAnnouncer();
                              QR.to(AdvertRouter.root + AdvertRouter.admin);
                            },
                          ),
                        if (isAdmin)
                          AdminButton(
                            onTap: () {
                              QR.to(
                                AdvertRouter.root +
                                    AdvertRouter.addRemAnnouncer,
                              );
                            },
                            text: AdvertTextConstants.management,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const AnnouncerBar(
                    useUserAnnouncers: false,
                    multipleSelect: true,
                  ),
                  const SizedBox(height: 20),
                  ...filteredSortedAdvertData.map(
                    (advert) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: AdvertCard(
                        onTap: () {
                          advertNotifier.setAdvert(advert);
                          QR.to(AdvertRouter.root + AdvertRouter.detail);
                        },
                        advert: advert,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
