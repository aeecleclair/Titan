import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/user_association_membership.dart';
import 'package:myecl/admin/providers/association_membership_members_list_provider.dart';
import 'package:myecl/admin/providers/user_association_membership_provider.dart';
import 'package:myecl/admin/router.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/delete_button.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/edition_button.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';

class MemberEditableCard extends HookConsumerWidget {
  const MemberEditableCard({
    super.key,
    required this.associationMembership,
  });

  final UserAssociationMembership associationMembership;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationMembershipMemberListNotifier =
        ref.watch(associationMembershipMembersProvider.notifier);
    final userAssociationMembershipNotifier =
        ref.watch(userAssociationMembershipProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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
                Text(
                  associationMembership.startDate.toString().split(" ")[0],
                ),
                Text(
                  associationMembership.endDate.toString().split(" ")[0],
                ),
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
                AdminRouter.root +
                    AdminRouter.detailAssociationMembership +
                    AdminRouter.addEditMember,
              );
            },
          ),
          const SizedBox(width: 10),
          DeleteButton(
            deactivated: false,
            deletion: true,
            onDelete: () async {
              final result = await associationMembershipMemberListNotifier
                  .deleteMember(associationMembership);
              if (result) {
                displayToastWithContext(
                  TypeMsg.msg,
                  PhonebookTextConstants.deletedMember,
                );
              } else {
                displayToastWithContext(
                  TypeMsg.error,
                  PhonebookTextConstants.deletingError,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
