import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/announcer_list_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/advert/ui/pages/admin_page/admin_advert_card.dart';
import 'package:myecl/advert/ui/pages/advert.dart';
import 'package:myecl/advert/ui/router.dart';
import 'package:myecl/advert/ui/tools/announcer_bar.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdvertAdminPage extends HookConsumerWidget {
  const AdvertAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertNotifier = ref.watch(advertProvider.notifier);
    final advertList = ref.watch(advertListProvider);
    final userAnnouncerListNotifier =
        ref.watch(userAnnouncerListProvider.notifier);
    final userAnnouncerList = ref.watch(userAnnouncerListProvider);
    final advertListNotifier = ref.watch(advertListProvider.notifier);
    final selectedAnnouncers = ref.watch(announcerProvider);
    final selectedAnnouncersNotifier = ref.read(announcerProvider.notifier);
    return AdvertTemplate(
      child: Refresher(
        onRefresh: () async {
          await advertListNotifier.loadAdverts();
          await userAnnouncerListNotifier.loadMyAnnouncerList();
        },
        child: advertList.when(
          data: (advertData) {
            return userAnnouncerList.when(
              data: (userAnnouncerData) {
                final userAnnouncerAdvert = advertData.where((advert) =>
                    userAnnouncerData
                        .where(
                            (element) => advert.announcer.name == element.name)
                        .isNotEmpty);
                return Column(
                  children: [
                    const AnnouncerBar(
                      useUserAnnouncers: true,
                      multipleSelect: true,
                    ),
                    GestureDetector(
                      onTap: () {
                        advertNotifier.setAdvert(Advert.empty());
                        QR.to(AdvertRouter.root +
                            AdvertRouter.admin +
                            AdvertRouter.addEditAdvert);
                      },
                      child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 10, top: 20, left: 30, right: 30),
                          width: 300,
                          height: 100,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white,
                                  Colors.grey.shade100,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(3, 3),
                                )
                              ]),
                          child: Center(
                              child: HeroIcon(
                            HeroIcons.plus,
                            size: 40,
                            color: Colors.grey.shade500,
                          ))),
                    ),
                    ...userAnnouncerAdvert
                        .map((advert) => selectedAnnouncers
                                    .where(
                                        (e) => advert.announcer.name == e.name)
                                    .isNotEmpty ||
                                selectedAnnouncers.isEmpty
                            ? AdminAdvertCard(
                                onTap: () {
                                  advertNotifier.setAdvert(advert);
                                  QR.to(
                                      AdvertRouter.root + AdvertRouter.detail);
                                },
                                onEdit: () {
                                  advertNotifier.setAdvert(advert);
                                  selectedAnnouncersNotifier.clearAnnouncer(); //TODO ne marche pas pour une raison obscure...
                                  selectedAnnouncersNotifier.addAnnouncer(advert.announcer); //TODO ne marche pas pour une raison obscure...
                                  QR.to(AdvertRouter.root +
                                      AdvertRouter.admin +
                                      AdvertRouter.addEditAdvert);
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
                                advert: advert)
                            : Container())
                        .toList(),
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
    );
  }
}
