import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/class/membership.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/phonebook/providers/association_member_sorted_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/complete_member_provider.dart';
import 'package:titan/phonebook/providers/membership_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/ui/components/member_card.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/list_item_template.dart';

class AssociationMembersPage extends HookConsumerWidget {
  const AssociationMembersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final association = ref.watch(associationProvider);
    final associationMemberList = ref.watch(associationMemberListProvider);
    final associationMemberListNotifier = ref.watch(
      associationMemberListProvider.notifier,
    );
    final completeMemberNotifier = ref.watch(completeMemberProvider.notifier);
    final membershipNotifier = ref.watch(membershipProvider.notifier);
    final associationMemberSortedList = ref.watch(
      associationMemberSortedListProvider,
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    AppLocalizations localizeWithContext = AppLocalizations.of(context)!;

    return PhonebookTemplate(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Refresher(
        controller: ScrollController(),
          onRefresh: () {
            return tokenExpireWrapper(ref, () async {
              await associationMemberListNotifier.loadMembers(
                association.id,
                association.mandateYear,
              );
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizeWithContext.phonebookMembers(association.name),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (!association.deactivated) ...[
                SizedBox(height: 20),
                ListItemTemplate(
                  icon: const HeroIcon(
                    HeroIcons.plus,
                    size: 40,
                    color: Colors.black,
                  ),
                  title: localizeWithContext.phonebookAddMember,
                  trailing: SizedBox.shrink(),
                  onTap: () async {
                    completeMemberNotifier.setCompleteMember(
                      CompleteMember.empty(),
                    );
                    membershipNotifier.setMembership(
                      Membership.empty().copyWith(
                        associationId: association.id,
                      ),
                    );
                    if (QR.currentPath.contains(PhonebookRouter.admin)) {
                      QR.to(
                        PhonebookRouter.root +
                            PhonebookRouter.admin +
                            PhonebookRouter.editAssociationMembers +
                            PhonebookRouter.addEditMember,
                      );
                    } else {
                      QR.to(
                        PhonebookRouter.root +
                            PhonebookRouter.associationDetail +
                            PhonebookRouter.editAssociationMembers +
                            PhonebookRouter.addEditMember,
                      );
                    }
                  },
                ),
              ],
              AsyncChild(
                value: associationMemberList,
                builder: (context, associationMembers) =>
                    associationMembers.isEmpty
                    ? Text(localizeWithContext.phonebookNoMember)
                    : !association.deactivated
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ReorderableListView(
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
                                  localizeWithContext.phonebookMemberReordered,
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  localizeWithContext.phonebookReorderingError,
                                );
                              }
                            });
                          },
                          children: associationMemberSortedList
                              .map(
                                (member) => MemberCard(
                                  deactivated: false,
                                  key: ValueKey(member.member.id),
                                  member: member,
                                  association: association,
                                  editable: true,
                                ),
                              )
                              .toList(),
                        ),
                      )
                    : Column(
                        children: associationMemberSortedList
                            .map(
                              (e) => MemberCard(
                                deactivated: true,
                                member: e,
                                association: association,
                                editable: true,
                              ),
                            )
                            .toList(),
                      ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
