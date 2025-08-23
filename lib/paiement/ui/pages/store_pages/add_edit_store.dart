import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/class/store.dart' as store_class;
import 'package:titan/paiement/class/structure.dart';
import 'package:titan/paiement/providers/my_stores_provider.dart';
import 'package:titan/paiement/providers/selected_structure_provider.dart';
import 'package:titan/paiement/providers/store_provider.dart';
import 'package:titan/paiement/providers/stores_list_provider.dart';
import 'package:titan/paiement/ui/paiement.dart';
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
                isEdit
                    ? AppLocalizations.of(
                        context,
                      )!.paiementEditStore(store.name)
                    : AppLocalizations.of(context)!.paiementAddStore,
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
                          label: AppLocalizations.of(
                            context,
                          )!.paiementStoreName,
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
                            final successfullyAddedStoreMsg = isEdit
                                ? AppLocalizations.of(
                                    context,
                                  )!.paiementSuccessfullyModifiedStore
                                : AppLocalizations.of(
                                    context,
                                  )!.paiementSuccessfullyAddedStore;
                            final addingErrorMsg = isEdit
                                ? AppLocalizations.of(
                                    context,
                                  )!.paiementModifyingStoreError
                                : AppLocalizations.of(
                                    context,
                                  )!.paiementAddingStoreError;

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
                                  successfullyAddedStoreMsg,
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  addingErrorMsg,
                                );
                              }
                            }
                          },
                          child: Text(
                            isEdit
                                ? AppLocalizations.of(context)!.paiementModify
                                : AppLocalizations.of(context)!.paiementAdd,
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
