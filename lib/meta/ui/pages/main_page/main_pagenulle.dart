import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/is_admin_provider.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/advert/providers/advert_posters_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/providers/is_advert_admin_provider.dart';
import 'package:myecl/advert/router.dart';
import 'package:myecl/meta/ui/components/meta_card.dart';
import 'package:myecl/meta/ui/pages/meta.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/column_refresher.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/advert/tools/constants.dart';

class MetaMainPage extends HookConsumerWidget {
  const MetaMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertNotifier = ref.watch(advertProvider.notifier);
    final metaList = ref.watch(advertListProvider);
    final metaListNotifier = ref.watch(advertListProvider.notifier);
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final selectedNotifier = ref.watch(announcerProvider.notifier);
    final isAdmin = ref.watch(isAdminProvider);
    final isAdvertAdmin = ref.watch(isAdvertAdminProvider);

    debugPrint('metaList: $metaList'); // Vérifiez la valeur de metaList

    return DefaultTabController(
      length: 3,
      child: MetaTemplate(
        child: Column(
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
                          AdvertRouter.root + AdvertRouter.addRemAnnouncer,
                        );
                      },
                      text: AdvertTextConstants.management,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const TabBar(
              tabs: [
                Tab(text: 'Events'),
                Tab(text: 'Annonces'),
                Tab(text: 'Shotgun'),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                children: [
                  // Events Tab
                  AsyncChild(
                    value: metaList,
                    builder: (context, advertData) {
                      if (metaList == null) {
                        return Center(
                          child:
                              CircularProgressIndicator(), // Indicateur de chargement
                        );
                      }
                      if (advertData == null) {
                        debugPrint('metaList est null');
                        return Center(
                          child: Text(
                            'Erreur : Les données sont nulles.',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        );
                      }
                      if (advertData.isEmpty) {
                        return Center(
                          child: Text(
                            'Aucune donnée disponible.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        );
                      }
                      final events = advertData;
                      return _buildPaginatedAdvertList(events, advertNotifier,
                          metaListNotifier, advertPostersNotifier);
                    },
                  ),
                  // Annonces Tab
                  AsyncChild(
                    value: metaList,
                    builder: (context, advertData) {
                      if (metaList == null) {
                        return Center(
                          child:
                              CircularProgressIndicator(), // Indicateur de chargement
                        );
                      }
                      if (advertData == null) {
                        debugPrint('metaList est null');
                        return Center(
                          child: Text(
                            'Erreur : Les données sont nulles.',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        );
                      }
                      if (advertData.isEmpty) {
                        return Center(
                          child: Text(
                            'Aucune donnée disponible.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        );
                      }
                      final annonces = advertData;
                      return _buildPaginatedAdvertList(annonces, advertNotifier,
                          metaListNotifier, advertPostersNotifier);
                    },
                  ),
                  // Shotgun Tab
                  AsyncChild(
                    value: metaList,
                    builder: (context, advertData) {
                      if (metaList == null) {
                        return Center(
                          child:
                              CircularProgressIndicator(), // Indicateur de chargement
                        );
                      }
                      if (advertData == null) {
                        debugPrint('metaList est null');
                        return Center(
                          child: Text(
                            'Erreur : Les données sont nulles.',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        );
                      }
                      if (advertData.isEmpty) {
                        return Center(
                          child: Text(
                            'Aucune donnée disponible.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        );
                      }
                      final shotguns = advertData;
                      return _buildPaginatedAdvertList(shotguns, advertNotifier,
                          metaListNotifier, advertPostersNotifier);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaginatedAdvertList(
    Iterable adverts,
    AdvertNotifier advertNotifier,
    AdvertListNotifier metaListNotifier,
    AdvertPostersNotifier advertPostersNotifier,
  ) {
    final scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //metaListNotifier.loadMoreMetas(); // Charger plus de données
      }
    });

    return ColumnRefresher(
      onRefresh: () async {
        await metaListNotifier.loadAdverts();
        advertPostersNotifier.resetTData();
      },
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: adverts.length,
            itemBuilder: (context, index) {
              final advert = adverts.elementAt(index);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: MetaCard(
                  onTap: () {
                    advertNotifier.setAdvert(advert);
                    QR.to(AdvertRouter.root + AdvertRouter.detail);
                  },
                  meta: advert,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
