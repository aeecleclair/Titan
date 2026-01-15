import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/admin/providers/structure_manager_provider.dart';
import 'package:titan/admin/providers/structure_provider.dart';
import 'package:titan/admin/router.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/admin/ui/components/item_card_ui.dart';
import 'package:titan/mypayment/class/structure.dart';
import 'package:titan/mypayment/providers/bank_account_holder_provider.dart';
import 'package:titan/mypayment/providers/structure_list_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/bottom_modal_template.dart';
import 'package:titan/tools/ui/layouts/button.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';

class StructureUi extends HookConsumerWidget {
  final Structure structure;
  const StructureUi({super.key, required this.structure});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final structuresNotifier = ref.watch(structureListProvider.notifier);
    final structureNotifier = ref.watch(structureProvider.notifier);
    final structureManagerNotifier = ref.watch(
      structureManagerProvider.notifier,
    );
    final bankAccountHolderNotifier = ref.watch(
      bankAccountHolderProvider.notifier,
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return GestureDetector(
      onTap: () => showCustomBottomModal(
        context: context,
        modal: BottomModalTemplate(
          title: structure.name,
          child: Column(
            children: [
              Button(
                onPressed: () {
                  structureNotifier.setStructure(structure);
                  structureManagerNotifier.setUser(structure.managerUser);

                  QR.to(
                    AdminRouter.root +
                        AdminRouter.structures +
                        AdminRouter.addEditStructure,
                  );
                  Navigator.of(context).pop();
                },
                text: AdminTextConstants.editStructure,
              ),
              const SizedBox(height: 10),
              Button(
                onPressed: () async {
                  final value = await bankAccountHolderNotifier
                      .updateBankAccountHolder(structure);
                  if (value) {
                    displayToastWithContext(
                      TypeMsg.msg,
                      AdminTextConstants.setAsBankAccountHolderSuccess,
                    );
                  } else {
                    displayToastWithContext(
                      TypeMsg.error,
                      AdminTextConstants.setAsBankAccountHolderError,
                    );
                  }
                },
                text: AdminTextConstants.setAsBankAccountHolder,
              ),
              const SizedBox(height: 10),
              Button.danger(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialogBox(
                        title: AdminTextConstants.delete,
                        descriptions: AdminTextConstants.deletingDescription,
                        onYes: () async {
                          tokenExpireWrapper(ref, () async {
                            final value = await structuresNotifier
                                .deleteStructure(structure);
                            if (value) {
                              displayToastWithContext(
                                TypeMsg.msg,
                                AdminTextConstants.deletedStructure,
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                AdminTextConstants.deletingStructureError,
                              );
                            }
                          });
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
                text: AdminTextConstants.deletedStructure,
              ),
            ],
          ),
        ),
      ),
      child: ItemCardUi(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              structure.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
