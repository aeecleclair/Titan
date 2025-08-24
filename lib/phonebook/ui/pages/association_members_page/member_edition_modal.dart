import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/class/membership.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/complete_member_provider.dart';
import 'package:titan/phonebook/providers/membership_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/tools/function.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/confirm_modal.dart';

class MemberEditionModal extends HookConsumerWidget {
  final CompleteMember member;
  final Membership membership;
  const MemberEditionModal({
    super.key,
    required this.member,
    required this.membership,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completeMemberNotifier = ref.watch(completeMemberProvider.notifier);
    final associationMemberListNotifier = ref.watch(
      associationMemberListProvider.notifier,
    );
    final association = ref.watch(associationProvider);
    final membershipNotifier = ref.watch(membershipProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    AppLocalizations localizeWithContext = AppLocalizations.of(context)!;

    return BottomModalTemplate(
      title:
          "${member.member.nickname ?? '${member.member.firstname} ${member.member.name}'} - ${membership.apparentName}",
      type: BottomModalType.main,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Button(
              text: localizeWithContext.phonebookEditRole,
              onPressed: () {
                Navigator.of(context).pop();
                completeMemberNotifier.setCompleteMember(member);
                membershipNotifier.setMembership(membership);
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
            SizedBox(height: 20),
            Button.danger(
              text: localizeWithContext.phonebookDeleteRole,
              onPressed: () {
                Navigator.of(context).pop();
                showCustomBottomModal(
                  context: context,
                  ref: ref,
                  modal: ConfirmModal.danger(
                    title: localizeWithContext.phonebookDeleteUserRole(
                      member.member.nickname ?? member.getName(),
                    ),
                    description: localizeWithContext.globalIrreversibleAction,
                    onYes: () async {
                      final result = await associationMemberListNotifier
                          .deleteMember(
                            member,
                            getMembershipForAssociation(member, association),
                          );
                      if (result) {
                        displayToastWithContext(
                          TypeMsg.msg,
                          localizeWithContext.phonebookDeletedMember,
                        );
                      } else {
                        displayToastWithContext(
                          TypeMsg.error,
                          localizeWithContext.phonebookDeletingError,
                        );
                      }
                    },
                    onNo: () => Navigator.of(context).pop(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
