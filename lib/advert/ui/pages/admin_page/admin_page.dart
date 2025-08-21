import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/admin/providers/my_association_list_provider.dart';
import 'package:titan/advert/class/advert.dart';
import 'package:titan/advert/providers/advert_list_provider.dart';
import 'package:titan/advert/providers/advert_posters_provider.dart';
import 'package:titan/advert/providers/advert_provider.dart';
import 'package:titan/advert/providers/selected_association_provider.dart';
import 'package:titan/advert/ui/components/special_action_button.dart';
import 'package:titan/advert/ui/pages/admin_page/admin_advert_card.dart';
import 'package:titan/advert/ui/pages/advert.dart';
import 'package:titan/advert/router.dart';
import 'package:titan/advert/ui/components/association_bar.dart';
import 'package:titan/feed/providers/is_user_a_member_of_an_association.dart';
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
    final advertList = ref.watch(advertListProvider);
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final selectedAssociations = ref.watch(selectedAssociationProvider);
    final selectedAssociationsNotifier = ref.read(
      selectedAssociationProvider.notifier,
    );
    final myAssociationList = ref.watch(myAssociationListProvider);
    final myAssociationListNotifier = ref.watch(
      asyncMyAssociationListProvider.notifier,
    );
    final isAdvertAdmin = ref.watch(isUserAMemberOfAnAssociationProvider);

    return AdvertTemplate(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AssociationBar(
                  useUserAssociations: !isAdmin,
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
                    if (myAssociationList.length == 1 &&
                        selectedAssociations.isEmpty) {
                      selectedAssociationsNotifier.addAssociation(
                        myAssociationList[0],
                      );
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
              builder: (context, advertData) {
                final userAssociationAdvert = advertData.where(
                  (advert) => !isAdmin
                      ? myAssociationList.any(
                          (element) => advert.associationId == element.id,
                        )
                      : true,
                );
                final sortedUserAssociationAdverts = userAssociationAdvert
                    .toList()
                    .sortedBy((element) => element.date)
                    .reversed;
                final filteredSortedUserAssociationAdverts =
                    sortedUserAssociationAdverts
                        .where(
                          (advert) =>
                              selectedAssociations
                                  .where((e) => advert.associationId == e.id)
                                  .isNotEmpty ||
                              selectedAssociations.isEmpty,
                        )
                        .toList();
                return Refresher(
                  controller: ScrollController(),
                  onRefresh: () async {
                    if (isAdmin) {
                      await ref
                          .watch(advertListProvider.notifier)
                          .loadAdverts();
                    }
                    await ref.watch(advertListProvider.notifier).loadAdverts();
                    await myAssociationListNotifier.loadAssociations();
                    advertPostersNotifier.resetTData();
                  },
                  child: Column(
                    children: [
                      ...filteredSortedUserAssociationAdverts.map(
                        (advert) => AdminAdvertCard(
                          onEdit: () {
                            QR.to(
                              AdvertRouter.root +
                                  AdvertRouter.admin +
                                  AdvertRouter.addEditAdvert,
                            );
                            advertNotifier.setAdvert(advert);
                            selectedAssociationsNotifier.clearAssociation();
                            selectedAssociationsNotifier.addAssociation(
                              myAssociationList.firstWhere(
                                (element) => element.id == advert.associationId,
                              ),
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
                                          .watch(advertListProvider.notifier)
                                          .deleteAdvert(advert);
                                    } else {
                                      await ref
                                          .watch(advertListProvider.notifier)
                                          .deleteAdvert(advert);
                                    }
                                    advertPostersNotifier.deleteE(advert.id, 0);
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
        ],
      ),
    );
  }
}
