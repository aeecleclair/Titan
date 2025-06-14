import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/class/membership.dart';
import 'package:titan/phonebook/providers/association_kind_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/phonebook/providers/association_member_sorted_list_provider.dart';
import 'package:titan/phonebook/providers/association_picture_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/complete_member_provider.dart';
import 'package:titan/phonebook/providers/member_role_tags_provider.dart';
import 'package:titan/phonebook/providers/membership_provider.dart';
import 'package:titan/phonebook/providers/phonebook_admin_provider.dart';
import 'package:titan/phonebook/providers/roles_tags_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/phonebook/ui/pages/association_editor_page/association_information_editor.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/phonebook/ui/pages/association_editor_page/member_editable_card.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AssociationEditorPage extends HookConsumerWidget {
  final scrollKey = GlobalKey();
  AssociationEditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final association = ref.watch(associationProvider);
    final associationNotifier = ref.watch(associationProvider.notifier);
    final associationMemberListNotifier = ref.watch(
      associationMemberListProvider.notifier,
    );
    final associationMemberList = ref.watch(associationMemberListProvider);
    final associationMemberSortedList = ref.watch(
      associationMemberSortedListProvider,
    );
    final associationPictureNotifier = ref.watch(
      associationPictureProvider.notifier,
    );
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final rolesTagsNotifier = ref.watch(rolesTagsProvider.notifier);
    final membershipNotifier = ref.watch(membershipProvider.notifier);
    final completeMemberNotifier = ref.watch(completeMemberProvider.notifier);
    final memberRoleTagsNotifier = ref.watch(memberRoleTagsProvider.notifier);
    final isPhonebookAdmin = ref.watch(isPhonebookAdminProvider);
    final isAssociationPresident = ref.watch(isAssociationPresidentProvider);
    final kindNotifier = ref.watch(associationKindProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PhonebookTemplate(
      child: Refresher(
        onRefresh: () async {
          await associationMemberListNotifier.loadMembers(
            association.id,
            association.mandateYear.toString(),
          );
          await associationPictureNotifier.getAssociationPicture(
            association.id,
          );
        },
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.centerLeft,
              child: const Text(
                PhonebookTextConstants.edit,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.gradient1,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AssociationInformationEditor(),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  const Text(PhonebookTextConstants.members),
                  const Spacer(),
                  WaitingButton(
                    builder: (child) => Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            (isPhonebookAdmin || isAssociationPresident) &&
                                !association.deactivated
                            ? ColorConstants.gradient1
                            : ColorConstants.deactivated1,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: child,
                    ),
                    onTap:
                        (isPhonebookAdmin || isAssociationPresident) &&
                            !association.deactivated
                        ? () async {
                            rolesTagsNotifier.resetChecked();
                            memberRoleTagsNotifier.reset();
                            completeMemberNotifier.setCompleteMember(
                              CompleteMember.empty(),
                            );
                            membershipNotifier.setMembership(
                              Membership.empty().copyWith(
                                associationId: association.id,
                              ),
                            );
                            if (QR.currentPath.contains(
                              PhonebookRouter.admin,
                            )) {
                              QR.to(
                                PhonebookRouter.root +
                                    PhonebookRouter.admin +
                                    PhonebookRouter.editAssociation +
                                    PhonebookRouter.addEditMember,
                              );
                            } else {
                              QR.to(
                                PhonebookRouter.root +
                                    PhonebookRouter.associationDetail +
                                    PhonebookRouter.editAssociation +
                                    PhonebookRouter.addEditMember,
                              );
                            }
                          }
                        : () async {},
                    child: const HeroIcon(
                      HeroIcons.plus,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            AsyncChild(
              value: associationMemberList,
              builder: (context, associationMembers) =>
                  associationMembers.isEmpty
                  ? const Text(PhonebookTextConstants.noMember)
                  : (isPhonebookAdmin || isAssociationPresident) &&
                        !association.deactivated
                  ? SizedBox(
                      height: 400,
                      child: ReorderableListView(
                        proxyDecorator: (child, index, animation) {
                          return Material(
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        onReorder: (int oldIndex, int newIndex) async {
                          await tokenExpireWrapper(ref, () async {
                            final result = await associationMemberListNotifier
                                .reorderMember(
                                  associationMemberSortedList[oldIndex],
                                  associationMemberSortedList[oldIndex]
                                      .memberships
                                      .firstWhere(
                                        (element) =>
                                            element.associationId ==
                                                association.id &&
                                            element.mandateYear ==
                                                association.mandateYear,
                                      )
                                      .copyWith(order: newIndex),
                                  oldIndex,
                                  newIndex,
                                );
                            if (result) {
                              displayToastWithContext(
                                TypeMsg.msg,
                                PhonebookTextConstants.memberReordered,
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                PhonebookTextConstants.reorderingError,
                              );
                            }
                          });
                        },
                        children: associationMemberSortedList
                            .map(
                              (member) => MemberEditableCard(
                                deactivated: false,
                                key: ValueKey(member.member.id),
                                member: member,
                                association: association,
                              ),
                            )
                            .toList(),
                      ),
                    )
                  : SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: associationMembers.length,
                        itemBuilder: (context, index) {
                          return MemberEditableCard(
                            deactivated: true,
                            key: ValueKey(associationMembers[index].member.id),
                            member: associationMembers[index],
                            association: association,
                          );
                        },
                      ),
                    ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: WaitingButton(
                builder: (child) => AddEditButtonLayout(
                  colors: isPhonebookAdmin && !association.deactivated
                      ? [ColorConstants.gradient1, ColorConstants.gradient2]
                      : [
                          ColorConstants.deactivated1,
                          ColorConstants.deactivated2,
                        ],
                  child: child,
                ),
                onTap: isPhonebookAdmin && !association.deactivated
                    ? () async {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              PhonebookTextConstants.newMandate,
                            ),
                            content: const Text(
                              PhonebookTextConstants.changeMandateConfirm,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  PhonebookTextConstants.cancel,
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await tokenExpireWrapper(ref, () async {
                                    final value = await associationListNotifier
                                        .updateAssociation(
                                          association.copyWith(
                                            mandateYear:
                                                association.mandateYear + 1,
                                          ),
                                        );
                                    if (value) {
                                      displayToastWithContext(
                                        TypeMsg.msg,
                                        PhonebookTextConstants
                                            .newMandateConfirmed,
                                      );
                                      associationNotifier.setAssociation(
                                        association.copyWith(
                                          mandateYear:
                                              association.mandateYear + 1,
                                        ),
                                      );
                                      if (QR.currentPath.contains(
                                        PhonebookRouter.associationDetail,
                                      )) {
                                        kindNotifier.setKind("");
                                        QR.to(
                                          PhonebookRouter.root +
                                              PhonebookRouter.associationDetail,
                                        );
                                      }
                                    } else {
                                      displayToastWithContext(
                                        TypeMsg.error,
                                        PhonebookTextConstants
                                            .mandateChangingError,
                                      );
                                    }
                                  });
                                },
                                child: const Text(
                                  PhonebookTextConstants.validation,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    : () async {},
                child: Text(
                  "${PhonebookTextConstants.changeMandate} ${association.mandateYear + 1}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
