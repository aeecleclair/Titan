import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/all_groups_list_provider.dart';
import 'package:titan/admin/providers/association_membership_list_provider.dart';
import 'package:titan/admin/providers/association_membership_provider.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';

class AssociationMembershipInformationEditor extends HookConsumerWidget {
  final scrollKey = GlobalKey();
  AssociationMembershipInformationEditor({super.key});

  @override
  Widget build(context, ref) {
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final associationMembership = ref.watch(associationMembershipProvider);
    final associationMembershipNotifier = ref.watch(
      associationMembershipProvider.notifier,
    );
    final name = useTextEditingController(text: associationMembership.name);
    final groups = ref.watch(allGroupList);
    final groupIdController = useTextEditingController(
      text: associationMembership.managerGroupId,
    );
    final associationMembershipListNotifier = ref.watch(
      allAssociationMembershipListProvider.notifier,
    );
    final key = GlobalKey<FormState>();

    groups.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return Column(
      children: [
        Form(
          key: key,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: TextFormField(
                        controller: name,
                        cursorColor: ColorConstants.gradient1,
                        decoration: InputDecoration(
                          labelText: AdminTextConstants.name,
                          labelStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          suffixIcon: Container(
                            padding: const EdgeInsets.all(10),
                            child: const HeroIcon(HeroIcons.pencil),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorConstants.gradient1,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AdminTextConstants.emptyFieldError;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AdminTextConstants.group,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DropdownButtonFormField<String>(
                initialValue: groupIdController.text,
                onChanged: (String? newValue) {
                  groupIdController.text = newValue!;
                },
                items: groups
                    .map(
                      (group) => DropdownMenuItem<String>(
                        value: group.id,
                        child: Text(group.name),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                  hintText: AdminTextConstants.group,
                ),
              ),
              const SizedBox(height: 20),
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
                    return;
                  }

                  await tokenExpireWrapper(ref, () async {
                    final value = await associationMembershipListNotifier
                        .updateAssociationMembership(
                          associationMembership.copyWith(name: name.text),
                        );
                    if (value) {
                      associationMembershipNotifier.setAssociationMembership(
                        associationMembership.copyWith(
                          name: name.text,
                          managerGroupId: groupIdController.text,
                        ),
                      );
                      displayToastWithContext(
                        TypeMsg.msg,
                        AdminTextConstants.updatedAssociationMembership,
                      );
                    } else {
                      displayToastWithContext(
                        TypeMsg.msg,
                        AdminTextConstants.updatingError,
                      );
                    }
                  });
                },
                child: const Text(
                  AdminTextConstants.edit,
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
      ],
    );
  }
}
