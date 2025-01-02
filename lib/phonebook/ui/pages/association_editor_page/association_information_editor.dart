import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/providers/is_admin_provider.dart';
import 'package:myecl/phonebook/providers/association_kind_provider.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_admin_provider.dart';
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
    final isAdmin = ref.watch(isAdminProvider);
    final isPhonebookAdmin = ref.watch(isPhonebookAdminProvider);

    final groups = ref.watch(allGroupListProvider);
    List<SimpleGroup> selectedGroups = groups.maybeWhen(
      data: (value) {
        return value.where((element) {
          return association.associatedGroups.contains(element.id);
        }).toList();
      },
      orElse: () {
        return [];
      },
    );
    final key = GlobalKey<FormState>();

    return Column(
      children: [
        isPhonebookAdmin && !association.deactivated
            ? Form(
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
                                    cursorColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    decoration: InputDecoration(
                                      labelText:
                                          PhonebookTextConstants.namePure,
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
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return PhonebookTextConstants
                                            .emptyFieldError;
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
                                    cursorColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    decoration: InputDecoration(
                                      labelText:
                                          PhonebookTextConstants.description,
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
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
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
                              colors: [
                                Theme.of(context).colorScheme.primaryContainer,
                                Theme.of(context).colorScheme.primaryFixed
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
                                final value = await associationListNotifier
                                    .updateAssociation(
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
                            child: Text(
                              PhonebookTextConstants.edit,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    if (association.deactivated)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          PhonebookTextConstants.deactivatedAssociationWarning,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        association.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        child: Text(
                          association.description,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        if (isAdmin && !association.deactivated)
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
                        child: ExpansionTile(
                          title: const Text(PhonebookTextConstants.groups),
                          children: groups.maybeWhen(
                            data: (data) {
                              return data.map((group) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor,
                                        offset: const Offset(0, 1),
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          group.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      StatefulBuilder(
                                        builder: (context, setState) {
                                          return Checkbox(
                                            value:
                                                selectedGroups.contains(group),
                                            onChanged: (value) {
                                              if (value == true) {
                                                selectedGroups.add(group);
                                              } else {
                                                selectedGroups.remove(group);
                                              }
                                              setState(() {});
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }).toList();
                            },
                            orElse: () {
                              return [];
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                WaitingButton(
                  builder: (child) => AddEditButtonLayout(
                    colors: [
                      Theme.of(context).colorScheme.primaryContainer,
                      Theme.of(context).colorScheme.primaryFixed,
                    ],
                    child: child,
                  ),
                  onTap: () async {
                    await tokenExpireWrapper(ref, () async {
                      final value =
                          await associationListNotifier.updateAssociationGroups(
                        association.copyWith(
                          associatedGroups:
                              selectedGroups.map((e) => e.id).toList(),
                        ),
                      );
                      if (value) {
                        displayToastWithContext(
                          TypeMsg.msg,
                          PhonebookTextConstants.updatedGroups,
                        );
                      } else {
                        displayToastWithContext(
                          TypeMsg.msg,
                          PhonebookTextConstants.updatingError,
                        );
                      }
                    });
                  },
                  child: Text(
                    PhonebookTextConstants.updateGroups,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
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
