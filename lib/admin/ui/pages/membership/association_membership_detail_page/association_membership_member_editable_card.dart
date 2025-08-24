import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/admin/class/user_association_membership.dart';
import 'package:titan/admin/providers/association_membership_members_list_provider.dart';
import 'package:titan/admin/providers/user_association_membership_provider.dart';
import 'package:titan/admin/router.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';

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

    final localization = AppLocalizations.of(
                        context,
                      )!;

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
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
                  overflow: TextOverflow.ellipsis,
                ),
                associationMembership.user.nickname != null
                    ? AutoSizeText(
                        "${associationMembership.user.firstname} ${associationMembership.user.name}",
                        minFontSize: 10,
                        maxFontSize: 15,
                        overflow: TextOverflow.ellipsis,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  DateFormat(
                    "dd/MM/yyyy",
                  ).format(associationMembership.startDate),
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  DateFormat(
                    "dd/MM/yyyy",
                  ).format(associationMembership.endDate),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          CustomIconButton.secondary(
            icon: const HeroIcon(
              HeroIcons.pencil,
              color: ColorConstants.tertiary,
            ),
            onPressed: () async {
              userAssociationMembershipNotifier.setUserAssociationMembership(
                associationMembership,
              );
              QR.to(
                AdminRouter.root +
                    AdminRouter.associationMemberships +
                    AdminRouter.detailAssociationMembership +
                    AdminRouter.addEditMember,
              );
            },
          ),
          const SizedBox(width: 10),
          CustomIconButton.danger(
            icon: HeroIcon(HeroIcons.trash, color: Colors.white),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return CustomDialogBox(
                    title: localization.adminDeleteAssociationMember,
                    descriptions:
                        localization.adminDeleteAssociationMemberConfirmation,
                    onYes: () async {
                      final deletedMemberMsg = localization.phonebookDeletedMember;
                      final deleteMemberErrorMsg = localization.phonebookDeletingError;
                      await tokenExpireWrapper(ref, () async {
                        final result =
                            await associationMembershipMemberListNotifier
                                .deleteMember(associationMembership);
                        if (result) {
                          displayToastWithContext(
                            TypeMsg.msg,
                            deletedMemberMsg,
                          );
                        } else {
                          displayToastWithContext(
                            TypeMsg.error,
                            deleteMemberErrorMsg,
                          );
                        }
                      });
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
