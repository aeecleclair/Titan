import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/is_edit_provider.dart';
import 'package:myecl/phonebook/providers/member_role_tags_provider.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/tools/function.dart';
import 'package:myecl/phonebook/ui/phonebook.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/widgets/styled_search_bar.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/phonebook/ui/pages/membership_editor_page/search_result.dart';

class MembershipEditorPage extends HookConsumerWidget {
  const MembershipEditorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesTagList = ref.watch(rolesTagsProvider);
    final queryController = useTextEditingController(text: '');
    final usersNotifier = ref.watch(userList.notifier);
    final rolesTagsNotifier = ref.watch(rolesTagsProvider.notifier);
    final apparentNameController = useTextEditingController(text: '');
    final member = ref.watch(completeMemberProvider);
    final association = ref.watch(associationProvider);
    final isEdit = ref.watch(isEditProvider);
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final associationMemberListNotifier =
        ref.watch(associationMemberListProvider.notifier);
    final memberRoleTagsNotifier = ref.watch(memberRoleTagsProvider.notifier);
    final memberRoleTags = ref.watch(memberRoleTagsProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    if (isEdit) {
      apparentNameController.text = member.memberships
          .where((e) => e.associationId == association.id)
          .toList()[0]
          .apparentName;
    }

    return PhonebookTemplate(
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                AlignLeftText(isEdit
                    ? PhonebookTextConstants.editMembership
                    : PhonebookTextConstants.addMember),
                if (!isEdit)
                  StyledSearchBar(
                    padding: EdgeInsets.zero,
                    label: PhonebookTextConstants.member,
                    onChanged: (value) async {
                      tokenExpireWrapper(ref, () async {
                        queryController.text = value;
                        if (value.isNotEmpty) {
                          await usersNotifier.filterUsers(value);
                        } else {
                          usersNotifier.clear();
                        }
                      });
                    },
                  ),
                const SizedBox(
                  height: 10,
                ),
                SearchResult(queryController: queryController),
                SizedBox(
                  width: min(MediaQuery.of(context).size.width, 300),
                  child: AsyncChild(
                    value: rolesTagList,
                    builder: (context, rolesTags) => Column(children: [
                      ...rolesTags.keys.map(
                        (tagKeys) => Row(
                          children: [
                            Text(tagKeys),
                            const Spacer(),
                            Checkbox(
                              value: rolesTags[tagKeys]!.maybeWhen(
                                data: (d) => d[0],
                                orElse: () => false,
                              ),
                              fillColor:
                                  MaterialStateProperty.all(Colors.black),
                              onChanged: (value) {
                                rolesTags[tagKeys] = AsyncData([value!]);
                                apparentNameController.text =
                                    nameConstructor(rolesTags);
                                memberRoleTagsNotifier
                                    .setRoleTagsWithFilter(rolesTags);
                                rolesTagsNotifier.setTData(
                                    tagKeys, AsyncData([value]));
                              },
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
                const SizedBox(height: 30),
                TextEntry(
                  controller: apparentNameController,
                  label: PhonebookTextConstants.apparentName,
                ),
                const SizedBox(height: 50),
                WaitingButton(
                  builder: (child) => AddEditButtonLayout(colors: const [
                    ColorConstants.gradient1,
                    ColorConstants.gradient2,
                  ], child: child),
                  child: Text(
                      !isEdit
                          ? PhonebookTextConstants.add
                          : PhonebookTextConstants.edit,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                  onTap: () async {
                    if (member.member.id == "") {
                      displayToastWithContext(
                          TypeMsg.msg, PhonebookTextConstants.emptyMember);
                      return;
                    }
                    if (apparentNameController.text == "") {
                      displayToastWithContext(TypeMsg.msg,
                          PhonebookTextConstants.emptyApparentName);
                      return;
                    }
                    tokenExpireWrapper(ref, () async {
                      if (isEdit) {
                        final value = await associationNotifier.updateMember(
                            member.memberships.firstWhere((element) =>
                                element.associationId == association.id),
                            association,
                            member.member,
                            memberRoleTags,
                            apparentNameController.text);
                        if (value) {
                          associationMemberListNotifier.loadMembers(
                              association.id,
                              association.mandateYear.toString(),
                              ref);
                          displayToastWithContext(TypeMsg.msg,
                              PhonebookTextConstants.updatedMember);
                          QR.back();
                        } else {
                          displayToastWithContext(TypeMsg.error,
                              PhonebookTextConstants.updatingError);
                        }
                      } else {
                        final value = await associationNotifier.addMember(
                            association,
                            member.member,
                            memberRoleTags,
                            apparentNameController.text);
                        if (value) {
                          associationMemberListNotifier.loadMembers(
                              association.id,
                              association.mandateYear.toString(),
                              ref);
                          displayToastWithContext(
                              TypeMsg.msg, PhonebookTextConstants.addedMember);
                          QR.back();
                        } else {
                          displayToastWithContext(TypeMsg.error,
                              PhonebookTextConstants.addingError);
                        }
                      }
                    });
                  },
                ),
              ],
            ))));
  }
}
