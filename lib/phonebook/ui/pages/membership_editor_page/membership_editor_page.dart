import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/member_role_tags_provider.dart';
import 'package:myecl/phonebook/providers/membership_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_admin_provider.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/phonebook.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
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
    final member = ref.watch(completeMemberProvider);
    final membership = ref.watch(membershipProvider);
    final association = ref.watch(associationProvider);
    final isEdit = membership.id != MembershipComplete.fromJson({}).id;
    final associationMemberListNotifier =
        ref.watch(associationMemberListProvider.notifier);
    final memberRoleTagsNotifier = ref.watch(memberRoleTagsProvider.notifier);
    final memberRoleTags = ref.watch(memberRoleTagsProvider);
    final apparentNameController =
        useTextEditingController(text: membership.roleName);
    final associationMembers = ref.watch(associationMemberListProvider);
    final isPhonebookAdmin = ref.watch(isPhonebookAdminProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PhonebookTemplate(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AlignLeftText(
                isEdit
                    ? PhonebookTextConstants.editMembership
                    : PhonebookTextConstants.addMember,
              ),
              if (!isEdit) ...[
                StyledSearchBar(
                  padding: EdgeInsets.zero,
                  label: PhonebookTextConstants.member,
                  editingController: queryController,
                  onChanged: (value) async {
                    tokenExpireWrapper(
                      ref,
                      () async {
                        if (value.isNotEmpty) {
                          await usersNotifier.filterUsers(value);
                        } else {
                          usersNotifier.clear();
                        }
                      },
                    );
                  },
                ),
                SearchResult(queryController: queryController),
              ] else
                //  Use extension
                member.nickname == null
                    ? Text(
                        "${member.firstname} ${member.name}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Text(
                        "${member.nickname} (${member.firstname} ${member.name})",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: min(MediaQuery.of(context).size.width, 300),
                child: Column(
                  children: [
                    ...rolesTagList.keys.map(
                      (tagKey) => Row(
                        children: [
                          Text(tagKey),
                          const Spacer(),
                          Checkbox(
                            value: rolesTagList[tagKey]!.maybeWhen(
                              data: (rolesTag) => rolesTag[0],
                              orElse: () => false,
                            ),
                            fillColor: rolesTagList.keys.first == tagKey &&
                                    !isPhonebookAdmin
                                ? WidgetStateProperty.all(Colors.black)
                                : WidgetStateProperty.all(Colors.grey),
                            onChanged: rolesTagList.keys.first == tagKey &&
                                    !isPhonebookAdmin
                                ? null
                                : (value) {
                                    rolesTagList[tagKey] = AsyncData([value!]);
                                    memberRoleTagsNotifier
                                        .setRoleTagsWithFilter(rolesTagList);
                                    rolesTagsNotifier.setTData(
                                      tagKey,
                                      AsyncData([value]),
                                    );
                                    if (value &&
                                        apparentNameController.text == "") {
                                      apparentNameController.text = tagKey;
                                    } else if (!value &&
                                        apparentNameController.text == tagKey) {
                                      apparentNameController.text = "";
                                    }
                                  },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              TextEntry(
                controller: apparentNameController,
                label: PhonebookTextConstants.apparentName,
              ),
              const SizedBox(height: 50),
              WaitingButton(
                builder: (child) => AddEditButtonLayout(
                  colors: const [
                    ColorConstants.gradient1,
                    ColorConstants.gradient2,
                  ],
                  child: child,
                ),
                child: Text(
                  !isEdit
                      ? PhonebookTextConstants.add
                      : PhonebookTextConstants.edit,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                onTap: () async {
                  if (member.id == MemberComplete.fromJson({}).id) {
                    displayToastWithContext(
                      TypeMsg.msg,
                      PhonebookTextConstants.emptyMember,
                    );
                    return;
                  }
                  if (apparentNameController.text == "") {
                    displayToastWithContext(
                      TypeMsg.msg,
                      PhonebookTextConstants.emptyApparentName,
                    );
                    return;
                  }

                  tokenExpireWrapper(
                    ref,
                    () async {
                      if (isEdit) {
                        final membershipEdit = membership.copyWith(
                          roleTags: memberRoleTags,
                          roleName: apparentNameController.text,
                        );
                        member.memberships[member.memberships.indexWhere(
                          (membership) => membership.id == membershipEdit.id,
                        )] = membershipEdit;
                        final value =
                            await associationMemberListNotifier.updateMember(
                          member,
                          membershipEdit,
                        );
                        if (value) {
                          associationMemberListNotifier.loadMembers(
                            association.id,
                            association.mandateYear,
                          );
                          displayToastWithContext(
                            TypeMsg.msg,
                            PhonebookTextConstants.updatedMember,
                          );
                          QR.back();
                        } else {
                          displayToastWithContext(
                            TypeMsg.error,
                            PhonebookTextConstants.updatingError,
                          );
                        }
                      } else {
                        // Test if the membership already exists with (association_id,member_id,mandate_year)
                        final memberAssociationMemberships =
                            member.memberships.where(
                          (membership) =>
                              membership.associationId == association.id,
                        );

                        if (memberAssociationMemberships
                            .where(
                              (membership) =>
                                  membership.mandateYear ==
                                  association.mandateYear,
                            )
                            .isNotEmpty) {
                          displayToastWithContext(
                            TypeMsg.msg,
                            PhonebookTextConstants.existingMembership,
                          );
                          return;
                        }

                        final membershipAdd =
                            AppModulesPhonebookSchemasPhonebookMembershipBase(
                          associationId: association.id,
                          roleName: apparentNameController.text,
                          mandateYear: association.mandateYear,
                          memberOrder: associationMembers.maybeWhen(
                            data: (members) => members.length,
                            orElse: () => 0,
                          ),
                          userId: member.id,
                        );
                        final value = await associationMemberListNotifier
                            .addMember(member, membershipAdd);
                        if (value) {
                          displayToastWithContext(
                            TypeMsg.msg,
                            PhonebookTextConstants.addedMember,
                          );
                          QR.back();
                        } else {
                          displayToastWithContext(
                            TypeMsg.error,
                            PhonebookTextConstants.addingError,
                          );
                        }
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
