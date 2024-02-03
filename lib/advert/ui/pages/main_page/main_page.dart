import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/is_admin_provider.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/providers/is_advert_admin_provider.dart';
import 'package:myecl/advert/ui/pages/advert.dart';
import 'package:myecl/advert/router.dart';
import 'package:myecl/advert/ui/components/announcer_bar.dart';
import 'package:myecl/advert/ui/components/advert_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/column_refresher.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
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
          ColumnRefresher(
            onRefresh: () async {
              await advertListNotifier.loadAdverts();
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
                            QR.to(AdvertRouter.root +
                                AdvertRouter.addRemAnnouncer);
                          },
                          text: AdvertTextConstants.management),
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
                              selected.isEmpty);
                      return Column(children: [
                        ...filteredSortedAdvertData.map(
                          (advert) => AdvertCard(
                              onTap: () {
                                advertNotifier.setAdvert(advert);
                                QR.to(AdvertRouter.root + AdvertRouter.detail);
                              },
                              advert: advert),
                        ),
                      ]);
                    },
                  )),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
