import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/providers/selected_structure_provider.dart';
import 'package:titan/mypayment/providers/structure_list_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/user/providers/user_list_provider.dart';

class MemberResults extends HookConsumerWidget {
  final ValueNotifier<bool> add;
  const MemberResults({super.key, required this.add});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final structure = ref.watch(selectedStructureProvider);
    final structureNotifier = ref.watch(selectedStructureProvider.notifier);
    final structureListNotifier = ref.watch(structureListProvider.notifier);
    final users = ref.watch(userList);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
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
                            if (!structure.administrators.contains(e)) {
                              await tokenExpireWrapper(ref, () async {
                                structureListNotifier
                                    .addStructureAdministrator(structure, e.id)
                                    .then((value) {
                                      if (value.id.isNotEmpty) {
                                        structureNotifier.setStructure(
                                          structure.copyWith(
                                            administrators: [
                                              ...structure.administrators,
                                              value,
                                            ],
                                          ),
                                        );
                                        displayToastWithContext(
                                          TypeMsg.msg,
                                          "${value.getName()} a été ajouté en tant qu'administrateur de la structure",
                                        );
                                        add.value = false;
                                      } else {
                                        displayToastWithContext(
                                          TypeMsg.error,
                                          "Une erreur est survenue",
                                        );
                                      }
                                    });
                              });
                            }
                          },
                          waitingColor: ColorConstants.gradient1,
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
