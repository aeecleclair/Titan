import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/class/membership.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/membership_provider.dart';
import 'package:titan/phonebook/providers/phonebook_admin_provider.dart';
import 'package:titan/phonebook/providers/roles_tags_provider.dart';
import 'package:titan/phonebook/ui/pages/membership_editor_page/user_search_modal.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
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
    final isEdit = membership.id != Membership.empty().id;
    final associationMemberListNotifier = ref.watch(
      associationMemberListProvider.notifier,
    );
    final apparentNameController = useTextEditingController(
      text: membership.apparentName,
    );
    final associationMembers = ref.watch(associationMemberListProvider);
    final isPhonebookAdmin = ref.watch(isPhonebookAdminProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final selectedTags = useState<List<String>>(
      List.from(membership.rolesTags),
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

      final membershipAdd = Membership(
        id: "",
        memberId: member.member.id,
        associationId: association.id,
        rolesTags: selectedTags.value,
        apparentName: apparentNameController.text,
        mandateYear: association.mandateYear,
        order: associationMembers.maybeWhen(
          data: (members) => members.length,
          orElse: () => 0,
        ),
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
      final membershipEdit = Membership(
        id: membership.id,
        memberId: membership.memberId,
        associationId: membership.associationId,
        rolesTags: selectedTags.value,
        apparentName: apparentNameController.text,
        mandateYear: membership.mandateYear,
        order: membership.order,
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
                  title: member.member.id == ""
                      ? localizeWithContext.phonebookSearchUser
                      : member.member.getName(),
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
                    member.member.nickname ?? member.getName(),
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
                    children: tagList
                        .map(
                          (tag) => ToggleListItem(
                            title: tag,
                            onTap: tagList.first == tag && !isPhonebookAdmin
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
                  if (member.member.id == "") {
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

                  tokenExpireWrapper(ref, () async {
                    if (isEdit) {
                      await updateMember();
                    } else {
                      await addMember();
                    }
                  });
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
