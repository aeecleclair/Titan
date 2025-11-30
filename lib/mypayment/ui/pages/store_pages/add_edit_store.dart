import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/class/store.dart' as store_class;
import 'package:titan/mypayment/class/structure.dart';
import 'package:titan/mypayment/providers/my_stores_provider.dart';
import 'package:titan/mypayment/providers/selected_structure_provider.dart';
import 'package:titan/mypayment/providers/store_provider.dart';
import 'package:titan/mypayment/providers/stores_list_provider.dart';
import 'package:titan/mypayment/ui/mypayment.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditStorePage extends HookConsumerWidget {
  const AddEditStorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(storeProvider);
    final storeListNotifier = ref.watch(storeListProvider.notifier);
    final key = GlobalKey<FormState>();
    final isEdit = store.id != store_class.Store.empty().id;
    final name = useTextEditingController(text: store.name);
    Structure structure = ref.watch(selectedStructureProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PaymentTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: key,
          child: Column(
            children: [
              const SizedBox(height: 10),
              AlignLeftText(
                "${isEdit ? 'Modifier' : 'Ajouter'} une association ${structure.name}",
                padding: const EdgeInsets.symmetric(horizontal: 30),
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        TextEntry(
                          controller: name,
                          label: "Nom de l'association",
                        ),
                        const SizedBox(height: 50),
                        WaitingButton(
                          builder: (child) => AddEditButtonLayout(
                            colors: const [
                              Color.fromARGB(255, 6, 75, 75),
                              Color.fromARGB(255, 0, 29, 29),
                            ],
                            child: child,
                          ),
                          onTap: () async {
                            if (key.currentState == null) {
                              return;
                            }
                            if (key.currentState!.validate()) {
                              store_class.Store newStore = store.copyWith(
                                name: name.text,
                                structure: structure,
                              );
                              final value = isEdit
                                  ? await storeListNotifier.updateStore(
                                      newStore,
                                    )
                                  : await storeListNotifier.createStore(
                                      structure,
                                      newStore,
                                    );
                              if (value) {
                                ref
                                    .watch(myStoresProvider.notifier)
                                    .getMyStores();
                                QR.back();
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  isEdit
                                      ? "L'association a été modifiée avec succès"
                                      : "L'association a été ajoutée avec succès",
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  isEdit
                                      ? "Une erreur est survenue lors de la modification de l'association"
                                      : "Une erreur est survenue lors de l'ajout de l'association",
                                );
                              }
                            }
                          },
                          child: Text(
                            isEdit ? "Modifier" : "Ajouter",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
