import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/seed-library/providers/difficulty_filter_provider.dart';
import 'package:myecl/seed-library/providers/species_list_provider.dart';
import 'package:myecl/seed-library/providers/species_provider.dart';
import 'package:myecl/seed-library/providers/species_type_provider.dart';
import 'package:myecl/seed-library/providers/string_provider.dart';
import 'package:myecl/seed-library/router.dart';
import 'package:myecl/seed-library/tools/constants.dart';
import 'package:myecl/seed-library/tools/functions.dart';
import 'package:myecl/seed-library/ui/components/species_card.dart';
import 'package:myecl/seed-library/ui/seed_library.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SpeciesPage extends HookConsumerWidget {
  const SpeciesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speciesNotifier = ref.watch(speciesProvider.notifier);
    final difficultyNotifier = ref.watch(difficultyFilterProvider.notifier);
    final speciesTypeNotifier = ref.watch(speciesTypeProvider.notifier);
    final speciesListNotifier = ref.watch(speciesListProvider.notifier);
    final species = ref.watch(speciesListProvider);
    final startMonthNotifier = ref.watch(startMonthProvider.notifier);
    final endMonthNotifier = ref.watch(endMonthProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SeedLibraryTemplate(
      child: Refresher(
        onRefresh: () async {
          await speciesListNotifier.loadSpecies();
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  QR.to(
                    SeedLibraryRouter.root +
                        SeedLibraryRouter.species +
                        SeedLibraryRouter.addEditSpecies,
                  );
                },
                child: CardLayout(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                    top: 20,
                    left: 40,
                    right: 40,
                  ),
                  width: double.infinity,
                  height: 100,
                  color: Colors.white,
                  child: Center(
                    child: HeroIcon(
                      HeroIcons.plus,
                      size: 40,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              AsyncChild(
                value: species,
                builder: (context, speciesList) => speciesList.isEmpty
                    ? const Text('No species found')
                    : Column(
                        children: [
                          ...speciesList.map(
                            (species) => SpeciesCard(
                              species: species,
                              onEdit: () {
                                difficultyNotifier
                                    .setFilter(species.difficulty);
                                speciesTypeNotifier.setType(species.type);
                                speciesNotifier.setSpecies(species);
                                startMonthNotifier.setString(
                                  species.startSeason != null
                                      ? monthToString(
                                          species.startSeason!.month)
                                      : '',
                                );
                                endMonthNotifier.setString(
                                  species.endSeason != null
                                      ? monthToString(species.endSeason!.month)
                                      : '',
                                );
                                QR.to(
                                  SeedLibraryRouter.root +
                                      SeedLibraryRouter.species +
                                      SeedLibraryRouter.addEditSpecies,
                                );
                              },
                              onDelete: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                      title: SeedLibraryTextConstants.deleting,
                                      descriptions: SeedLibraryTextConstants
                                          .deleteSpecies,
                                      onYes: () async {
                                        final result = await speciesListNotifier
                                            .deleteSpecie(species);
                                        if (result) {
                                          displayToastWithContext(
                                            TypeMsg.msg,
                                            SeedLibraryTextConstants
                                                .deletedSpecies,
                                          );
                                        } else {
                                          displayToastWithContext(
                                            TypeMsg.error,
                                            SeedLibraryTextConstants
                                                .deletingError,
                                          );
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
