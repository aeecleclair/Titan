import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/is_admin_provider.dart';
import 'package:myecl/meta/providers/meta_list_provider.dart';
import 'package:myecl/advert/providers/advert_posters_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/providers/is_advert_admin_provider.dart';
import 'package:myecl/advert/router.dart';
import 'package:myecl/meta/ui/components/meta_card.dart';
import 'package:myecl/meta/ui/pages/meta.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/advert/tools/constants.dart';

class MetaMainPage extends HookConsumerWidget {
  const MetaMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertNotifier = ref.watch(advertProvider.notifier);
    final metaList = ref.watch(metaListProvider);
    final metaListNotifier = ref.watch(metaListProvider.notifier);
    final metaPostersNotifier = ref.watch(advertPostersProvider.notifier);
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
                          metaListNotifier, metaPostersNotifier);
                    },
                  ),
                  // Annonces Tab
                  AsyncChild(
                    value: metaList,
                    builder: (context, advertData) {
                      final annonces = advertData;
                      //.where((advert) => advert.type == 'annonce');
                      return _buildPaginatedAdvertList(annonces, advertNotifier,
                          metaListNotifier, metaPostersNotifier);
                    },
                  ),
                  // Shotgun Tab
                  AsyncChild(
                    value: metaList,
                    builder: (context, advertData) {
                      final shotguns = advertData;
                      //.where((advert) => advert.type == 'shotgun');
                      return _buildPaginatedAdvertList(shotguns, advertNotifier,
                          metaListNotifier, metaPostersNotifier);
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
    Iterable? adverts,
    AdvertNotifier advertNotifier,
    MetaListNotifier metaListNotifier,
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

    return RefreshIndicator(
      onRefresh: () async {
        debugPrint('Rafraîchissement des données...');
        await metaListNotifier.loadMetas();
        advertPostersNotifier.resetTData();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          // Déclenche le chargement quand on approche des 100 pixels de la fin
          if (scrollNotification.metrics.pixels >=
              scrollNotification.metrics.maxScrollExtent - 100) {
            debugPrint('Chargement de plus de données...');
            metaListNotifier.loadMoreMetas();
          }
          return false;
        },
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
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
                childCount: adverts.length,
              ),
            ),
            // Optionnel : affichage d'un indicateur de chargement en bas de la liste
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
