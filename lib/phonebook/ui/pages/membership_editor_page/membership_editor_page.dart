import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/phonebook/extensions/members.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/membership_provider.dart';
import 'package:titan/phonebook/providers/is_phonebook_admin_provider.dart';
import 'package:titan/phonebook/providers/roles_tags_provider.dart';
import 'package:titan/phonebook/ui/pages/membership_editor_page/user_search_modal.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/list_item_toggle.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/phonebook/providers/complete_member_provider.dart';
import 'package:titan/l10n/app_localizations.dart';

class MembershipEditorPage extends HookConsumerWidget {
  const MembershipEditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesTagList = ref.watch(rolesTagsProvider);
    final member = ref.watch(completeMemberProvider);
    final membership = ref.watch(membershipProvider);
    final association = ref.watch(associationProvider);
    final isEdit = membership.id != MembershipComplete.empty().id;
    final associationMemberListNotifier = ref.watch(
      associationMemberListProvider.notifier,
    );
    final apparentNameController = useTextEditingController(
      text: membership.roleName,
    );
    final isPhonebookAdmin = ref.watch(isPhonebookAdminProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final selectedTags = useState<List<String>>(
      List.from(
        membership.roleTags?.split(", ").where((tag) => tag != "") ?? [],
      ),
    );

    final localizeWithContext = AppLocalizations.of(context)!;

    Future addMember() async {
      final memberAssociationMemberships = member.memberships.where(
        (membership) => membership.associationId == association.id,
      );

      if (memberAssociationMemberships
          .where(
            (membership) => membership.mandateYear == association.mandateYear,
          )
          .isNotEmpty) {
        displayToastWithContext(
          TypeMsg.msg,
          localizeWithContext.phonebookExistingMembership,
        );
        return;
      }

      final membershipAdd = AppModulesPhonebookSchemasPhonebookMembershipBase(
        associationId: association.id,
        mandateYear: association.mandateYear,
        userId: membership.userId,
        roleName: apparentNameController.text,
        memberOrder: membership.memberOrder,
      );
      final value = await associationMemberListNotifier.addMember(
        member,
        membershipAdd,
      );
      if (value) {
        displayToastWithContext(
          TypeMsg.msg,
          localizeWithContext.phonebookAddedMember,
        );
        QR.back();
      } else {
        displayToastWithContext(
          TypeMsg.error,
          localizeWithContext.phonebookAddingError,
        );
      }
    }

    Future updateMember() async {
      final membershipEdit = MembershipComplete(
        id: membership.id,
        associationId: membership.associationId,
        mandateYear: membership.mandateYear,
        userId: membership.userId,
        roleName: apparentNameController.text,
        memberOrder: membership.memberOrder,
      );
      member.memberships[member.memberships.indexWhere(
            (membership) => membership.id == membershipEdit.id,
          )] =
          membershipEdit;
      final value = await associationMemberListNotifier.updateMember(
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
          localizeWithContext.phonebookUpdatedMember,
        );
        QR.back();
      } else {
        displayToastWithContext(
          TypeMsg.error,
          localizeWithContext.phonebookUpdatingError,
        );
      }
    }

    return PhonebookTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              if (!isEdit) ...[
                Text(
                  localizeWithContext.phonebookAddMember,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.title,
                  ),
                ),
                const SizedBox(height: 20),
                ListItem(
                  title: member.id == ""
                      ? localizeWithContext.phonebookSearchUser
                      : member.getName(),
                  onTap: () async {
                    showCustomBottomModal(
                      context: context,
                      modal: UserSearchModal(),
                      ref: ref,
                    );
                  },
                ),
              ] else
                Text(
                  localizeWithContext.phonebookModifyMembership(
                    member.nickname ?? member.getName(),
                  ),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.title,
                  ),
                ),
              const SizedBox(height: 10),
              rolesTagList.maybeWhen(
                orElse: () => Text(localizeWithContext.phonebookNoRoleTags),
                data: (tagList) {
                  return Column(
                    children: tagList.tags
                        .map(
                          (tag) => ToggleListItem(
                            title: tag,
                            onTap:
                                tagList.tags.first == tag && !isPhonebookAdmin
                                ? () {}
                                : () {
                                    final tags = [...selectedTags.value];
                                    final changeApparentName =
                                        apparentNameController.text ==
                                        tags.join(", ");
                                    tags.contains(tag)
                                        ? tags.remove(tag)
                                        : tags.add(tag);
                                    if (changeApparentName) {
                                      apparentNameController.text = tags.join(
                                        ", ",
                                      );
                                    }
                                    selectedTags.value = tags;
                                  },
                            selected: selectedTags.value.contains(tag),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: 20),
              TextEntry(
                controller: apparentNameController,
                label: localizeWithContext.phonebookApparentName,
              ),
              const SizedBox(height: 30),
              Button(
                text: isEdit
                    ? localizeWithContext.phonebookEdit
                    : localizeWithContext.phonebookAdd,
                onPressed: () async {
                  if (member.id == MemberComplete.empty().id) {
                    displayToastWithContext(
                      TypeMsg.msg,
                      localizeWithContext.phonebookEmptyMember,
                    );
                    return;
                  }
                  if (apparentNameController.text == "") {
                    displayToastWithContext(
                      TypeMsg.msg,
                      localizeWithContext.phonebookEmptyApparentName,
                    );
                    return;
                  }
                  if (isEdit) {
                    await updateMember();
                  } else {
                    await addMember();
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
