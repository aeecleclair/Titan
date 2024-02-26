import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/phonebook/providers/edition_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/delete_button.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/edition_button.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/providers/profile_picture_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';

class MemberEditableCard extends HookConsumerWidget {
  const MemberEditableCard({super.key, required this.member});

  final CompleteMember member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilePicture = ref.watch(profilePictureProvider);
    final association = ref.watch(associationProvider);
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final associationMembersNotifier =
        ref.watch(associationMemberListProvider.notifier);
    final roleTagsNotifier = ref.watch(rolesTagsProvider.notifier);
    final editionNotifier = ref.watch(editionProvider.notifier);
    final completeMemberNotifier = ref.watch(completeMemberProvider.notifier);
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: profilePicture.when(
                data: (picture) {
                  return CircleAvatar(
                    radius: 20,
                    backgroundImage: picture.isEmpty
                        ? const AssetImage('assets/images/logo_alpha.png')
                        : Image.memory(picture).image,
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (e, s) {
                  return const Center(
                    child: Text("Error"),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 400,
              child: Column(
                children: [
                  Text(
                    "${member.member.name} ${member.member.firstname} (${member.member.nickname})",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    member.member.email,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
                member.memberships
                    .firstWhere(
                        (element) => element.association.id == association.id)
                    .apparentName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const Spacer(),
            EditionButton(onEdition: () async {
              roleTagsNotifier.resetChecked();
              roleTagsNotifier.loadRoleTagsFromMember(member, association);
              completeMemberNotifier.setCompleteMember(member);
              editionNotifier.setStatus(true);
              pageNotifier.setPhonebookPage(PhonebookPage.membershipEdition);
            }),
            const SizedBox(width: 10),
            DeleteButton(
              onDelete: () async {
                final result = await associationNotifier.deleteMember(
                    member.memberships.firstWhere(
                        (element) => element.association.id == association.id));
                await associationMembersNotifier.loadMembers(association.id);
                if (result) {
                  displayToastWithContext(
                      TypeMsg.msg, PhonebookTextConstants.deletedMember);
                } else {
                  displayToastWithContext(
                      TypeMsg.error, PhonebookTextConstants.deletingError);
                }
              },
            )
          ],
        ));
  }
}
