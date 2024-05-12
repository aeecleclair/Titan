import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_kind_provider.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/components/kinds_bar.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';

class AssociationInformationEditor extends HookConsumerWidget {
  final scrollKey = GlobalKey();
  AssociationInformationEditor({
    super.key,
  });

  @override
  Widget build(context, ref) {
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final kind = ref.watch(associationKindProvider);
    final association = ref.watch(associationProvider);
    final name = useTextEditingController(text: association.name);
    final description = useTextEditingController(text: association.description);
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final key = GlobalKey<FormState>();

    return Form(
      key: key,
      child: Column(
        children: [
          KindsBar(key: scrollKey),
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: TextFormField(
                          controller: description,
                          cursorColor: ColorConstants.gradient1,
                          decoration: InputDecoration(
                            labelText: PhonebookTextConstants.description,
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
                    if (kind == '') {
                      displayToastWithContext(
                        TypeMsg.error,
                        PhonebookTextConstants.emptyKindError,
                      );
                      return;
                    }
                    await tokenExpireWrapper(ref, () async {
                      final value =
                          await associationListNotifier.updateAssociation(
                        association.copyWith(
                          name: name.text,
                          description: description.text,
                          kind: kind,
                        ),
                      );
                      if (value) {
                        displayToastWithContext(
                          TypeMsg.msg,
                          PhonebookTextConstants.updatedAssociation,
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
    );
  }
}
