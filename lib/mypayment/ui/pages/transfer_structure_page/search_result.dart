import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/providers/selected_store_provider.dart';
import 'package:titan/mypayment/providers/transfer_structure_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:titan/user/providers/user_list_provider.dart';

class SearchResult extends HookConsumerWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final selectedStore = ref.watch(selectedStoreProvider);
    final usersNotifier = ref.watch(userList.notifier);
    final transferStructureNotifier = ref.watch(
      transferStructureProvider.notifier,
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    Future showTransferWarningDialog(SimpleUser simpleUser) async {
      await showDialog(
        context: context,
        builder: (context) {
          return CustomDialogBox(
            title: 'Transfert de structure',
            descriptions:
                'Vous êtes sur le point de transférer la structure à ${simpleUser.getName()}. Le nouveau responsable aura accès à toutes les fonctionnalités de gestion de la structure. Vous allez recevoir un email pour valider ce transfert. Le lien ne sera actif que pendant 20 minutes. Cette action est irréversible. Êtes-vous sûr de vouloir continuer ?',
            onYes: () async {
              final value = await transferStructureNotifier.initTransfer(
                selectedStore.structure,
                simpleUser.id,
              );
              if (value) {
                displayToastWithContext(
                  TypeMsg.msg,
                  "Transfert de structure demandé avec succès.",
                );
              } else {
                displayToastWithContext(
                  TypeMsg.error,
                  "Une erreur est survenue lors du transfert de structure.",
                );
              }
            },
          );
        },
      );
    }

    return AsyncChild(
      value: users,
      builder: (context, value) => Column(
        children: value
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        e.getName(),
                        style: const TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        WaitingButton(
                          onTap: () async {
                            await showTransferWarningDialog(e);
                            usersNotifier.clear();
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          waitingColor: Color.fromARGB(255, 0, 29, 29),
                          builder: (child) => child,
                          child: const HeroIcon(HeroIcons.plus),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
      loaderColor: ColorConstants.gradient1,
    );
  }
}
