import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/advert/providers/advert_list_provider.dart';
import 'package:titan/advert/providers/advert_posters_provider.dart';
import 'package:titan/advert/providers/announcer_provider.dart';
import 'package:titan/advert/providers/is_advert_admin_provider.dart';
import 'package:titan/advert/ui/pages/advert.dart';
import 'package:titan/advert/router.dart';
import 'package:titan/advert/ui/components/announcer_bar.dart';
import 'package:titan/advert/ui/pages/main_page/advert_card.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdvertMainPage extends HookConsumerWidget {
  const AdvertMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertList = ref.watch(advertListProvider);
    final advertListNotifier = ref.watch(advertListProvider.notifier);
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final selected = ref.watch(announcerProvider);
    final selectedNotifier = ref.watch(announcerProvider.notifier);
    final isAdmin = ref.watch(isAdvertAdminProvider);
    return AdvertTemplate(
      child: Column(
        children: [
          const AnnouncerBar(useUserAnnouncers: false, multipleSelect: true),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Annonces",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.title,
                  ),
                ),
                if (isAdmin)
                  CustomIconButton(
                    icon: HeroIcon(
                      HeroIcons.userGroup,
                      color: ColorConstants.background,
                    ),
                    onPressed: () {
                      selectedNotifier.clearAnnouncer();
                      QR.to(AdvertRouter.root + AdvertRouter.admin);
                    },
                  ),
              ],
            ),
          ),

          Expanded(
            child: AsyncChild(
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
                return Refresher(
                  onRefresh: () async {
                    await advertListNotifier.loadAdverts();
                    advertPostersNotifier.resetTData();
                  },
                  child: Column(
                    children: [
                      ...filteredSortedAdvertData.map(
                        (advert) => AdvertCard(
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
        ],
      ),
    );
  }
}
