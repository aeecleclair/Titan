import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/class/membership.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/phonebook/providers/complete_member_provider.dart';
import 'package:titan/phonebook/providers/member_pictures_provider.dart';
import 'package:titan/phonebook/providers/member_role_tags_provider.dart';
import 'package:titan/phonebook/providers/membership_provider.dart';
import 'package:titan/phonebook/providers/profile_picture_provider.dart';
import 'package:titan/phonebook/providers/roles_tags_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/tools/function.dart';
import 'package:titan/phonebook/ui/pages/admin_page/delete_button.dart';
import 'package:titan/phonebook/ui/pages/admin_page/edition_button.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:qlevar_router/qlevar_router.dart';

class MemberEditableCard extends HookConsumerWidget {
  const MemberEditableCard({
    super.key,
    required this.member,
    required this.association,
    required this.deactivated,
  });

  final CompleteMember member;
  final Association association;
  final bool deactivated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilePictureNotifier = ref.watch(profilePictureProvider.notifier);
    final associationMemberListNotifier = ref.watch(
      associationMemberListProvider.notifier,
    );
    final roleTagsNotifier = ref.watch(rolesTagsProvider.notifier);
    final membershipNotifier = ref.watch(membershipProvider.notifier);
    final completeMemberNotifier = ref.watch(completeMemberProvider.notifier);
    final memberRoleTagsNotifier = ref.watch(memberRoleTagsProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final memberPictures = ref.watch(
      memberPicturesProvider.select((value) => value[member]),
    );
    final memberPicturesNotifier = ref.watch(memberPicturesProvider.notifier);

    Membership assoMembership = member.memberships.firstWhere(
      (memberships) =>
          memberships.associationId == association.id &&
          memberships.mandateYear == association.mandateYear,
      orElse: () => Membership.empty(),
    );

    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(),
        color: getColorFromTagList(
          ref,
          member.memberships
              .firstWhere(
                (element) =>
                    element.associationId == association.id &&
                    element.mandateYear == association.mandateYear,
              )
              .rolesTags,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: AutoLoaderChild(
              group: memberPictures,
              notifier: memberPicturesNotifier,
              mapKey: member,
              loader: (ref) =>
                  profilePictureNotifier.getProfilePicture(member.member.id),
              loadingBuilder: (context) => const CircleAvatar(
                radius: 20,
                child: CircularProgressIndicator(),
              ),
              dataBuilder: (context, data) =>
                  CircleAvatar(radius: 20, backgroundImage: data.first.image),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  "${(member.member.nickname ?? member.member.firstname)} - ${member.memberships.firstWhere((element) => element.associationId == association.id && element.mandateYear == association.mandateYear).apparentName}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  minFontSize: 10,
                  maxFontSize: 15,
                ),
                const SizedBox(height: 3),
                AutoSizeText(
                  member.member.nickname != null
                      ? "${member.member.firstname} ${member.member.name}"
                      : member.member.name,
                  minFontSize: 10,
                  maxFontSize: 15,
                ),
              ],
            ),
          ),
          EditionButton(
            deactivated: deactivated,
            onEdition: () async {
              roleTagsNotifier.resetChecked();
              roleTagsNotifier.loadRoleTagsFromMember(member, association);
              completeMemberNotifier.setCompleteMember(member);
              membershipNotifier.setMembership(assoMembership);
              memberRoleTagsNotifier.reset();
              if (QR.currentPath.contains(PhonebookRouter.admin)) {
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
            },
          ),
          const SizedBox(width: 10),
          DeleteButton(
            deactivated: deactivated,
            deletion: true,
            onDelete: () async {
              final result = await associationMemberListNotifier.deleteMember(
                member,
                member.memberships.firstWhere(
                  (element) =>
                      element.associationId == association.id &&
                      element.mandateYear == association.mandateYear,
                ),
              );
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
