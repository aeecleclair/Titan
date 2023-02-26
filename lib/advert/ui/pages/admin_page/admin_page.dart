import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/advert/providers/advert_page_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/advert/ui/pages/admin_page/admin_advert_card.dart';
import 'package:myecl/advert/ui/pages/admin_page/announcer_bar.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertNotifier = ref.watch(advertProvider.notifier);
    final advertList = ref.watch(advertListProvider);
    final advertListNotifier = ref.watch(advertListProvider.notifier);
    final pageNotifier = ref.watch(advertPageProvider.notifier);
    final selected = ref.watch(announcerProvider);
    return Column(
      children: [
        const AnnouncerBar(),
        SizedBox(
          height: MediaQuery.of(context).size.height - 165.4,
          child: IntrinsicHeight(
            child: Refresher(
              onRefresh: () async {
                await advertListNotifier.loadAdverts();
              },
              child: advertList.when(
                data: (data) {
                  return Column(
                    children: [
                      GestureDetector(
                              onTap: () {
                                advertNotifier.setAdvert(Advert.empty());
                                pageNotifier.setAdvertPage(
                                    AdvertPage.addEditAdvert);
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, top: 20, left: 30, right: 30),
                                  width: double.infinity,
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
                      ...data
                          .map((advert) => selected
                                      .where(
                                          (e) => advert.groups.contains(e.name))
                                      .isNotEmpty ||
                                  selected.isEmpty
                              ? AdminAdvertCard(
                                  onTap: () {
                                    advertNotifier.setAdvert(advert);
                                    pageNotifier.setAdvertPage(
                                        AdvertPage.detailFromMainPage);
                                  },
                                  onEdit: () {
                                    pageNotifier.setAdvertPage(
                                        AdvertPage.addEditAdvert);
                                  },
                                  onDelete: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CustomDialogBox(
                                            title: AdvertTextConstants.deleting,
                                            descriptions: AdvertTextConstants
                                                .deleteAdvert,
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
