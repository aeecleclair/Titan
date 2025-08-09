import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/advert/class/advert.dart';
import 'package:titan/advert/providers/advert_list_provider.dart';
import 'package:titan/advert/providers/advert_posters_provider.dart';
import 'package:titan/advert/providers/advert_provider.dart';
import 'package:titan/advert/providers/announcer_list_provider.dart';
import 'package:titan/advert/providers/announcer_provider.dart';
import 'package:titan/advert/ui/pages/admin_page/admin_advert_card.dart';
import 'package:titan/advert/ui/pages/advert.dart';
import 'package:titan/advert/router.dart';
import 'package:titan/advert/ui/components/announcer_bar.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/layouts/column_refresher.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AdvertAdminPage extends HookConsumerWidget {
  const AdvertAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertNotifier = ref.watch(advertProvider.notifier);
    final advertList = ref.watch(advertListProvider);
    final userAnnouncerListNotifier = ref.watch(
      userAnnouncerListProvider.notifier,
    );
    final userAnnouncerList = ref.watch(userAnnouncerListProvider);
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final advertListNotifier = ref.watch(advertListProvider.notifier);
    final selectedAnnouncers = ref.watch(announcerProvider);
    final selectedAnnouncersNotifier = ref.read(announcerProvider.notifier);
    return AdvertTemplate(
      child: AsyncChild(
        value: advertList,
        builder: (context, advertData) => AsyncChild(
          value: userAnnouncerList,
          builder: (context, userAnnouncerData) {
            final userAnnouncerAdvert = advertData.where(
              (advert) => userAnnouncerData
                  .where((element) => advert.announcer.id == element.id)
                  .isNotEmpty,
            );
            final sortedUserAnnouncerAdverts = userAnnouncerAdvert
                .toList()
                .sortedBy((element) => element.date)
                .reversed;
            final filteredSortedUserAnnouncerAdverts =
                sortedUserAnnouncerAdverts
                    .where(
                      (advert) =>
                          selectedAnnouncers
                              .where((e) => advert.announcer.id == e.id)
                              .isNotEmpty ||
                          selectedAnnouncers.isEmpty,
                    )
                    .toList();
            return ColumnRefresher(
              onRefresh: () async {
                await advertListNotifier.loadAdverts();
                await userAnnouncerListNotifier.loadMyAnnouncerList();
                advertPostersNotifier.resetTData();
              },
              children: [
                const AnnouncerBar(
                  useUserAnnouncers: true,
                  multipleSelect: true,
                ),
                GestureDetector(
                  onTap: () {
                    advertNotifier.setAdvert(Advert.empty());
                    QR.to(
                      AdvertRouter.root +
                          AdvertRouter.admin +
                          AdvertRouter.addEditAdvert,
                    );
                  },
                  child: CardLayout(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                      top: 20,
                      left: 30,
                      right: 30,
                    ),
                    width: 300,
                    height: 100,
                    colors: [Colors.white, Colors.grey.shade100],
                    shadowColor: Colors.grey.withValues(alpha: 0.2),
                    child: Center(
                      child: HeroIcon(
                        HeroIcons.plus,
                        size: 40,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
                ...filteredSortedUserAnnouncerAdverts.map(
                  (advert) => AdminAdvertCard(
                    onTap: () {
                      advertNotifier.setAdvert(advert);
                      QR.to(AdvertRouter.root + AdvertRouter.detail);
                    },
                    onEdit: () {
                      QR.to(
                        AdvertRouter.root +
                            AdvertRouter.admin +
                            AdvertRouter.addEditAdvert,
                      );
                      advertNotifier.setAdvert(advert);
                      selectedAnnouncersNotifier.clearAnnouncer();
                      selectedAnnouncersNotifier.addAnnouncer(advert.announcer);
                    },
                    onDelete: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialogBox(
                            title: AppLocalizations.of(context)!.advertDeleting,
                            descriptions: AppLocalizations.of(
                              context,
                            )!.advertDeleteAdvert,
                            onYes: () {
                              advertListNotifier.deleteAdvert(advert);
                              advertPostersNotifier.deleteE(advert.id, 0);
                            },
                          );
                        },
                      );
                    },
                    advert: advert,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
