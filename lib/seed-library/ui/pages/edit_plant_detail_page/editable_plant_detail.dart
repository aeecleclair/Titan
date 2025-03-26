import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/seed-library/class/plant_complete.dart';
import 'package:myecl/seed-library/providers/plant_complete_provider.dart';
import 'package:myecl/seed-library/providers/plants_list_provider.dart';
import 'package:myecl/seed-library/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/widgets/date_entry.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';

class EditablePlantDetail extends HookConsumerWidget {
  final PlantComplete plant;
  const EditablePlantDetail({super.key, required this.plant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantNotifier = ref.watch(plantProvider.notifier);
    final myPlantsNotifier = ref.watch(myPlantListProvider.notifier);
    final name =
        useTextEditingController(text: plant.nickname ?? plant.plantReference);
    final notes = useTextEditingController(text: plant.currentNote);
    final plantationDate = useTextEditingController(
      text: plant.plantingDate != null ? processDate(plant.plantingDate!) : '',
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.lightGreen.withAlpha(50),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextEntry(
              controller: name,
              label: 'Nom',
            ),
            SizedBox(height: 10),
            if (plant.nickname != null) ...[
              Text(
                'Référence: ${plant.plantReference}',
              ),
              SizedBox(height: 10),
            ],
            Text(
              'Méthode de propagation: ${plant.propagationMethod.name}',
            ),
            SizedBox(height: 10),
            Text(
              'Nombre de graines: ${plant.nbSeedsEnvelope}',
            ),
            SizedBox(height: 30),
            if (plant.borrowingDate != null) ...[
              Text(
                'Date de prêt: ${processDate(plant.borrowingDate!)}',
              ),
              SizedBox(height: 10),
              if (plant.plantingDate == null) ...[
                WaitingButton(
                  onTap: () {
                    plantNotifier.updatePlant(
                      plant.copyWith(
                        plantingDate: DateTime.now(),
                      ),
                    );
                    return Future.value();
                  },
                  builder: (child) => child,
                  waitingColor: Colors.green,
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text("Je la plante maintenant")),
                ),
                SizedBox(height: 10),
              ],
              DateEntry(
                controller: plantationDate,
                label: 'Date de plantation',
                onTap: () {
                  getOnlyDayDate(
                    context,
                    plantationDate,
                    firstDate: plant.borrowingDate,
                    lastDate: DateTime.now(),
                    initialDate: DateTime.now(),
                  );
                  plantNotifier.updatePlant(
                    plant.copyWith(
                      plantingDate: plantationDate.text.isNotEmpty
                          ? DateTime.parse(processDateBack(plantationDate.text))
                          : null,
                    ),
                  );
                },
              ),
              SizedBox(height: 30),
            ],
            TextEntry(
              controller: notes,
              label: 'Notes',
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                plantNotifier.updatePlant(
                  plant.copyWith(
                    currentNote: value,
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            WaitingButton(
              onTap: () async {
                bool value = await plantNotifier.updatePlant(
                  plant.copyWith(
                    nickname: name.text,
                    currentNote: notes.text,
                  ),
                );
                if (value) {
                  displayToastWithContext(
                    TypeMsg.msg,
                    SeedLibraryTextConstants.updatedPlant,
                  );
                  myPlantsNotifier.updatePlantInList(
                    plant
                        .copyWith(
                          nickname: name.text,
                          currentNote: notes.text,
                        )
                        .toPlantSimple(),
                  );
                } else {
                  displayToastWithContext(
                    TypeMsg.error,
                    SeedLibraryTextConstants.updatingError,
                  );
                }
                ;
              },
              builder: (child) => child,
              waitingColor: Colors.green,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text("Enregistrer les modifications"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
