import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/centralisation/tools/functions.dart';
import 'package:titan/seed-library/class/species.dart';
import 'package:titan/seed-library/class/species_type.dart';
import 'package:titan/seed-library/providers/difficulty_filter_provider.dart';
import 'package:titan/seed-library/providers/information_provider.dart';
import 'package:titan/seed-library/providers/is_seed_library_admin_provider.dart';
import 'package:titan/seed-library/providers/species_provider.dart';
import 'package:titan/seed-library/providers/species_type_filter_provider.dart';
import 'package:titan/seed-library/providers/string_provider.dart';
import 'package:titan/seed-library/router.dart';
import 'package:titan/seed-library/tools/constants.dart';
import 'package:titan/seed-library/ui/pages/main_page/menu_card_ui.dart';
import 'package:titan/seed-library/ui/seed_library.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SeedLibraryMainPage extends HookConsumerWidget {
  const SeedLibraryMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSeedLibraryAdmin = ref.watch(isSeedLibraryAdminProvider);
    final information = ref.watch(syncInformationProvider);
    final speciesNotifier = ref.watch(speciesProvider.notifier);
    final seasonNotifier = ref.watch(seasonFilterProvider.notifier);
    final difficultyNotifier = ref.watch(difficultyFilterProvider.notifier);
    final searchNotifier = ref.watch(searchFilterProvider.notifier);
    final speciesTypeNotifier = ref.watch(speciesTypeFilterProvider.notifier);

    void resetNotifier() {
      speciesNotifier.setSpecies(Species.empty());
      seasonNotifier.setString(SeedLibraryTextConstants.all);
      difficultyNotifier.setFilter(0);
      searchNotifier.setString('');
      speciesTypeNotifier.setFilter(SpeciesType.empty());
    }

    final controller = ScrollController();

    return SeedLibraryTemplate(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView(
          controller: controller,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio:
                MediaQuery.of(context).size.width <
                    MediaQuery.of(context).size.height
                ? 0.75
                : 1.5,
          ),
          children: [
            if (isSeedLibraryAdmin)
              GestureDetector(
                onTap: () {
                  resetNotifier();
                  QR.to(SeedLibraryRouter.root + SeedLibraryRouter.species);
                },
                child: const MenuCardUi(
                  text: SeedLibraryTextConstants.speciesSimple,
                  icon: HeroIcons.wallet,
                ),
              ),
            GestureDetector(
              onTap: () {
                resetNotifier();
                QR.to(SeedLibraryRouter.root + SeedLibraryRouter.plants);
              },
              child: const MenuCardUi(
                text: SeedLibraryTextConstants.myPlants,
                icon: HeroIcons.magnifyingGlass,
              ),
            ),
            GestureDetector(
              onTap: () {
                resetNotifier();
                QR.to(SeedLibraryRouter.root + SeedLibraryRouter.stock);
              },
              child: const MenuCardUi(
                text: SeedLibraryTextConstants.stock,
                icon: HeroIcons.inboxStack,
              ),
            ),
            GestureDetector(
              onTap: () {
                resetNotifier();
                QR.to(SeedLibraryRouter.root + SeedLibraryRouter.seedDeposit);
              },
              child: const MenuCardUi(
                text: SeedLibraryTextConstants.seedDeposit,
                icon: HeroIcons.inboxArrowDown,
              ),
            ),
            GestureDetector(
              onTap: () {
                openLink(information.facebookUrl);
              },
              child: const MenuCardUi(
                text: SeedLibraryTextConstants.helpSheets,
                icon: HeroIcons.documentMagnifyingGlass,
              ),
            ),
            GestureDetector(
              onTap: () {
                openLink(information.forumUrl);
              },
              child: const MenuCardUi(
                text: SeedLibraryTextConstants.forum,
                icon: HeroIcons.fire,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
