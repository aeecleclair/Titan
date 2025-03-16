import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/seed-library/class/plant_creation.dart';
import 'package:myecl/seed-library/class/plant_simple.dart';
import 'package:myecl/seed-library/class/species.dart';
import 'package:myecl/seed-library/providers/is_seed_library_admin_provider.dart';
import 'package:myecl/seed-library/providers/plant_simple_provider.dart';
import 'package:myecl/seed-library/providers/plants_list_provider.dart';
import 'package:myecl/seed-library/providers/propagation_method_provider.dart';
import 'package:myecl/seed-library/providers/species_list_provider.dart';
import 'package:myecl/seed-library/providers/species_provider.dart';
import 'package:myecl/seed-library/tools/constants.dart';
import 'package:myecl/seed-library/ui/components/radio_chip.dart';
import 'package:myecl/seed-library/ui/seed_library.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';

class SeedDepositPage extends HookConsumerWidget {
  final scrollKey = GlobalKey();
  SeedDepositPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedLibraryAdmin = ref.watch(isSeedLibraryAdminProvider);
    final key = GlobalKey<FormState>();
    final seedQuantity = useTextEditingController();
    final notes = useTextEditingController();
    final species = ref.watch(syncSpeciesListProvider);
    final plantList = ref.watch(syncPlantListProvider);
    final plantListNotifier = ref.watch(plantListProvider.notifier);
    final myPlants = ref.watch(syncMyPlantListProvider);
    final selectedAncestor = ref.watch(plantSimpleProvider);
    final selectedAncestorNotifier = ref.watch(plantSimpleProvider.notifier);
    final selectedSpecies = ref.watch(speciesProvider);
    final selectedSpeciesNotifier = ref.watch(speciesProvider.notifier);
    final propagationMethod = ref.watch(propagationMethodProvider);
    final propagationMethodNotifier =
        ref.watch(propagationMethodProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SeedLibraryTemplate(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: key,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    SeedLibraryTextConstants.addPlant,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.gradient1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  SeedLibraryTextConstants.ancestor,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.gradient1,
                  ),
                ),
                DropdownButton(
                  items: ([PlantSimple.empty()] + myPlants)
                      .map<DropdownMenuItem<PlantSimple>>((e) {
                    return DropdownMenuItem<PlantSimple>(
                      value: e,
                      child: Text(e.nickname ?? e.plantReference),
                    );
                  }).toList(),
                  onChanged: (PlantSimple? newValue) {
                    selectedAncestorNotifier.setPlant(newValue!);
                  },
                  value: selectedAncestor,
                ),
                if (selectedAncestor.id == '' && seedLibraryAdmin) ...[
                  Text(SeedLibraryTextConstants.species),
                  DropdownButton(
                    value: selectedSpecies,
                    onChanged: (Species? newValue) {
                      selectedSpeciesNotifier.setSpecies(newValue!);
                    },
                    items: ([Species.empty()] + species)
                        .map<DropdownMenuItem<Species>>((e) {
                      return DropdownMenuItem<Species>(
                        value: e,
                        child: Text(e.name),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 30),
                Row(
                  children: [
                    ...PropagationMethod.values.map((e) {
                      return RadioChip(
                        label: e.name,
                        selected: propagationMethod == e,
                        onTap: () {
                          propagationMethodNotifier.setPropagationMethod(e);
                        },
                      );
                    }),
                  ],
                ),
                if (propagationMethod == PropagationMethod.seed) ...[
                  const SizedBox(height: 30),
                  TextEntry(
                    controller: seedQuantity,
                    label: SeedLibraryTextConstants.seedQuantity,
                    validator: (quantity) {
                      if (quantity == '' &&
                          propagationMethod == PropagationMethod.seed) {
                        return SeedLibraryTextConstants.noValue;
                      }
                      if (int.parse(quantity) < 0) {
                        return SeedLibraryTextConstants.positiveNumber;
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 30),
                TextEntry(
                  controller: notes,
                  label: SeedLibraryTextConstants.notes,
                  canBeEmpty: true,
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
                    if (selectedAncestor.id == '' && selectedSpecies.id == '') {
                      displayToastWithContext(
                        TypeMsg.error,
                        SeedLibraryTextConstants.choosingSpecies,
                      );
                      return;
                    }
                    await tokenExpireWrapper(ref, () async {
                      final value = await plantListNotifier.createPlant(
                        PlantCreation(
                          ancestorId: selectedAncestor.id == ''
                              ? null
                              : selectedAncestor.id,
                          speciesId: selectedAncestor.id == ''
                              ? selectedSpecies.id
                              : selectedAncestor.speciesId,
                          propagationMethod: propagationMethod,
                          nbSeedsEnvelope:
                              propagationMethod == PropagationMethod.seed
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
                          context: context.mounted ? context : context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                SeedLibraryTextConstants.writeReference +
                                    plantList[-1].plantReference,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child:
                                      const Text(SeedLibraryTextConstants.ok),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        displayToastWithContext(
                          TypeMsg.error,
                          AdminTextConstants.addingError,
                        );
                      }
                      selectedSpeciesNotifier.setSpecies(Species.empty());
                      selectedAncestorNotifier.setPlant(PlantSimple.empty());
                      seedQuantity.clear();
                      notes.clear();
                    });
                  },
                  child: const Text(
                    AdminTextConstants.add,
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
        ),
      ),
    );
  }
}
