import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/seed-library/providers/plant_complete_provider.dart';
import 'package:myecl/seed-library/providers/species_list_provider.dart';
import 'package:myecl/seed-library/tools/constants.dart';
import 'package:myecl/seed-library/tools/functions.dart';
import 'package:myecl/seed-library/ui/seed_library.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PlantDetailPage extends HookConsumerWidget {
  const PlantDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plant = ref.watch(plantProvider);
    final plantNotifier = ref.watch(plantProvider.notifier);
    final species = ref.watch(syncSpeciesListProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SeedLibraryTemplate(
      child: AsyncChild(
        value: plant,
        builder: (context, plantComplete) => Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.lightGreen.withAlpha(100),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                'Référence: ${plantComplete.plantReference}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'Espcèce: ${species.firstWhere((element) => element.id == plantComplete.speciesId).name}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'Méthode de propagation: ${plantComplete.propagationMethod.name}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(height: 10),
              if (plantComplete.propagationMethod ==
                  PropagationMethod.graine) ...[
                Text(
                  'Nombre de graines: ${plantComplete.nbSeedsEnvelope}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 10),
              ],
              SizedBox(height: 10),
              Text(
                plantComplete.previousNote ?? '',
              ),
              WaitingButton(
                builder: (child) => AddEditButtonLayout(
                  colors: const [
                    Color.fromARGB(255, 58, 188, 26),
                    Color.fromARGB(255, 19, 116, 14),
                  ],
                  child: child,
                ),
                onTap: () async {
                  await tokenExpireWrapper(ref, () async {
                    final value =
                        await plantNotifier.borrowIdPlant(plantComplete);
                    if (value) {
                      displayToastWithContext(
                        TypeMsg.msg,
                        SeedLibraryTextConstants.borrowedPlant,
                      );
                    } else {
                      displayToastWithContext(
                        TypeMsg.error,
                        SeedLibraryTextConstants.addingError,
                      );
                    }
                    QR.back();
                  });
                },
                child: const Text(
                  SeedLibraryTextConstants.borrowPlant,
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
    );
  }
}
