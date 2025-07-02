import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/class/membership.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/member_role_tags_provider.dart';
import 'package:titan/phonebook/providers/membership_provider.dart';
import 'package:titan/phonebook/providers/phonebook_admin_provider.dart';
import 'package:titan/phonebook/providers/roles_tags_provider.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/widgets/styled_search_bar.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/phonebook/providers/complete_member_provider.dart';
import 'package:titan/phonebook/ui/pages/membership_editor_page/search_result.dart';
import 'package:titan/l10n/app_localizations.dart';

class MembershipEditorPage extends HookConsumerWidget {
  const MembershipEditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesTagList = ref.watch(rolesTagsProvider);
    final queryController = useTextEditingController(text: '');
    final usersNotifier = ref.watch(userList.notifier);
    final rolesTagsNotifier = ref.watch(rolesTagsProvider.notifier);
    final member = ref.watch(completeMemberProvider);
    final membership = ref.watch(membershipProvider);
    final association = ref.watch(associationProvider);
    final isEdit = membership.id != Membership.empty().id;
    final associationMemberListNotifier = ref.watch(
      associationMemberListProvider.notifier,
    );
    final memberRoleTagsNotifier = ref.watch(memberRoleTagsProvider.notifier);
    final memberRoleTags = ref.watch(memberRoleTagsProvider);
    final apparentNameController = useTextEditingController(
      text: membership.apparentName,
    );
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
                    ? AppLocalizations.of(context)!.phonebookEditMembership
                    : AppLocalizations.of(context)!.phonebookAddMember,
              ),
              if (!isEdit) ...[
                StyledSearchBar(
                  padding: EdgeInsets.zero,
                  label: AppLocalizations.of(context)!.phonebookMember,
                  editingController: queryController,
                  onChanged: (value) async {
                    tokenExpireWrapper(ref, () async {
                      if (value.isNotEmpty) {
                        await usersNotifier.filterUsers(value);
                      } else {
                        usersNotifier.clear();
                      }
                    });
                  },
                ),
                SearchResult(queryController: queryController),
              ] else
                member.member.nickname == null
                    ? Text(
                        "${member.member.firstname} ${member.member.name}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Text(
                        "${member.member.nickname} (${member.member.firstname} ${member.member.name})",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              const SizedBox(height: 10),
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
                            fillColor:
                                rolesTagList.keys.first == tagKey &&
                                    !isPhonebookAdmin
                                ? WidgetStateProperty.all(Colors.black)
                                : WidgetStateProperty.all(Colors.grey),
                            onChanged:
                                rolesTagList.keys.first == tagKey &&
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
                label: AppLocalizations.of(context)!.phonebookApparentName,
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
                      ? AppLocalizations.of(context)!.phonebookAdd
                      : AppLocalizations.of(context)!.phonebookEdit,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                onTap: () async {
                  if (member.member.id == "") {
                    displayToastWithContext(
                      TypeMsg.msg,
                      AppLocalizations.of(context)!.phonebookEmptyMember,
                    );
                    return;
                  }
                  if (apparentNameController.text == "") {
                    displayToastWithContext(
                      TypeMsg.msg,
                      AppLocalizations.of(context)!.phonebookEmptyApparentName,
                    );
                    return;
                  }

                  tokenExpireWrapper(ref, () async {
                    if (isEdit) {
                      final membershipEdit = Membership(
                        id: membership.id,
                        memberId: membership.memberId,
                        associationId: membership.associationId,
                        rolesTags: memberRoleTags,
                        apparentName: apparentNameController.text,
                        mandateYear: membership.mandateYear,
                        order: membership.order,
                      );
                      member.memberships[member.memberships.indexWhere(
                            (membership) => membership.id == membershipEdit.id,
                          )] =
                          membershipEdit;
                      final value = await associationMemberListNotifier
                          .updateMember(member, membershipEdit);
                      if (value) {
                        associationMemberListNotifier.loadMembers(
                          association.id,
                          association.mandateYear.toString(),
                        );
                        displayToastWithContext(
                          TypeMsg.msg,
                          AppLocalizations.of(context)!.phonebookUpdatedMember,
                        );
                        QR.back();
                      } else {
                        displayToastWithContext(
                          TypeMsg.error,
                          AppLocalizations.of(context)!.phonebookUpdatingError,
                        );
                      }
                    } else {
                      // Test if the membership already exists with (association_id,member_id,mandate_year)
                      final memberAssociationMemberships = member.memberships
                          .where(
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
                          AppLocalizations.of(context)!.phonebookExistingMembership,
                        );
                        return;
                      }

                      final membershipAdd = Membership(
                        id: "",
                        memberId: member.member.id,
                        associationId: association.id,
                        rolesTags: memberRoleTags,
                        apparentName: apparentNameController.text,
                        mandateYear: association.mandateYear,
                        order: associationMembers.maybeWhen(
                          data: (members) => members.length,
                          orElse: () => 0,
                        ),
                      );
                      final value = await associationMemberListNotifier
                          .addMember(member, membershipAdd);
                      if (value) {
                        displayToastWithContext(
                          TypeMsg.msg,
                          AppLocalizations.of(context)!.phonebookAddedMember,
                        );
                        QR.back();
                      } else {
                        displayToastWithContext(
                          TypeMsg.error,
                          AppLocalizations.of(context)!.phonebookAddingError,
                        );
                      }
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
