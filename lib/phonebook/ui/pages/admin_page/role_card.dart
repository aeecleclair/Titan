import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/role.dart';
import 'package:myecl/phonebook/providers/role_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/delete_button.dart';
import 'package:myecl/phonebook/ui/text_input_dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/dialog.dart';

class RoleCard extends HookConsumerWidget {
  const RoleCard({super.key,
      required this.role
  });

  final Role role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleNotifier = ref.watch(roleProvider.notifier);
    final controller = TextEditingController();
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
        
        child: Row(
        children: [
          const SizedBox(width: 10),
          SizedBox(
              width: 200,
              child: Text(
                role.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          GestureDetector(
            onTap: (){
              roleNotifier.setRole(role);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return TextInputDialog(
                    controller: controller,
                    title: role.name,
                    text: PhonebookTextConstants.editRoleName,
                    defaultText: role.name,
                    onConfirm: (){
                      roleNotifier.updateRole(role.copyWith(name: controller.text));
                      Navigator.of(context).pop();
                    },);
                  });
                },
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(2, 3))
                ],
              ),
              child: const HeroIcon(HeroIcons.pencil,
                  color: Colors.black),
            ),
          ),
          const SizedBox(width: 10),
          DeleteButton(
            onDelete: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return CustomDialogBox(
                    title: PhonebookTextConstants.deleting,
                    descriptions:
                        PhonebookTextConstants.deleteRole,
                    onYes: () async {
                      tokenExpireWrapper(ref, () async {
                        final value = await roleNotifier
                            .deleteRole(role);
                        if (value) {
                          displayToastWithContext(
                              TypeMsg.msg,
                              PhonebookTextConstants.deletedRole);
                        } else {
                          displayToastWithContext(TypeMsg.error,
                              PhonebookTextConstants.deletingError);
                        }
                      });
                    },
                  );
                });
            },
          ),
        ],
      )
    );                        
  }
}