import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/is_admin_provider.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/advert/providers/advert_posters_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/advertiser_provider.dart';
import 'package:myecl/advert/providers/is_advert_admin_provider.dart';
import 'package:myecl/advert/ui/pages/advert.dart';
import 'package:myecl/advert/router.dart';
import 'package:myecl/advert/ui/components/advertiser_bar.dart';
import 'package:myecl/advert/ui/components/advert_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/column_refresher.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/advert/tools/constants.dart';

class AdvertMainPage extends HookConsumerWidget {
  const AdvertMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertNotifier = ref.watch(advertProvider.notifier);
    final advertList = ref.watch(advertListProvider);
    final advertListNotifier = ref.watch(advertListProvider.notifier);
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final selected = ref.watch(advertiserProvider);
    final selectedNotifier = ref.watch(advertiserProvider.notifier);
    final isAdmin = ref.watch(isAdminProvider);
    final isAdvertAdmin = ref.watch(isAdvertAdminProvider);
    return AdvertTemplate(
      child: Stack(
        children: [
          AsyncChild(
            value: advertList,
            builder: (context, advertData) {
              final sortedAdvertData = advertData
                  .sortedBy((element) => DateTime.parse(element.date))
                  .reversed;
              final filteredSortedAdvertData = sortedAdvertData.where(
                (advert) =>
                    selected
                        .where((e) => advert.advertiser.name == e.name)
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
                              selectedNotifier.clearAdvertiser();
                              QR.to(AdvertRouter.root + AdvertRouter.admin);
                            },
                          ),
                        if (isAdmin)
                          AdminButton(
                            onTap: () {
                              QR.to(
                                AdvertRouter.root +
                                    AdvertRouter.addDeleteAdvertiser,
                              );
                            },
                            text: AdvertTextConstants.management,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const AdvertiserBar(
                    useUserAdvertisers: false,
                    multipleSelect: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
