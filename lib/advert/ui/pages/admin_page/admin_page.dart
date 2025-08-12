import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/advert/class/advert.dart';
import 'package:titan/advert/providers/admin_advert_list_provider.dart';
import 'package:titan/advert/providers/advert_list_provider.dart';
import 'package:titan/advert/providers/advert_posters_provider.dart';
import 'package:titan/advert/providers/advert_provider.dart';
import 'package:titan/advert/providers/announcer_list_provider.dart';
import 'package:titan/advert/providers/announcer_provider.dart';
import 'package:titan/advert/providers/is_advert_admin_provider.dart';
import 'package:titan/advert/ui/components/special_action_button.dart';
import 'package:titan/advert/ui/pages/admin_page/admin_advert_card.dart';
import 'package:titan/advert/ui/pages/advert.dart';
import 'package:titan/advert/router.dart';
import 'package:titan/advert/ui/components/announcer_bar.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AdvertAdminPage extends HookConsumerWidget {
  const AdvertAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertNotifier = ref.watch(advertProvider.notifier);
    final isAdmin = ref.watch(isAdminProvider);
    final isAdvertAdmin = ref.watch(isAdvertAdminProvider);
    final advertList = isAdmin
        ? ref.watch(adminAdvertListProvider)
        : ref.watch(advertListProvider);
    final userAnnouncerListNotifier = ref.watch(
      userAnnouncerListProvider.notifier,
    );
    final userAnnouncerList = ref.watch(userAnnouncerListProvider);
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final selectedAnnouncers = ref.watch(announcerProvider);
    final selectedAnnouncersNotifier = ref.read(announcerProvider.notifier);
    final selectedNotifier = ref.read(announcerProvider.notifier);
    final userAnnouncersSync = userAnnouncerList.maybeWhen(
      orElse: () => [],
      data: (data) => data,
    );
    return AdvertTemplate(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AnnouncerBar(
                  useUserAnnouncers: !isAdmin,
                  multipleSelect: true,
                ),
              ),
              if (!isAdmin || isAdvertAdmin) ...[
                SizedBox(width: 5),
                Container(
                  width: 2,
                  height: 60,
                  color: ColorConstants.secondary,
                ),
                SizedBox(width: 5),
                SpecialActionButton(
                  onTap: () {
                    advertNotifier.setAdvert(Advert.empty());
                    if (userAnnouncersSync.length == 1 &&
                        selectedAnnouncers.isEmpty) {
                      selectedNotifier.addAnnouncer(userAnnouncersSync[0]);
                    }
                    QR.to(
                      AdvertRouter.root +
                          AdvertRouter.admin +
                          AdvertRouter.addEditAdvert,
                    );
                  },
                  icon: HeroIcon(
                    HeroIcons.plus,
                    color: ColorConstants.background,
                  ),
                  name: "Post",
                ),
                SizedBox(width: 10),
              ],
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
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
                  return Refresher(
                    controller: ScrollController(),
                    onRefresh: () async {
                      if (isAdmin) {
                        await ref
                            .watch(adminAdvertListProvider.notifier)
                            .loadAdverts();
                      }
                      await ref
                          .watch(advertListProvider.notifier)
                          .loadAdverts();
                      await userAnnouncerListNotifier.loadMyAnnouncerList();
                      advertPostersNotifier.resetTData();
                    },
                    child: Column(
                      children: [
                        ...filteredSortedUserAnnouncerAdverts.map(
                          (advert) => AdminAdvertCard(
                            onEdit: () {
                              QR.to(
                                AdvertRouter.root +
                                    AdvertRouter.admin +
                                    AdvertRouter.addEditAdvert,
                              );
                              advertNotifier.setAdvert(advert);
                              selectedAnnouncersNotifier.clearAnnouncer();
                              selectedAnnouncersNotifier.addAnnouncer(
                                advert.announcer,
                              );
                            },
                            onDelete: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialogBox(
                                    title: AppLocalizations.of(
                                      context,
                                    )!.advertDeleting,
                                    descriptions: AppLocalizations.of(
                                      context,
                                    )!.advertDeleteAdvert,
                                    onYes: () async {
                                      if (isAdmin) {
                                        await ref
                                            .watch(
                                              adminAdvertListProvider.notifier,
                                            )
                                            .deleteAdvert(advert);
                                      } else {
                                        await ref
                                            .watch(advertListProvider.notifier)
                                            .deleteAdvert(advert);
                                      }
                                      advertPostersNotifier.deleteE(
                                        advert.id,
                                        0,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            advert: advert,
                          ),
                        ),
                        SizedBox(height: 80),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
