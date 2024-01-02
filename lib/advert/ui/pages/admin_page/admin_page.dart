import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/announcer_list_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/advert/ui/components/advertiser_bar.dart';
import 'package:myecl/advert/ui/pages/admin_page/admin_advert_card.dart';
import 'package:myecl/advert/ui/pages/advert.dart';
import 'package:myecl/advert/router.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdvertAdminPage extends HookConsumerWidget {
  const AdvertAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertNotifier = ref.watch(advertProvider.notifier);
    final advertList = ref.watch(advertListProvider);
    final userAdvertiserListNotifier =
        ref.watch(userAdvertiserListProvider.notifier);
    final userAdvertiserList = ref.watch(userAdvertiserListProvider);
    final advertListNotifier = ref.watch(advertListProvider.notifier);
    final selectedAdvertisers = ref.watch(advertiserProvider);
    final selectedAdvertisersNotifier = ref.read(advertiserProvider.notifier);
    return AdvertTemplate(
      child: Refresher(
          onRefresh: () async {
            await advertListNotifier.loadAdverts();
            await userAdvertiserListNotifier.loadMyAdvertiserList();
          },
          child: AsyncChild(
              value: advertList,
              builder: (context, advertData) => AsyncChild(
                    value: userAdvertiserList,
                    builder: (context, userAdvertiserData) {
                      final userAdvertiserAdvert = advertData.where((advert) =>
                          userAdvertiserData
                              .where((element) =>
                                  advert.advertiser.id == element.id)
                              .isNotEmpty);
                      final sortedUserAdvertiserAdverts = userAdvertiserAdvert
                          .toList()
                          .sortedBy((element) => element.date!)
                          .reversed;
                      final filteredSortedUserAdvertiserAdverts =
                          sortedUserAdvertiserAdverts
                              .where((advert) =>
                                  selectedAdvertisers
                                      .where(
                                          (e) => advert.advertiser.id == e.id)
                                      .isNotEmpty ||
                                  selectedAdvertisers.isEmpty)
                              .toList();
                      return Column(
                        children: [
                          const AdvertiserBar(
                            useUserAdvertisers: true,
                            multipleSelect: true,
                          ),
                          GestureDetector(
                            onTap: () {
                              advertNotifier
                                  .setAdvert(AdvertReturnComplete.fromJson({}));
                              QR.to(AdvertRouter.root +
                                  AdvertRouter.admin +
                                  AdvertRouter.addEditAdvert);
                            },
                            child: CardLayout(
                                margin: const EdgeInsets.only(
                                    bottom: 10, top: 20, left: 30, right: 30),
                                width: 300,
                                height: 100,
                                colors: [
                                  Colors.white,
                                  Colors.grey.shade100,
                                ],
                                shadowColor: Colors.grey.withOpacity(0.2),
                                child: Center(
                                    child: HeroIcon(
                                  HeroIcons.plus,
                                  size: 40,
                                  color: Colors.grey.shade500,
                                ))),
                          ),
                          ...filteredSortedUserAdvertiserAdverts.map(
                            (advert) => AdminAdvertCard(
                                onTap: () {
                                  advertNotifier.setAdvert(advert);
                                  QR.to(
                                      AdvertRouter.root + AdvertRouter.detail);
                                },
                                onEdit: () {
                                  QR.to(AdvertRouter.root +
                                      AdvertRouter.admin +
                                      AdvertRouter.addEditAdvert);
                                  advertNotifier.setAdvert(advert);
                                  selectedAdvertisersNotifier.clearAdvertiser();
                                  selectedAdvertisersNotifier
                                      .addAdvertiser(advert.advertiser);
                                },
                                onDelete: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomDialogBox(
                                          title: AdvertTextConstants.deleting,
                                          descriptions:
                                              AdvertTextConstants.deleteAdvert,
                                          onYes: () {
                                            advertListNotifier
                                                .deleteAdvert(advert);
                                          },
                                        );
                                      });
                                },
                                advert: advert),
                          ),
                        ],
                      );
                    },
                  ))),
    );
  }
}
