import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/is_admin_provider.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/meta/providers/meta_list_provider.dart';
import 'package:myecl/advert/providers/advert_posters_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/providers/is_advert_admin_provider.dart';
import 'package:myecl/advert/ui/pages/advert.dart';
import 'package:myecl/advert/router.dart';
import 'package:myecl/advert/ui/components/announcer_bar.dart';
import 'package:myecl/advert/ui/components/advert_card.dart';
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
    final advertListNotifier = ref.watch(advertListProvider.notifier);
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final selected = ref.watch(announcerProvider);
    final selectedNotifier = ref.watch(announcerProvider.notifier);
    final isAdmin = ref.watch(isAdminProvider);
    final isAdvertAdmin = ref.watch(isAdvertAdminProvider);
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
                      final events =
                          advertData; //.where((advert) => advert.type == 'event');
                      return _buildPaginatedAdvertList(events, advertNotifier,
                          advertListNotifier, advertPostersNotifier);
                    },
                  ),
                  // Annonces Tab
                  AsyncChild(
                    value: metaList,
                    builder: (context, advertData) {
                      final annonces = advertData;
                      //.where((advert) => advert.type == 'annonce');
                      return _buildPaginatedAdvertList(annonces, advertNotifier,
                          advertListNotifier, advertPostersNotifier);
                    },
                  ),
                  // Shotgun Tab
                  AsyncChild(
                    value: metaList,
                    builder: (context, advertData) {
                      final shotguns = advertData;
                      //.where((advert) => advert.type == 'shotgun');
                      return _buildPaginatedAdvertList(shotguns, advertNotifier,
                          advertListNotifier, advertPostersNotifier);
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
    Iterable? adverts, // Ajout de null safety
    AdvertNotifier advertNotifier,
    AdvertListNotifier metaListNotifier,
    AdvertPostersNotifier advertPostersNotifier,
  ) {
    if (adverts == null || adverts.isEmpty) {
      debugPrint('Aucune donnée à afficher dans _buildPaginatedAdvertList');
      return Center(
        child: Text(
          'Aucune donnée disponible.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    final scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        debugPrint('Chargement de plus de données...');
        // metaListNotifier.loadMoreAdverts(); // Charger plus de données
      }
    });

    return ColumnRefresher(
      onRefresh: () async {
        debugPrint('Rafraîchissement des données...');
        await metaListNotifier.loadAdverts();
        advertPostersNotifier.resetTData();
      },
      children: [
        ListView.builder(
          // Supprimé le widget Expanded
          controller: scrollController,
          itemCount: adverts.length,
          shrinkWrap: true, // Ajouté pour permettre à ListView de s'adapter
          physics:
              const ClampingScrollPhysics(), // Ajouté pour éviter les conflits de défilement
          itemBuilder: (context, index) {
            final advert = adverts.elementAt(index);
            debugPrint('Affichage de l\'élément $index : $advert');
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: MetaCard(
                onTap: () {
                  advertNotifier.setAdvert(advert);
                  QR.to(AdvertRouter.root + AdvertRouter.detail);
                },
                meta: advert,
              )
            );
          },
        ),
      ],
    );
  }
}
