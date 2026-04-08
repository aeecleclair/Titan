import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/class/user_store.dart';
import 'package:titan/paiement/providers/my_stores_provider.dart';
import 'package:titan/shotgun/providers/store_shotgun_list_provider.dart';
import 'package:titan/shotgun/ui/components/shotgun_card.dart';
import 'package:titan/shotgun/ui/shotgun.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/horizontal_multi_select.dart';

class ManageShotgunPage extends HookConsumerWidget {
  const ManageShotgunPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final myStores = ref.watch(myStoresProvider);
    final storeShotgunList = ref.watch(storeShotgunListProvider);
    final storeShotgunListNotifier = ref.watch(
      storeShotgunListProvider.notifier,
    );
    final selectedStore = useState<UserStore?>(
      myStores.valueOrNull?.isNotEmpty ?? false
          ? myStores.valueOrNull?.first
          : null,
    );

    // Charger les shotguns du store sélectionné au démarrage
    useEffect(() {
      if (selectedStore.value != null) {
        storeShotgunListNotifier.loadStoreShotgunList(selectedStore.value!.id);
      }
      return null;
    }, [selectedStore.value]);

    return ShotgunTemplate(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              l10n.shotgunManageTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.title,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: HorizontalMultiSelect<UserStore>(
              items: myStores.valueOrNull ?? [],
              selectedItem: selectedStore.value,
              onItemSelected: (store) {
                selectedStore.value = store;
                storeShotgunListNotifier.loadStoreShotgunList(store.id);
              },
              itemBuilder: (context, store, index, selected) => Text(
                store.name,
                style: TextStyle(
                  color: selected
                      ? ColorConstants.background
                      : ColorConstants.tertiary,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Refresher(
              onRefresh: () {
                if (selectedStore.value == null) {
                  return Future.value();
                }
                return storeShotgunListNotifier.loadStoreShotgunList(
                  selectedStore.value!.id,
                );
              },
              controller: ScrollController(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AsyncChild(
                  value: storeShotgunList,
                  builder: (context, shotgunList) {
                    if (shotgunList.isEmpty) {
                      return Center(
                        child: Text(
                          l10n.shotgunNoShotgun,
                          style: const TextStyle(color: ColorConstants.tertiary),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: shotgunList.length,
                      itemBuilder: (context, index) {
                        return ShotgunCard(shotgun: shotgunList[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
