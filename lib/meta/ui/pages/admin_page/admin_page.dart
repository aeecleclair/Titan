import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/providers/advert_posters_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/ui/pages/admin_page/admin_advert_card.dart';
import 'package:myecl/meta/providers/meta_list_provider.dart';
import 'package:myecl/meta/router.dart';
import 'package:myecl/meta/tools/constants.dart';
import 'package:myecl/meta/ui/pages/meta.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/tools/ui/components/paginated_list.dart';

class MetaAdminPage extends HookConsumerWidget {
  const MetaAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertNotifier = ref.watch(advertProvider.notifier);
    final advertList = ref.watch(advertListProvider);
    final advertListNotifier = ref.watch(advertListProvider.notifier);
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    return MetaTemplate(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const TabBar(
              tabs: [
                Tab(text: 'Events'),
                Tab(text: 'Annonces'),
                Tab(text: 'Shotgun'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildAdminTab(context, ref, advertNotifier, advertList,
                      advertListNotifier, advertPostersNotifier, 'event'),
                  _buildAdminTab(context, ref, advertNotifier, advertList,
                      advertListNotifier, advertPostersNotifier, 'annonce'),
                  _buildAdminTab(context, ref, advertNotifier, advertList,
                      advertListNotifier, advertPostersNotifier, 'shotgun'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminTab(
    BuildContext context,
    WidgetRef ref,
    AdvertNotifier advertNotifier,
    AsyncValue<List<Advert>> advertList,
    MetaListNotifier metaListNotifier,
    dynamic metaPostersNotifier,
    String type,
  ) {
    return advertList.when(
      data: (adverts) {
        final filteredList =
            adverts; //where((advert) => advert.type == type).toList();
        return PaginatedList<Advert>(
          items: filteredList,
          onRefresh: () async {
            await metaListNotifier.loadMetas();
            metaPostersNotifier.resetTData();
          },
          loadMore: metaListNotifier.loadMoreMetas,
          itemBuilder: (context, advert) => AdminAdvertCard(
            advert: advert,
            onTap: () {
              advertNotifier.setAdvert(advert);
              QR.to(MetaRouter.root + MetaRouter.detail);
            },
            onEdit: () {
              advertNotifier.setAdvert(advert);
              QR.to(MetaRouter.root +
                  MetaRouter.admin +
                  MetaRouter.addEditAdvert);
            },
            onDelete: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return CustomDialogBox(
                    title: MetaTextConstants.deleting,
                    descriptions: MetaTextConstants.deleteAdvert,
                    onYes: () {
                      metaListNotifier.deleteMeta(advert);
                      metaPostersNotifier.deleteE(advert.id, 0);
                    },
                  );
                },
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Erreur: $error')),
    );
  }
}
