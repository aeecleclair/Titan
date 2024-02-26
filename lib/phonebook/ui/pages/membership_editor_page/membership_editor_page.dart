import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/edition_provider.dart';
import 'package:myecl/phonebook/providers/member_role_tags_provider.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/tools/function.dart';
import 'package:myecl/phonebook/ui/phonebook.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/phonebook/ui/pages/membership_editor_page/search_result.dart';

class MembershipEditorPage extends HookConsumerWidget {
  const MembershipEditorPage({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesTags = ref.watch(rolesTagsProvider);
    final queryController = useTextEditingController(text: '');
    final usersNotifier = ref.watch(userList.notifier);
    final rolesTagsNotifier = ref.watch(rolesTagsProvider.notifier);
    final apparentNameController = useTextEditingController(text: '');
    final member = ref.watch(completeMemberProvider);
    final association = ref.watch(associationProvider);
    final edition = ref.watch(editionProvider);
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final associationMemberListNotifier =
        ref.watch(associationMemberListProvider.notifier);
    final memberRoleTagsNotifier = ref.watch(memberRoleTagsProvider.notifier);
    final memberRoleTags = ref.watch(memberRoleTagsProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    if (edition) {
      apparentNameController.text = member.memberships
          .where((e) => e.association.id == association.id)
          .toList()[0]
          .apparentName;
    }

    return PhonebookTemplate(
      child:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Center(
                  child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black)),
                        color: Colors.white,
                      ),
                      child: Text(
                          edition
                              ? PhonebookTextConstants.editMembership
                              : PhonebookTextConstants.addMember,
                          style: const TextStyle(fontSize: 20)))),
              if (!edition)
                TextFormField(
                  onChanged: (value) {
                    tokenExpireWrapper(ref, () async {
                      if (queryController.text.isNotEmpty) {
                        await usersNotifier.filterUsers(queryController.text);
                      } else {
                        usersNotifier.clear();
                      }
                    });
                  },
                  cursorColor: Colors.black,
                  controller: queryController,
                  decoration: const InputDecoration(
                    labelText: PhonebookTextConstants.member,
                    floatingLabelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              SearchResult(queryController: queryController),
              SizedBox(
                width: min(MediaQuery.of(context).size.width, 300),
                child: Column(children: [
                  ...rolesTags.when(
                    data: (data) {
                      return data.item1.tags
                          .map((e) => Row(children: [
                                Text(e),
                                const Spacer(),
                                Checkbox(
                                  value: data.item2[data.item1.tags.indexOf(e)],
                                  fillColor:
                                      MaterialStateProperty.all(Colors.black),
                                  onChanged: (value) {
                                    data.item2[data.item1.tags.indexOf(e)] =
                                        value!;
                                    debugPrint(data.item2.toString());
                                    apparentNameController.text =
                                        nameConstructor(data);
                                    memberRoleTagsNotifier
                                        .setRoleTagsWithFilter(data);
                                    rolesTagsNotifier.setChecked(
                                        data.item1.tags.indexOf(e), value);
                                  },
                                ),
                              ]))
                          .toList();
                    },
                    error: (e, s) => [const Text('Error')],
                    loading: () => [const Text('Loading')],
                  ),
                ]),
              ),
              const SizedBox(height: 5),
              const Text(PhonebookTextConstants.apparentName),
              TextField(
                controller: apparentNameController,
              ),
              const SizedBox(height: 5),
              ShrinkButton(
                child: Text(!edition
                    ? PhonebookTextConstants.add
                    : PhonebookTextConstants.edit),
                onTap: () async {
                  if (member.member.id == "") {
                    displayToastWithContext(
                        TypeMsg.msg, PhonebookTextConstants.emptyMember);
                    return;
                  }
                  if (apparentNameController.text == "") {
                    displayToastWithContext(
                        TypeMsg.msg, PhonebookTextConstants.emptyApparentName);
                    return;
                  }
                  debugPrint("Appui sur le bouton avec les paramètres:\n"
                      "association: $association\n"
                      "member: ${member.member}\n"
                      "rolesTags: $memberRoleTags\n"
                      "apparentName: ${apparentNameController.text}");
                  tokenExpireWrapper(ref, () async {
                    if (edition) {
                      final value = await associationNotifier.updateMember(
                          association,
                          member.member,
                          memberRoleTags,
                          apparentNameController.text);
                      if (value) {
                        associationMemberListNotifier.loadMembers(association.id, association.mandateYear.toString());
                        displayToastWithContext(
                            TypeMsg.msg, PhonebookTextConstants.updatedMember);
                        QR.back();
                      } else {
                        displayToastWithContext(
                            TypeMsg.msg, PhonebookTextConstants.updatingError);
                      }
                    } else {
                      final value = await associationNotifier.addMember(
                          association,
                          member.member,
                          memberRoleTags,
                          apparentNameController.text);
                      if (value) {
                        associationMemberListNotifier.loadMembers(association.id, association.mandateYear.toString());
                        displayToastWithContext(
                            TypeMsg.msg, PhonebookTextConstants.addedMember);
                        QR.back();
                      } else {
                        displayToastWithContext(
                            TypeMsg.msg, PhonebookTextConstants.addingError);
                      }
                    }
                  });
                },
              ),
            ],
          ))));
  }
}
