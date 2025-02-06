import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/association_membership_list_provider.dart';
import 'package:myecl/admin/providers/association_membership_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';

class AssociationMembershipInformationEditor extends HookConsumerWidget {
  final scrollKey = GlobalKey();
  AssociationMembershipInformationEditor({
    super.key,
  });

  @override
  Widget build(context, ref) {
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final associationMembership = ref.watch(associationMembershipProvider);
    final associationMembershipNotifier =
        ref.watch(associationMembershipProvider.notifier);
    final name = useTextEditingController(text: associationMembership.name);
    final associationMembershipListNotifier =
        ref.watch(allAssociationMembershipListProvider.notifier);
    final key = GlobalKey<FormState>();

    return Column(
      children: [
        Form(
          key: key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
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
                                labelText: PhonebookTextConstants.namePure,
                                labelStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                suffixIcon: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const HeroIcon(
                                    HeroIcons.pencil,
                                  ),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorConstants.gradient1,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return PhonebookTextConstants.emptyFieldError;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            associationMembership.copyWith(
                              name: name.text,
                            ),
                          );
                          if (value) {
                            associationMembershipNotifier
                                .setAssociationMembership(
                              associationMembership.copyWith(
                                name: name.text,
                              ),
                            );
                            displayToastWithContext(
                              TypeMsg.msg,
                              AdminTextConstants.updatedAssociationMembership,
                            );
                          } else {
                            displayToastWithContext(
                              TypeMsg.msg,
                              PhonebookTextConstants.updatingError,
                            );
                          }
                        });
                      },
                      child: const Text(
                        PhonebookTextConstants.edit,
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
          ),
        ),
      ],
    );
  }
}
