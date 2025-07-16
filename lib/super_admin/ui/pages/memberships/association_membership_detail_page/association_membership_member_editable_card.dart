import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/super_admin/class/user_association_membership.dart';
import 'package:titan/super_admin/providers/association_membership_members_list_provider.dart';
import 'package:titan/super_admin/providers/user_association_membership_provider.dart';
import 'package:titan/super_admin/router.dart';
import 'package:titan/phonebook/ui/pages/admin_page/delete_button.dart';
import 'package:titan/phonebook/ui/pages/admin_page/edition_button.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class MemberEditableCard extends HookConsumerWidget {
  const MemberEditableCard({super.key, required this.associationMembership});

  final UserAssociationMembership associationMembership;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationMembershipMemberListNotifier = ref.watch(
      associationMembershipMembersProvider.notifier,
    );
    final userAssociationMembershipNotifier = ref.watch(
      userAssociationMembershipProvider.notifier,
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  (associationMembership.user.nickname ??
                      "${associationMembership.user.firstname} ${associationMembership.user.name}"),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  minFontSize: 10,
                  maxFontSize: 15,
                ),
                const SizedBox(height: 3),
                associationMembership.user.nickname != null
                    ? AutoSizeText(
                        "${associationMembership.user.firstname} ${associationMembership.user.name}",
                        minFontSize: 10,
                        maxFontSize: 15,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(associationMembership.startDate.toString().split(" ")[0]),
                Text(associationMembership.endDate.toString().split(" ")[0]),
              ],
            ),
          ),
          EditionButton(
            deactivated: false,
            onEdition: () async {
              userAssociationMembershipNotifier.setUserAssociationMembership(
                associationMembership,
              );
              QR.to(
                SuperAdminRouter.root +
                    SuperAdminRouter.associationMemberships +
                    SuperAdminRouter.detailAssociationMembership +
                    SuperAdminRouter.addEditMember,
              );
            },
          ),
          const SizedBox(width: 10),
          DeleteButton(
            deactivated: false,
            deletion: true,
            onDelete: () async {
              final deletedMemberMsg = AppLocalizations.of(
                context,
              )!.phonebookDeletedMember;
              final deleteMemberErrorMsg = AppLocalizations.of(
                context,
              )!.phonebookDeletingError;
              await tokenExpireWrapper(ref, () async {
                final result = await associationMembershipMemberListNotifier
                    .deleteMember(associationMembership);
                if (result) {
                  displayToastWithContext(TypeMsg.msg, deletedMemberMsg);
                } else {
                  displayToastWithContext(TypeMsg.error, deleteMemberErrorMsg);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
