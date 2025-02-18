import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/class/store.dart' as store_class;
import 'package:myecl/paiement/class/structure.dart';
import 'package:myecl/paiement/providers/my_stores_provider.dart';
import 'package:myecl/paiement/providers/store_provider.dart';
import 'package:myecl/paiement/providers/stores_list_provider.dart';
import 'package:myecl/paiement/ui/paiement.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditStorePage extends HookConsumerWidget {
  const AddEditStorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(storeProvider);
    final myStores = ref.watch(myStoresProvider);
    final storeListNotifier = ref.watch(storeListProvider.notifier);
    final key = GlobalKey<FormState>();
    final isEdit = store.id != store_class.Store.empty().id;
    final name = useTextEditingController(text: store.name);
    final type =
        useState<Structure>(store.structure);

    final myStructures = <Structure>[];

    myStores.whenData(
      (value) {
        for (var store in value) {
          final myStructureIds = myStructures.map((e) => e.id).toList();
          if (!myStructureIds.contains(store.structure.id)) {
            myStructures.add(store.structure);
          }
        }
      },
    );

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
                "${isEdit ? 'Modifier' : 'Ajouter'} une association",
                padding: const EdgeInsets.symmetric(horizontal: 30),
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              HorizontalListView.builder(
                height: 40,
                items: myStructures,
                itemBuilder: (context, value, index) {
                  final selected = type.value == value;
                  return ItemChip(
                    selected: selected,
                    onTap: () async {
                      type.value = value;
                    },
                    child: Text(
                      value.name.toUpperCase(),
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
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
                              store_class.Store newStore = store_class.Store(
                                id: "",
                                walletId: "",
                                name: name.text,
                                structure: type.value,
                              );
                              // final value = isEdit
                              //     ? await storeListNotifier
                              //         .updateStore(newStore)
                              //     : await storeListNotifier
                              //         .createStore(newStore);
                              // if (value) {
                              //   ref
                              //       .watch(myStoresProvider.notifier)
                              //       .getMyStores();
                              //   QR.back();
                              //   displayToastWithContext(
                              //     TypeMsg.msg,
                              //     isEdit
                              //         ? "L'association a été modifiée avec succès"
                              //         : "L'association a été ajoutée avec succès",
                              //   );
                              // } else {
                              //   displayToastWithContext(
                              //     TypeMsg.error,
                              //     isEdit
                              //         ? "Une erreur est survenue lors de la modification de l'association"
                              //         : "Une erreur est survenue lors de l'ajout de l'association",
                              //   );
                              // }
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
