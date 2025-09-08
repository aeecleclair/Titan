import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/seed-library/class/plant_creation.dart';
import 'package:titan/seed-library/class/plant_simple.dart';
import 'package:titan/seed-library/class/species.dart';
import 'package:titan/seed-library/providers/is_seed_library_admin_provider.dart';
import 'package:titan/seed-library/providers/plant_complete_provider.dart';
import 'package:titan/seed-library/providers/plant_simple_provider.dart';
import 'package:titan/seed-library/providers/plants_list_provider.dart';
import 'package:titan/seed-library/providers/propagation_method_provider.dart';
import 'package:titan/seed-library/providers/species_list_provider.dart';
import 'package:titan/seed-library/providers/species_provider.dart';
import 'package:titan/seed-library/tools/constants.dart';
import 'package:titan/seed-library/tools/functions.dart';
import 'package:titan/seed-library/ui/components/radio_chip.dart';
import 'package:titan/seed-library/ui/pages/plant_deposit_page/small_plant_card.dart';
import 'package:titan/seed-library/ui/pages/plant_deposit_page/small_species_card.dart';
import 'package:titan/seed-library/ui/seed_library.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class PlantDepositPage extends HookConsumerWidget {
  final scrollKey = GlobalKey();
  PlantDepositPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedLibraryAdmin = ref.watch(isSeedLibraryAdminProvider);
    final key = GlobalKey<FormState>();
    final scrollController = useScrollController();
    final species = ref.watch(syncSpeciesListProvider);
    final plantList = ref.watch(syncPlantListProvider);
    final plantListNotifier = ref.watch(plantListProvider.notifier);
    final plantNotifier = ref.watch(plantProvider.notifier);
    final myPlants = ref.watch(syncMyPlantListProvider);
    final selectedAncestor = ref.watch(plantSimpleProvider);
    final selectedAncestorNotifier = ref.watch(plantSimpleProvider.notifier);
    final selectedSpecies = ref.watch(speciesProvider);
    final selectedSpeciesNotifier = ref.watch(speciesProvider.notifier);
    final propagationMethod = ref.watch(propagationMethodProvider);
    final propagationMethodNotifier = ref.watch(
      propagationMethodProvider.notifier,
    );

    final seedQuantity = useTextEditingController();
    final notes = useTextEditingController();

    final plantSpecies = selectedAncestor.id != ""
        ? species.firstWhere(
            (element) => element.id == selectedAncestor.speciesId,
          )
        : selectedSpecies;

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SeedLibraryTemplate(
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: (myPlants.isEmpty && !seedLibraryAdmin)
            ? const Center(
                child: Text(
                  SeedLibraryTextConstants.depositNotAvailable,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            : Form(
                key: key,
                child: Column(
                  children: [
                    Text(
                      SeedLibraryTextConstants.addPlant,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      SeedLibraryTextConstants.ancestor,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...myPlants.map((e) {
                            return SmallPlantCard(
                              plant: e,
                              species: species,
                              onClicked: () async {
                                selectedAncestor.id == e.id
                                    ? selectedAncestorNotifier.setPlant(
                                        PlantSimple.empty(),
                                      )
                                    : selectedAncestorNotifier.setPlant(e);
                                final plant = await plantNotifier.loadPlant(
                                  e.id,
                                );
                                plant.whenData(
                                  (value) =>
                                      notes.text = value.currentNote ?? '',
                                );
                              },
                              selected: selectedAncestor.id == e.id,
                            );
                          }),
                        ],
                      ),
                    ),
                    if (selectedAncestor.id == '' && seedLibraryAdmin) ...[
                      Text(
                        SeedLibraryTextConstants.speciesSimple,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...species.map((e) {
                              return SmallSpeciesCard(
                                species: e,
                                onClicked: () {
                                  selectedSpecies.id == e.id
                                      ? selectedSpeciesNotifier.setSpecies(
                                          Species.empty(),
                                        )
                                      : selectedSpeciesNotifier.setSpecies(e);
                                },
                                selected: selectedSpecies.id == e.id,
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ...PropagationMethod.values.map((e) {
                                return RadioChip(
                                  label: e.name,
                                  selected: propagationMethod == e,
                                  onTap: () {
                                    propagationMethodNotifier
                                        .setPropagationMethod(e);
                                  },
                                );
                              }),
                            ],
                          ),
                          if (propagationMethod ==
                              PropagationMethod.graine) ...[
                            const SizedBox(height: 30),
                            TextEntry(
                              controller: seedQuantity,
                              label:
                                  "${SeedLibraryTextConstants.seedQuantitySimple}${plantSpecies.nbSeedsRecommended != null ? ' (${SeedLibraryTextConstants.around} ${plantSpecies.nbSeedsRecommended})' : ''}",
                              keyboardType: TextInputType.number,
                              isInt: true,
                            ),
                          ],
                          const SizedBox(height: 30),
                          TextEntry(
                            controller: notes,
                            label: SeedLibraryTextConstants.notes,
                            canBeEmpty: true,
                            keyboardType: TextInputType.multiline,
                          ),
                          const SizedBox(height: 50),
                          WaitingButton(
                            builder: (child) => AddEditButtonLayout(
                              colors: const [
                                ColorConstants.gradient1,
                                ColorConstants.gradient2,
                              ],
                              child: child,
                            ),
                            onTap: () async {
                              if (!key.currentState!.validate()) {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  SeedLibraryTextConstants.emptyFieldError,
                                );
                                return;
                              }
                              if (selectedAncestor.id == '' &&
                                  selectedSpecies.id == '') {
                                if (seedLibraryAdmin) {
                                  displayToastWithContext(
                                    TypeMsg.error,
                                    SeedLibraryTextConstants
                                        .choosingSpeciesOrAncestor,
                                  );
                                } else {
                                  displayToastWithContext(
                                    TypeMsg.error,
                                    SeedLibraryTextConstants.choosingAncestor,
                                  );
                                }

                                return;
                              }
                              await tokenExpireWrapper(ref, () async {
                                final value = await plantListNotifier
                                    .createPlant(
                                      PlantCreation(
                                        ancestorId: selectedAncestor.id == ''
                                            ? null
                                            : selectedAncestor.id,
                                        speciesId: selectedAncestor.id == ''
                                            ? selectedSpecies.id
                                            : selectedAncestor.speciesId,
                                        propagationMethod: propagationMethod,
                                        nbSeedsEnvelope:
                                            propagationMethod ==
                                                PropagationMethod.graine
                                            ? int.parse(seedQuantity.text)
                                            : 1,
                                        previousNote: notes.text,
                                      ),
                                    );
                                if (value) {
                                  displayToastWithContext(
                                    TypeMsg.msg,
                                    SeedLibraryTextConstants.addedPlant,
                                  );
                                  showDialog(
                                    context: context.mounted
                                        ? context
                                        : context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          SeedLibraryTextConstants
                                                  .writeReference +
                                              plantList.last.plantReference,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              SeedLibraryTextConstants.ok,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  displayToastWithContext(
                                    TypeMsg.error,
                                    SeedLibraryTextConstants.addingError,
                                  );
                                }
                                selectedSpeciesNotifier.setSpecies(
                                  Species.empty(),
                                );
                                selectedAncestorNotifier.setPlant(
                                  PlantSimple.empty(),
                                );
                                seedQuantity.clear();
                                notes.clear();
                              });
                            },
                            child: const Text(
                              SeedLibraryTextConstants.add,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
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
